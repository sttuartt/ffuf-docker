#!/bin/bash

target="$1"

# Add /FUZZ if it is missing in the target
echo "Target URL: $target"
if [[ $target != *"FUZZ"* ]]; then
    echo $target | grep '/$'
    if [ $? -eq 1 ]; then
        target="${target}/"
    fi
    target="${target}FUZZ"
    echo "Changed target URL to: $target"
fi

set -x

# Scan
output_filename="/var/reports/ffuf_scan_$(date +"%FT%H%M")"
ffuf -w words_and_files_top5000.txt \
    -u $target \
    -H "X-Scanner: FFUF" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0" \
    -of all \
    -o ${output_filename} \
    -ac \
    ${@:2}

# Parse the report
python3 ffuf_qt.py
