#Enlever les séquences inintéressantes
#

workdir=~/mydatalocal/epigenomics_ngs_ens/processed_data/mapped

#Marquer les dupliqués  de pcr

for f in $workdir/*.bam
do 
java -jar $PICARD MarkDuplicates \
      I=$f \
      O=${f/".bam"/"marked_duplicates.bam"}\
      M=${f/".bam"/"marked_dup_metrics.txt"}
done

#Voila les régions qu'on veut garder, tout sauf le génome mitochondrial et chloroplastique
cd ~/mydatalocal/epigenomics_ngs_ens/data/supporting_data
grep -v -E "Mt|Pt" TAIR10_selectedRegions.bed > TAIR10_selectedRegions_nuc.bed
#grep permet de rechercher les lignes dans un fichier, Pt ou Mt, 

#enlevez les dupliqués 
dir_selected=~/mydatalocal/epigenomics_ngs_ens/data/supporting_data
workdir=~/mydatalocal/epigenomics_ngs_ens/processed_data/mapped
output_dir=~/mydatalocal/epigenomics_ngs_ens/processed_data/filtered

for f in $workdir/*duplicates.bam
do
  file_name="$(basename -- $f)" #basename permet de récupérer le nom du fichier seulement
  #echo $file_name
  samtools view -b $f -L ${dir_selected}/TAIR10_selectedRegions_nuc.bed -F 1024 -f 3 -q 30 -o ${output_dir}/${file_name/".bam"/"_filtered.bam"} #on enregistre dans output_dir
done

#samtools pour ouvrir les fichier bam
#-F on enlève les dupliqués (de pcr)
#-f on enlève les unpaired (on garde les paired)
#-q limite de qualité