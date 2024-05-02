#!/bin/bash

source_dir="/workspace/linmaneechot/q2"
dest_dir="/workspace/linmaneechot/q2/allData"

cat "$source_dir"/*.csv | tail -n +2  > "$dest_dir"/allData.csv

Rscript -e "data = read.csv('$dest_dir/allData.csv', header = FALSE); \
             data = na.omit(data)
             data[,1] = as.numeric(data[,1]); \
             data[,2] = as.numeric(data[,2]); \
             life_min = data[,1]; \
             helpful_score = data[,2]; \
             cor_q2 = as.character(cor(life_min, helpful_score)); \
             sum_lm_model = as.character(summary(lm(life_min~helpful_score))); \
             writeLines(cor_q2, paste0('$dest_dir','/cor_q2.txt')); \
             writeLines(sum_lm_model, paste0('$dest_dir','/summary_lm.txt')) \
"
