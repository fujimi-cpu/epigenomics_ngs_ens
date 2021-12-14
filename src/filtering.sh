
#Enlever les séquences inintéressantes
#



workdir=~/mydatalocal/epigenomics_ngs_ens/processed_data/mapped

#Marquer les dupliqués 

for f in $workdir/*.bam
do 
java -jar $PICARD MarkDuplicates \
      I=$f \
      O=${f/".bam"/"marked_duplicates.bam"}\
      M=${f/".bam"/"marked_dup_metrics.txt"}
done

#enlevez les dupliqués 
dir_selected=~/mydatalocal/epigenomics_ngs_ens/data/supporting_data
workdir=~/mydatalocal/epigenomics_ngs_ens/processed_data/mapped
cd ~/mydatalocal/epigenomics_ngs_ens/processed_data/filtered

for f in $workdir/*duplicates.bam
do
  samtools view -b $f -L ${dir_selected}/TAIR10_selectedRegions_nuc.bed -F 1024 -f 3 -q 30 -o ${f/".bam"/"_filtered.bam"}
done


#-F on enlève les dupliqués
#-f on enlève les unpaired (on garde les paired)
#-q limite de qualité