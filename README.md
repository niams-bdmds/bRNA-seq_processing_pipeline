# Bulk RNA-seq analysis pipeline
This repository contains the rule files directory, script directory, FASTQ(empty)
directory, snakemake wrapper script, cluster.yml and config.yaml files. 
## How to run this pipeline
First, edit the config.yaml and cluster.yml files. The GTF file and STAR ref
genome files are configured via config.yaml file. Figure out how many jobs
are being processed for all samples being analyzed through dry run and edit the
wrapper script -j flag. The outputs of featureCout and HT-seq count are parsed
differently. Therefore, to generate count matrix, use the corresponding script
from the script directory. 
## How to feed the fq files
Put all fastq files in FASTQ/FASTQ`_`untrimmed directory. The input files
should be formatted as: {sample}_R1_oo1`_`fastq.gz. 
