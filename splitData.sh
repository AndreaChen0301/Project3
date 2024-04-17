#!/bin/bash

module load R/R-3.6.1

input_file="/workspace/linmaneechot/steam_data/english_reviews.csv"
output_directory="/workspace/linmaneechot/steam_data/"

Rscript -e "data = read.csv('$input_file'); \
             data_split = split(data, cut(1:nrow(data), breaks = 10, label = FALSE)); \
             for (i in names(data_split)) { \
                 filename = paste0('$output_directory/output_', i, '.csv'); \
                 write.csv(data_split[[i]], filename, row.names = FALSE); \
             }"


