#!/bin/bash                                                                                                          
module load R/R-3.6.1

split=$SLURM_ARRAY_TASK_ID

INPUT_PATH="/workspace/linmaneechot/q1/q1_${split}.csv"
OUTPUT_PATH="/workspace/linmaneechot/q1/predict_${split}.csv"

Rscript ./predict.R "$INPUT_PATH" "$OUTPUT_PATH"

echo "done running predict.sh"
