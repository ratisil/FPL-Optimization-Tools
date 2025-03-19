## Binary Files Generator Fixture Configuration

This file contains the binary file generator fixture configurations to be used by simulations.py for generating binary files. Note that this will only be used if "generate_binary_files" is set to true in regular_settings.json, otherwise simulations.py will assume the binary files already exist.


### Instructions

1. Set the fixtures in fplreview so there are no BGW/DGW, i.e. each team should have the fixtures as originally scheduled in their respective GW. Download that csv, name it fplreview_original.csv, and place it in the '../data' directory

2. Configure the DGW/BGW fixture settings for each binary file in the JSON section below (example provided). For each team, the key represents the target GW to move EV to (usually to become a DGW) while the value represenst the original GW to move the EV from (usually to become a BGW). For example in the sample configuration provided below, in fplreview_binary_1 EV will be moved from GW34 to GW33 for Bournemount, Man Utd, Man City, and Aston Villa - and from GW34 to GW36 for Newcastle and Ipswich.

3. To generate the binary files simply make sure "generate_binary_files" is set to true in regular_settings.json, set the corresponding binary weights, and run simulations.py with use_binaries=y.

### JSON Fixture Configuration

```json
{
    "fplreview_binary_1.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34" },
        "Brighton": { "33": "34" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34" }
    },
    "fplreview_binary_2.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34" },
        "Brighton": { "33": "34" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34", "36": "37" },
        "Aston Villa": { "33": "34" },
        "Bournemouth": { "36": "37" }
    },
    "fplreview_binary_3.csv": {
        "Southampton": { "33": "34" },
        "Fulham": { "33": "34" },
        "Brighton": { "33": "34" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34" }
    },
    "fplreview_binary_4.csv": {
        "Southampton": { "33": "34" },
        "Fulham": { "33": "34" },
        "Brighton": { "33": "34" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34", "36": "37" },
        "Aston Villa": { "33": "34" },
        "Bournemouth": { "36": "37" }
    },
    "fplreview_binary_5.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34" },
        "Brighton": { "33": "34", "36": "37" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34" },
        "Liverpool": { "36": "37" }
    },
    "fplreview_binary_6.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34", "36": "37" },
        "Brighton": { "33": "34" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34" },
        "Wolves": { "36": "37" }
    },
    "fplreview_binary_7.csv": {
        "Southampton": { "33": "34" },
        "Fulham": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34" },
        "Nott'm Forest": { "36": "34" },
        "Brentford": { "36": "34" }
    },
    "fplreview_binary_8.csv": {
        "Southampton": { "33": "34" },
        "Fulham": { "33": "34" },
        "Brighton": { "33": "34", "36": "37" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34" },
        "Liverpool": { "36": "37" }
    },
    "fplreview_binary_9.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34" },
        "Brighton": { "33": "34" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34", "36": "37" },
        "Spurs": { "36": "37" }
    },
    "fplreview_binary_10.csv": {
        "Southampton": { "33": "34" },
        "Fulham": { "33": "34", "36": "37" },
        "Brighton": { "33": "34" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34" },
        "Brentford": { "36": "37" }
    },
    "fplreview_binary_11.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34" },
        "Brighton": { "33": "34", "36": "37" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34", "36": "37" },
        "Aston Villa": { "33": "34" },
        "Bournemouth": { "36": "37" },
        "Liverpool": { "36": "37" }
    },
    "fplreview_binary_12.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34" },
        "Nott'm Forest": { "36": "34" },
        "Brentford": { "36": "34" }
    },
    "fplreview_binary_13.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34" }
    },
    "fplreview_binary_14.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34" },
        "Man City": { "33": "34", "36": "37" },
        "Aston Villa": { "33": "34" },
        "Bournemouth": { "36": "37" }
    },
    "fplreview_binary_15.csv": {
        "Southampton": { "33": "34" },
        "Fulham": { "33": "34" },
        "Brighton": { "33": "34" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34", "36": "37" },
        "Spurs": { "36": "37" }
    },   
    "fplreview_binary_16.csv": {
        "Southampton": { "33": "34" },
        "Fulham": { "33": "34" },
        "Man City": { "33": "34", "36": "37" },
        "Aston Villa": { "33": "34" },
        "Nott'm Forest": { "36": "34" },
        "Brentford": { "36": "34" },
        "Bournemouth": { "36": "37" }
    },      
    "fplreview_binary_17.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34", "36": "37" },
        "Brighton": { "33": "34" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34", "36": "37" },
        "Aston Villa": { "33": "34" },
        "Wolves": { "36": "37" },
        "Bournemouth": { "36": "37" }
    },
    "fplreview_binary_18.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34" },
        "Man City": { "33": "34", "36": "37" },
        "Aston Villa": { "33": "34" },
        "Bournemouth": { "36": "37" },
        "Nott'm Forest": { "36": "34" },
        "Brentford": { "36": "34" }
    },
    "fplreview_binary_19.csv": {
        "Southampton": { "33": "34" },
        "Fulham": { "33": "34" },
        "Man City": { "33": "34" },
        "Aston Villa": { "33": "34" }
    },
    "fplreview_binary_20.csv": {
        "Arsenal": { "33": "34" },
        "Crystal Palace": { "33": "34" },
        "Brighton": { "33": "34" },
        "West Ham": { "33": "34" },
        "Man City": { "33": "34", "36": "37" },
        "Aston Villa": { "33": "34", "36": "37" },
        "Spurs": { "36": "37" },
        "Bournemouth": { "36": "37" }
    }     
}
```
