#!/bin/bash
zip_dir="/workspace/linmaneechot"
csv_dir="/workspace/linmaneechot/steam_data"
csv_file="$csv_dir/all_reviews/all_review.csv"
if [ -f "$csv_file"  ]; then
   echo "all_reviews.csv already exists"
else
    unzip  $zip_dir/steam_data.zip -d  "$csv_dir"
fi







