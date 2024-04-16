#!/bin/bash

module load R/R-3.6.1

Rscript -e "data = read.csv('');\
data_split = split(data,cut(1:nrow(data), breaks =10, label = FALSE));\
for (i in names(data_split){;\
filename = paste0('output_',name,'.csv');\
write.csv(data_split[[i]], filename, row.names=FALSE)};"

