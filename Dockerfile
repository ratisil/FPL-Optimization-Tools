# syntax=docker/dockerfile:1
FROM python:3.13-slim

ENV PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# minimal OS deps
RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && update-ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /fpl-optimization
# copy the repo (you can split COPY to leverage caching later if you want)
COPY . .

# ---- deps via uv (reads pyproject.toml + uv.lock) ----
RUN python -m pip install -U pip wheel uv \
 && uv sync --no-dev --frozen

# make the uv venv the default "python" on PATH
ENV VIRTUAL_ENV=/fpl-optimization/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# (optional) ensure HiGHS python wrapper is present if not already pulled
RUN pip install --only-binary=:all: -U highspy || true

# helpers
RUN printf '#!/bin/sh\ncd /fpl-optimization\nexec python -m run.solve "$@"\n' \
    > /usr/local/bin/solve && chmod +x /usr/local/bin/solve
RUN printf '#!/bin/sh\ncd /fpl-optimization\nexec env PYTHONPATH=/fpl-optimization/run:/fpl-optimization python -m run.run_parallel "$@"\n' \
    > /usr/local/bin/run_parallel && chmod +x /usr/local/bin/run_parallel

# non-root user + writable tmp
RUN useradd --create-home --shell /bin/bash app_user \
 && mkdir -p /fpl-optimization/run/tmp \
 && chown -R app_user /fpl-optimization
USER app_user

# keep container alive; you run manually
WORKDIR /fpl-optimization
CMD ["tail", "-f", "/dev/null"]
