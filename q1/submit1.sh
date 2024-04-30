#!/bin/bash

rm -f slurm_out/slurm*
mkdir -p slurm_out/

# Submit the first job (q1selectData.sh) and capture its job ID
jobId1=$(sbatch --output="slurm_out/slurm-%A_%a.out" --error="slurm_out/slurm-%A_%a.err" q1SelectData.sh)
jobId1=$(echo $jobId1 | sed 's/Submitted batch job //')

# Submit the second job (run_R.sh) dependent on the successful completion of the first job
jobId2=$(sbatch --array=1-50 \
		--dependency=afterok:$jobId1 \
		--output="slurm_out/slurm-%A_%a.out" \
		--error="slurm_out/slurm-%A_%a.err" \
		run_R.sh)
jobId2=$(echo $jobId2 | sed 's/Submitted batch job //')

jobId3=$(sbatch --dependency=afterok:$jobId2 --output="slurm_out/slurm-%A_%a.out" --error="slurm_out/slurm-%A_%a.err" merge.sh)
jobId3=$(echo $jobId3 | sed 's/Submitted batch job //')

echo "q1selectData.sh submitted as job $jobId1"
echo "run_R.sh submitted as job $jobId2"
echo "merge.sh submitted as job $jobId3"
