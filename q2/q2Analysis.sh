#!/bin/bash

source_dir="/workspace/linmaneechot/q2"
dest_dir="/workspace/linmaneechot/q2/allData"

cat "$source_dir"/*.csv | tail -n +2  > "$dest_dir"/allData.csv

