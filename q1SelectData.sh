#!/bin/bash

module load python/3.9.9

# Define the source and destination directories
source_dir="/workspace/linmaneechot/steam_data"
dest_dir="/workspace/linmaneechot/q1"

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
            writer.writerow([row[4], row[5], row[15], row[17]])
"
done

echo "Files have been processed and saved in p1"
