#!/usr/bin/env bash
mkdir gene_count
cp bam/*.gene-count.txt gene_count/.
cd gene_count

for i in *.gene-count.txt
do
    head -n -5 $i | cut -f 1 | sed '1 i gene_name' >> 0.ctt
    break
done

for file in *.gene-count.txt
do 
    file_name=`echo $file | sed -r 's/.{15}$//'`
    awk -F"\t" -v OFS="\t" '{print $3}' $file > "$file_name".c 
done

for file in *.c
do
    head -n -5 $file > "$file"t
done

for file in *.ct
do
    file_name=`echo $file | sed -r 's/.{3}$//'`
    awk -F"\t" -v OFS="\t" -v FILENAME=$file_name 'BEGIN{print FILENAME} {print $1}' $file > "$file"t
done

paste *.ctt | column  -t > expression_matrix.txt

#rm -rf *.c *.ct *.ctt
