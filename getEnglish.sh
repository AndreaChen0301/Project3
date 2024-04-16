#!/bin/bash                                                                                                           

# Set the file paths                                                                                                  
input_file="/workspace/linmaneechot/steam_data/all_reviews/all_reviews.csv"
output_file="/workspace/linmaneechot/steam_data/english_reviews.csv"

# Ensure the input file exists                                                                                        
if [ ! -f "$input_file" ]; then
    echo "Input file does not exist."
    exit 1
fi

awk -F, 'BEGIN {OFS=FS} $11 == "english" {print}' "$input_file" > "$output_file"

echo "Filtered data saved to $output_file."
