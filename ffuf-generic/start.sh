#!/bin/bash
set -x

ls -l
# Scan
output_filename="/var/reports/ffuf_scan_$(date +"%FT%H%M")"
ffuf -of all \
    -o ${output_filename} \
    ${@:1}

# Parse the report
python3 ffuf_qt.py
