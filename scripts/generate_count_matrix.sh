#!/usr/bin/env bash
cd ReadCountsMatrix

for i in *.feature_count.txt
do
    tail -n +2 $i | cut -f 1 >> 0.ctt
    break
done

for file in *.feature_count.txt
do 
    file_name=`echo $file | sed -r 's/.{18}$//'`
    awk -F"\t" -v OFS="\t" '{print $7}' $file > "$file_name".c 
done

for file in *.c
do
    tail -n +3 $file > "$file"t
done

for file in *.ct
do
    file_name=`echo $file | sed -r 's/.{3}$//'`
    awk -F"\t" -v OFS="\t" -v FILENAME=$file_name 'BEGIN{print FILENAME} {print $1}' $file > "$file"t
done

paste *.ctt | column  -t > expression_matrix.txt

rm -rf *.c *.ct *.ctt
