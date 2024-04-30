#!/bin/bash
rm -f slurm_out/slurm*
rm -f slurm*
mkdir -p slurm_out/
jobId1=$(sbatch --array=1-50 --output="slurm_out/slurm-%A_%a.out" --error="slurm_out/slurm-%A_%a.err" bagofwords.sh)
jobId1=$(echo $jobId1 | sed 's/Submitted batch job //')



