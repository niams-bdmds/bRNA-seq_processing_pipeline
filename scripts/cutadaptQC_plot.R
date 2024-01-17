# This script is written to generate two separate box plots
#setwd("/gpfs/gsfs12/users/regmib2/bio_data_mining//test_snake/TestRun/FASTQ/FASTQ_Cutadapt/Cutadapt_QC")
x <- read.table("cutadapt_qc.tsv", header = TRUE)
pdf("Boxplot_adapter_removed.pdf")
boxplot_adapters_removed <- boxplot(x$Trimmed_reads, ylim = c(0, max(x$Trimmed_reads)+1e6), main = paste("Number of adapters removed\nRunID:", basename(dirname(dirname(dirname(getwd()))))))
print(boxplot_adapters_removed)
dev.off()

pdf("Boxplot_percent_adapter_removed.pdf")
boxplot_percent_adapter_removed <- boxplot(x$Percent_trimmed, ylim = c(0, ceiling(max(x$Percent_trimmed))+5), main=paste("Percent adapters removed\nRun ID:", basename(dirname(dirname(dirname(getwd()))))))
print(boxplot_percent_adapter_removed)
dev.off()

y<-read.table("qc_table.txt", header = TRUE)
pdf("Distriubtion_of_read_pairs.pdf")
Distribution_of_read_pairs <- hist(y$number_read_pair_processed/1e6, xlim=c(0, 120), main = paste("Distribution of raw read counts\nDataset =", basename(dirname(dirname(dirname(getwd()))))),
xlab="Read pairs per sample (million)")
print(Distribution_of_read_pairs)
dev.off()

