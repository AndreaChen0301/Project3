#!/bin/bash

source_dir="/workspace/linmaneechot/steam_data"
dest_dir="/workspace/linmaneechot/q1"

for file in "$source_dir"/output_*.csv; do
    filenum=$(basename "$file" | sed 's/output_\([0-9]*\)\.csv/\1/')

    awk -F, -v OFS=',' '{print $5, $6, $16, $18}' "$file" > "$dest_dir/q1_$filenum.csv"
done

echo "Files have been processed and saved in $dest_dir"
