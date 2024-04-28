#!/bin/bash                                                                                                          
module load R/R-3.6.1

INPUT_PATH="/workspace/linmaneechot/q1/q1.csv"
OUTPUT_PATH="/workspace/linmaneechot/q1/predict.csv"

Rscript ./predict.R "$INPUT_PATH" "$OUTPUT_PATH"
