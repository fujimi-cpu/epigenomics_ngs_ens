
#Enlever les séquences inintéressantes
#



workdir=~/mydatalocal/epigenomics_ngs_ens/processed_data/mapped


for f in $workdir/*.bam
do 
java -jar $PICARD MarkDuplicates \
      I=$f \
      O=${f/".bam"/"marked_duplicates.bam"}\
      M=${f/".bam"/"marked_dup_metrics.txt"}
done