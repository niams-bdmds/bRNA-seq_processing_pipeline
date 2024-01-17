library(ggplot2)
x <- read.table("STAR_alignment/Alignment_QC/mapping_QC.txt", header = TRUE)
# Bam size plot
Mean<-round(mean(x$bam_size/1e9), digits = 2)
SD <- round(sd(x$bam_size/1e9), digits = 2)
Median <- round(median(x$bam_size/1e9), digits = 2)
pdf("BAM_size_histogram.pdf")
bam_size_histogram <- hist(x$bam_size/1e9, xlim = c(0, 20),
                           xlab="Size of BAM files, in GB", col = 'red',
                           main = paste("Distribution of BAM file sizes\nRunID: ",
                                        basename(getwd())))
mtext(paste("Mean = ", Mean, "GB\nSD =", SD, "GB\nMedian = ", Median,
            "GB"), side = 4, las = 1, line = -6)
print(bam_size_histogram)
dev.off()

# Uniquely mapped_reads plot
Mean <- round(mean(x$uniquely_mapped_reads/1e6), digits = 2)
SD <- round(sd(x$uniquely_mapped_reads/1e6), digits = 2)
Median <- round(median(x$uniquely_mapped_reads/1e6), digits = 2)
pdf("Uniquely_mapped_histogram.pdf")
uniquely_mapped_histogram <- ggplot(data = x, aes(x = uniquely_mapped_reads/1e6)) + 
    geom_histogram(binwidth = 5, color = "black", fill="red") + 
    labs(title = paste("Number of uniquely aligned read pairs per sample\nRunID: ",
    basename(getwd())), x = "Read pairs(million)", y = "Frequency")
    uniquely_mapped_histogram + 
    geom_text(aes(label = paste("Mean=", Mean, "million, ", " SD=", SD, ", Median=", Median)), 
    x = 60, y = 30, vjust = 0.8, hjust= 0, color = "black")
print(uniquely_mapped_histogram)
dev.off()

# Distribution of perecentage of uniquely mapped reads
Median <- round(median(x$percent_uniquely_mapped_reads), digits = 2)
pdf("Mapping_rates_box_plot.pdf")
uniquely_mapped_rates <- boxplot(x$percent_uniquely_mapped_reads, ylim = c(0, 100),
                                 main = paste("Box plot of overall mapping rates\nRunID: ",
                                              basename(getwd())))

mtext(paste("Median = ", Median), side = 4, las = 1, line = -6)
print(uniquely_mapped_rates)
dev.off()

# Distribution of percentage of multi mapped reads
Median <- round(median(x$percent_multi_mapped_reads), digits = 2)
pdf("Multimapper_box_plot.pdf")
multi_mapped_rates <- boxplot(x$percent_multi_mapped_reads, ylim = c(0, 100),
                              main = paste("Distribution of percentage of reads with multiple alignments\nRunID: ",
                                           basename(getwd())))

mtext(paste("Median = ", Median), side = 4, las = 1, line = -6)
print(multi_mapped_rates)
dev.off()

# Distribution of unmapped reads
Mean <- round(mean(x$number_of_unmapped_reads.too_short./1e6), digits = 2)
SD <- round(sd(x$number_of_unmapped_reads.too_short./1e6), digits = 2)
Median <- round(median(x$number_of_unmapped_reads.too_short./1e6), digits = 2)
pdf("unmapped_readpairs_too_short_histogram.pdf")
unmapped_histogram <- ggplot(data = x, aes(x = number_of_unmapped_reads.too_short./1e6)) + 
    geom_histogram(binwidth = 1, color = "black", fill="red") + 
    labs(title = paste("Unmapped_read_pairs(too short)\nRunID: ",
                        basename(getwd())), x = "Read pairs(million)", y = "Frequency")
    unmapped_histogram + 
    geom_text(aes(label = paste("Mean=", Mean, "million, ", " SD=", SD, ", Median=", Median)), 
              x = 6, y = 50, vjust = 0, hjust= 0.15, color = "black")
print(unmapped_histogram)
dev.off()



