import csv
import json
import logging
import os
import glob

data = {
    "vulnerabilities": []
}

def get_input_file(pattern):
    files = list(filter(os.path.isfile, glob.glob(pattern)))
    files.sort(key=lambda x: os.path.getmtime(x))
    return files[-1]

def get_output_file(input_file):
    base = os.path.splitext(input_file)[0]
    return f'{base.replace("scan","vulnerabilities")}.json'

input_file = get_input_file("/var/reports/ffuf_scan*.csv")
output_file = get_output_file(input_file)

try:
    with open(input_file, 'r') as csvfile:
        report_reader = csv.reader(csvfile)
        # Skip the header
        next(report_reader)
        for row in report_reader:
            data['vulnerabilities'].append({
                'title': 'Directory / File Detected',
                'description': row[1], # Full URL with fuzzed path
                'severity': "medium"
            })

    with open(output_file, 'w') as outfile:
        json.dump(data, outfile)
except FileNotFoundError:
    logging.error('Ffuf scan report not found')