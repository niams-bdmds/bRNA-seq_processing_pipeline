grep -ER 'Uniquely mapped reads %' STAR_alignment/*/Log.final.out | awk -F'[/]' '{print $2}' > 1_sample_name.t.txt
grep -w 'Number of input reads' STAR_alignment/*/Log.final.out | awk '{print $7}' > 6_number_of_input_reads.t.txt 
grep -ER 'Uniquely mapped reads %' STAR_alignment/*/Log.final.out | awk '{print $7}' | sed 's/%//' > 4_mapped_reads_percent.t.txt
grep -ER 'Uniquely mapped reads number' STAR_alignment/*/Log.final.out | awk '{print $7}' > 3_mapped_reads_number.t.txt
grep -ER '% of reads mapped to multiple loci' STAR_alignment/*/Log.final.out | awk '{print $10}' | sed 's/%//' > 5_multi_mapped.t.txt
ls -s --block-size=1 STAR_alignment/*.bam | awk '{print $1}' > 2_bam_size.t.txt
grep -w 'Number of reads unmapped: too short' STAR_alignment/*/Log.final.out | awk '{print $9}' > 7_number_of_unmapped_reads.t.txt
grep -w '% of reads unmapped: too short' STAR_alignment/*/Log.final.out | awk '{print $9}' | sed 's/%//' > 8_percent_unmapped_reads.t.txt
paste *.t.txt > mapping_qc.txt
awk -v OFS='\t' 'BEGIN {print "sample_name\tbam_size\tnumber_of_input_reads\tuniquely_mapped_reads\tpercent_uniquely_mapped_reads\tpercent_multi_mapped_reads\tnumber_of_unmapped_reads(too_short)\tpercent_unmapped_reads"}; \
{print $1, $2, $6, $3, $4, $5, $7, $8}' mapping_qc.txt > mapping_QC.txt
rm -rf mapping_qc.txt *.t.txt
