#!/bin/bash

# Define the input data file path
INPUT_FILE="/workspace/linmaneechot/steam_data/all_reviews/all_reviews.csv"

# Column number where the language is stored; assuming it is the second column
LANG_COL=11

# Skip the header row and read each subsequent line
tail -n +2 "$INPUT_FILE" | while IFS=, read -r line
do
  # Extract the language value
  lang=$(echo "$line" | cut -d',' -f$LANG_COL)

  # Remove spaces or special characters if necessary
  lang=$(echo "$lang" | tr -d ' ')

  if [ "$lang" = "english" ]; then
    continue
  fi

  # Define the output file path
  OUTPUT_FILE="/workspace/linmaneechot/steam_data/${lang}_review.csv"

  # Write the line to the corresponding language file, adding CSV header if file does not exist
  if [ ! -f "$OUTPUT_FILE" ]; then
    head -n 1 "$INPUT_FILE" > "$OUTPUT_FILE"
  fi
  echo "$line" >> "$OUTPUT_FILE"
done
