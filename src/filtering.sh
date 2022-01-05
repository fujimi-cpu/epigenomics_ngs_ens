#Remove uninteresting sequences

workdir=~/mydatalocal/epigenomics_ngs_ens/processed_data/mapped

#Mark pcr duplicates

for f in $workdir/*.bam
do 
java -jar $PICARD MarkDuplicates \
      I=$f \
      O=${f/".bam"/"marked_duplicates.bam"}\
      M=${f/".bam"/"marked_dup_metrics.txt"}
done
#picard duplicate marks and removes duplicate regions

#Here are the regions that we want to keep, everything except the mitochondrial and chloroplastic genome
cd ~/mydatalocal/epigenomics_ngs_ens/data/supporting_data
grep -v -E "Mt|Pt" TAIR10_selectedRegions.bed > TAIR10_selectedRegions_nuc.bed
#grep allows you to search for lines in a file, Pt or Mt
#grep is a selection tool, it is used to remove the mitochondrial and chloroplast genome (select the opposite of the search with -v) and save it with >.

#remove duplicates 
dir_selected=~/mydatalocal/epigenomics_ngs_ens/data/supporting_data
workdir=~/mydatalocal/epigenomics_ngs_ens/processed_data/mapped
output_dir=~/mydatalocal/epigenomics_ngs_ens/processed_data/filtered

for f in $workdir/*duplicates.bam
do
  file_name="$(basename -- $f)" #basename allows you to retrieve the name of the file only
  #echo $file_name
  samtools view -b $f -L ${dir_selected}/TAIR10_selectedRegions_nuc.bed -F 1024 -f 3 -q 30 -o ${output_dir}/${file_name/".bam"/"_filtered.bam"} #on enregistre dans output_dir
done

#samtools to open bam files
#-F we remove the duplicates (of pcr)
#-f we remove the unpaired (we keep the paired)
#-q quality limit
