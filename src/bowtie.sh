#Construction d'un index à partir d'un genome de référence
workdir=~/mydatalocal/epigenomics_ngs_ens/data/supporting_data
index_dir=~/mydatalocal/epigenomics_ngs_ens/data/supporting_data/index
mkdir -p $index_dir

cd $index_dir
bowtie2-build -f ${workdir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa TAIR10


workdir=~/mydatalocal/epigenomics_ngs_ens/processed_data/mapped

for f in ~/mydatalocal/epigenomics_ngs_ens/processed_data/trimmed_data/*1_paired.fastq.gz # for each sample
do
  input=${f%%1_paired.fastq.gz} # enlever suffixe
  output=${input/"trimmed_data/"/"mapped/"}
  echo $input 
  echo $output
  echo ${index_dir}
  bowtie2 -x ${index_dir}/TAIR10 -1 ${input}1_paired.fastq.gz -2 ${input}2_paired.fastq.gz -X 2000 --very-sensitive --threads 6 | samtools sort --output-fmt bam -o ${output}mapped_sorted.bam --threads 6
done



cd $workdir

for f in $workdir/*.bam
do 
samtools index $f
samtools idxstats $f
done

#Enlever les séquences inintéressantes
#





for f in $workdir/*.bam
do 
java -jar picard.jar MarkDuplicates \
      I=$f \
      O=${f/".bam"/"marked_duplicates.bam"}\
      M=${f/".bam"/"marked_dup_metrics.txt"}
done