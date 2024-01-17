#!/bin/bash
for file in FastQC/*.zip
  do
    base_file_name=`echo $file | sed -r 's/.{4}$//'`
    unzip -qo $file -d FastQC
    sed -n '/>>Overrepresented sequences/ ,/>>END_MODULE/p' "$base_file_name"/fastqc_data.txt \
    | sort -k3 -r | head -3 | tail -1 | awk '{print $3}'  >> over_rep_seq.txt
        
    sed -n '/>>Per base sequence quality/ ,/>>END_MODULE/p' "$base_file_name"/fastqc_data.txt \
    | sort -k3 -n | head -4 | tail -1 | awk '{print $3}' >> per_base_sequence_quality.txt
        
    sed -n '/>>Per base sequence quality/ ,/>>END_MODULE/p' "$base_file_name"/fastqc_data.txt \
    | sort -k4 -n | head -4 | tail -1 | awk '{print $4}' >> per_base_quality_lower_quantile.txt
        
    grep 'Per base sequence quality' "$base_file_name"/summary.txt >> summary_per_base_quality.txt
        
    sed -n '/>>Per sequence quality / ,/>>END_MODULE/p' "$base_file_name"/fastqc_data.txt | tail -2 \
    | head -1 >> per_seq_quality_peak.txt
    
    grep 'Per sequence quality scores' "$base_file_name"/summary.txt >> summary_per_seq_quality.txt
        
  done

paste *.txt | column -t > fastQC.tsv
awk -v OFS="\t" 'BEGIN {print "Sample", "Overrepresented_sequences_max_%", \
"Per_base_sequence_quality_median_min_value", "Per_base_sequence_quality_lower_quartile_min_value", \
"Peak_quality", "Per_sequence_quality_scores_distribution_peak_count", "Per_base_sequence_quality", "Per_sequence_quality_scores"} \
{print $11, $1, $2, $3, $4, $5, $6, $12}' fastQC.tsv > fastQC_QC_table.tsv
mv fastQC_QC_table.tsv FastQC/.
rm -rf over_rep_seq.txt per_base_sequence_quality.txt per_base_quality_lower_quantile.txt \
summary_per_base_quality.txt summary_per_seq_quality.txt per_seq_quality_peak.txt fastQC.tsv
