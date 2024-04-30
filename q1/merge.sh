#!/bin/bash

DIR="/workspace/linmaneechot/q1"

OUTPUT_FILE="${DIR}/predict.csv"

# Check if any predict_*.csv files exist
shopt -s nullglob
csv_files=(${DIR}/predict_*.csv)

if [ ${#csv_files[@]} -eq 0 ]; then
  echo "No 'predict_*.csv' files to merge."
  exit 1
fi

# Use the first file to get the header
head -1 "${csv_files[0]}" > "$OUTPUT_FILE"

for file in "${csv_files[@]}"; do
  tail -n +2 "$file"
done >> "$OUTPUT_FILE"

echo "Files merged into $OUTPUT_FILE"
