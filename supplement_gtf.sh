cat Taxus3.gtf | while read line
do
    strand=$(echo $line | awk '{print $7}');
    if [ "$strand" == "+" ]; then
        type=$(echo $line | awk '{print $3}')
        id_init=$(echo $line | awk '{print $9}')
        gene_id=$(echo $id_init | awk '{split($0,lst,"[=;]");print lst[2]}')
        if [ "$type" == "mRNA" ]; then			
            start_5=$[$(echo $line | awk '{print $4}')-501]
            end_5=$[$(echo $line | awk '{print $4}')-1]
            start_3=$[$(echo $line | awk '{print $5}')+1]
            end_3=$[$(echo $line | awk '{print $5}')+501]
            mRNA_end=$(echo $line | awk '{print $5}')
            echo $line | awk '{print $1"\t"$2"\t""gene""\t""'$start_5'""\t""'$end_3'""\t"$6"\t"$7"\t"$8"\t""gene_id \"""'$gene_id'""\";"}' OFS="\t"
            echo $line | awk '{print $1"\t"$2"\t""transcript""\t""'$start_5'""\t""'$end_3'""\t"$6"\t"$7"\t"$8"\t""gene_id \"""'$gene_id'""\";""transcript_id \"""'$gene_id'"".1""\";"}'
            echo $line | awk '{print $1"\t"$2"\t""five_prime_UTR""\t""'$start_5'""\t""'$end_5'""\t"$6"\t"$7"\t"$8"\t""gene_id \"""'$gene_id'""\""";""transcript_id \"""'$gene_id'"".1""\";"}'
        else
            CDS_end=$(echo $line | awk '{print $5}')
            echo $line | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t""gene_id \"""'$gene_id'""\""";""transcript_id \"""'$gene_id'"".1""\";"}'
            if [ "$CDS_end" == "$mRNA_end" ]; then
                echo $line | awk '{print $1"\t"$2"\t""three_prime_UTR""\t""'$start_3'""\t""'$end_3'""\t"$6"\t"$7"\t"$8"\t""gene_id \"""'$gene_id'""\""";""transcript_id \"""'$gene_id'"".1""\";"}'
            fi
        fi
    else
        type_ad=$(echo $line | awk '{print $3}')
        id_init_ad=$(echo $line | awk '{print $9}')
        gene_id_ad=$(echo $id_init_ad | awk '{split($0,lst,"[=;]");print lst[2]}')
        if [ "$type_ad" == "mRNA" ]; then
            start_ad_5=$[$(echo $line | awk '{print $5}')+1]
            end_ad_5=$[$(echo $line | awk '{print $5}')+501]
            start_ad_3=$[$(echo $line | awk '{print $4}')-501]
            end_ad_3=$[$(echo $line | awk '{print $4}')-1]
            mRNA_end=$(echo $line | awk '{print $5}')
            echo $line | awk '{print $1"\t"$2"\t""gene""\t""'$start_ad_3'""\t""'$end_ad_5'""\t"$6"\t"$7"\t"$8"\t""gene_id \"""'$gene_id_ad'""\";"}'
            echo $line | awk '{print $1"\t"$2"\t""transcript""\t""'$start_ad_3'""\t""'$end_ad_5'""\t"$6"\t"$7"\t"$8"\t""gene_id \"""'$gene_id_ad'""\";""transcript_id \"""'$gene_id_ad'"".1""\";"}'
            echo $line | awk '{print $1"\t"$2"\t""five_prime_UTR""\t""'$start_ad_5'""\t""'$end_ad_5'""\t"$6"\t"$7"\t"$8"\t""gene_id \"""'$gene_id_ad'""\""";""transcript_id \"""'$gene_id_ad'"".1""\";"}'
        else
            CDS_end=$(echo $line | awk '{print $5}')
            echo $line | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t""gene_id \"""'$gene_id_ad'""\""";""transcript_id \"""'$gene_id_ad'"".1""\";"}'
            if [ "$CDS_end" == "$mRNA_end" ]; then
                echo $line | awk '{print $1"\t"$2"\t""three_prime_UTR""\t""'$start_ad_3'""\t""'$end_ad_3'""\t"$6"\t"$7"\t"$8"\t""gene_id \"""'$gene_id_ad'""\""";""transcript_id \"""'$gene_id_ad'"".1""\";"}'
            fi
        fi
    fi
done