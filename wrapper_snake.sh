#!/bin/bash
module load snakemake/6.8.2; 
snakemake -s snakemake -j 810 --latency-wait 200 --cluster-config=cluster.yml --cluster "sbatch --gres=lscratch:500 --time=10:00:00 --cpus-per-task={threads} --mem={params.mem} --partition={cluster.partition} " 2>snake.error
