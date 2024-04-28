#!/bin/bash

module load python/3.9.9

# Define the source and destination directories
source_dir="/workspace/linmaneechot/steam_data"
dest_dir="/workspace/linmaneechot/q1"

if [[ -f "$dest_dir/q1.csv" ]] && ls "$dest_dir/q1_"*.csv 1> /dev/null 2>&1; then
    echo "Files q1.csv and q1_*.csv already exist in $dest_dir, no action taken."
    exit 0
fi

for file in "$source_dir"/output_*.csv; do
    filenum=$(basename "$file" | sed 's/output_\([0-9]*\)\.csv/\1/')

    python3 -c "
import csv

input_file = '$file'
output_file = '$dest_dir/q1_$filenum.csv'

with open(input_file, newline='', mode='r') as infile, \
     open(output_file, 'w', newline='') as outfile:
    reader = csv.reader(infile)
    writer = csv.writer(outfile)

    for row in reader:
        if len(row) > 18:
            writer.writerow([row[0], row[4], row[5], row[8], row[11], row[15], row[16], row[17]])
"
done

cat "$dest_dir"/q1_*.csv > "$dest_dir/q1.csv"

echo "Files have been processed and saved in q1"
