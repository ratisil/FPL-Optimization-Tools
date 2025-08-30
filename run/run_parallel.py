import os
import json
from concurrent.futures import ProcessPoolExecutor

import pandas as pd

# When run as "python -m run.run_parallel" from repo root,
# these import the local run/ modules.
from solve import solve_regular
from utils import get_dict_combinations


def _cpu_default():
    # Be safe on small devices
    c = os.cpu_count() or 1
    return max(1, c - 2)


def _load_overrides():
    """
    Load overrides from JSON.
    Default path: /fpl-optimization/data/parallel_settings.json
    You can change with env PARALLEL_SETTINGS.
    """
    cfg_path = os.environ.get(
        "PARALLEL_SETTINGS",
        "/fpl-optimization/data/parallel_settings.json",
    )
    if not os.path.exists(cfg_path):
        return {}, None
    try:
        with open(cfg_path, "r", encoding="utf-8") as f:
            data = json.load(f)
        return (data if isinstance(data, dict) else {}), cfg_path
    except Exception as e:
        print(f"[run_parallel] WARNING: failed to load {cfg_path}: {e}")
        return {}, cfg_path


def run_parallel_solves(chip_combinations, max_workers=None, options=None, output_csv="chip_solve.csv"):
    if max_workers is None:
        max_workers = _cpu_default()

    if options is None:
        options = {
            "verbose": False,
            "print_result_table": False,
            "print_decay_metrics": False,
            "print_transfer_chip_summary": False,
            "print_squads": False,
        }

    args = [{**options, **combination} for combination in chip_combinations]

    # Run in parallel
    with ProcessPoolExecutor(max_workers=max_workers) as executor:
        results = list(executor.map(solve_regular, args))

    # Concatenate results to a table
    df = pd.concat(results).sort_values(by="score", ascending=False).reset_index(drop=True)
    if "iter" in df.columns:
        df = df.drop("iter", axis=1)
    print(df)

    # Save results
    df.to_csv(output_csv, encoding="utf-8", index=False)
    print(f"[run_parallel] Wrote {output_csv} ({len(df)} rows)")


if __name__ == "__main__":
    # === Defaults (used if no JSON override present) ===
    chip_gameweeks = {
        "use_bb": [None, 1, 2],
        "use_wc": [],
        "use_fh": [None, 2, 3, 4],
        "use_tc": [],
    }
    max_workers = _cpu_default()
    options = {
        "verbose": False,
        "print_result_table": False,
        "print_decay_metrics": False,
        "print_transfer_chip_summary": False,
        "print_squads": False,
    }
    output_csv = "chip_solve.csv"

    # === Load overrides from JSON (optional) ===
    overrides, used_path = _load_overrides()
    if overrides:
        # chip_gameweeks override
        if "chip_gameweeks" in overrides and isinstance(overrides["chip_gameweeks"], dict):
            cg = overrides["chip_gameweeks"]
            for k in ("use_bb", "use_wc", "use_fh", "use_tc"):
                if k in cg:
                    chip_gameweeks[k] = cg[k]

        # max_workers override
        if "max_workers" in overrides:
            try:
                mw = int(overrides["max_workers"])
                if mw >= 1:
                    max_workers = mw
            except Exception:
                pass

        # options override (merge)
        if "options" in overrides and isinstance(overrides["options"], dict):
            options.update(overrides["options"])

        # output_csv override
        if "output_csv" in overrides and isinstance(overrides["output_csv"], str) and overrides["output_csv"]:
            output_csv = overrides["output_csv"]

        print(f"[run_parallel] Loaded overrides from {used_path}")

    # Build combinations and run
    combinations = get_dict_combinations(chip_gameweeks)
    run_parallel_solves(combinations, max_workers=max_workers, options=options, output_csv=output_csv)
