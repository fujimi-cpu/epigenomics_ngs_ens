
workingDir=/home/rstudio/mydatalocal/epigenomics_ngs_ens
outputDir=/home/rstudio/mydatalocal/epigenomics_ngs_ens/processed_data/macs2
ataDir=/home/rstudio/mydatalocal/epigenomics_ngs_ens/data/supporting_data

#gtf gives coordinates, gene name, orientation for comparison, filters the gtf before
#the file genome.gtf is the genome of Arabidopsis thaliana

gtf=${supdataDir}/Arabidopsis_thaliana.TAIR10.52.gtf
gtf_filtered=${gtf/.gtf/.filtered.gtf}
grep -v "^[MtPt]" ${gtf} | awk '{ if ($3=="gene") print $0 }' |\
awk ' BEGIN { FS=OFS="\t" } { split($9,a,";") ; match(a[1], /AT[0-9]G[0-9]+/) ; id=substr(a[1],RSTART,RLENGTH) ; print $1,$4,$5,id,$7 }' |\
sort -k1,1 -k2,2n > ${gtf_filtered}
#on garde seulement les gènes 

for f in ${workingDir}/processed_data/macs2/*.broadPeak
do
echo $f
bedtools closest -a $f -b ${gtf_filtered} -D ref > ${f/_peaks.broadPeak/}.nearest.genes.txt
done
#bedtools is a practical software for operations on reads and sequences

bedtools intersect -a ${workingDir}/processed_data/uploaded_broadpeak/2020_374_S4.corrected_peaks.broadPeak -b ${workingDir}/processed_data/uploaded_broadpeak/2019_007_S7_R_peaks.broadPeak > ${f/_peaks.broadPeak/}.nearest.genes.txt


for f in ${workingDir}/processed_data/uploaded_broadpeak/*.broadPeak
do
echo $f
bedtools closest -a $f -b ${gtf_filtered} -D ref > ${f/_peaks.broadPeak/}.nearest.genes.txt
done

#compare with bedtools intersect each WOX5 file so quiescent strains with 374 of the root
annotationsDir=/home/rstudio/mydatalocal/epigenomics_ngs_ens/processed_data/analysis
mkdir -p $annotationsDir
#Compare two datasts: whole root and quiescent cells
WOX5=2019_007_S7_R.nearest.genes.txt
racine=2020_374_S4.corrected_.nearest.genes.txt
head ${workingDir}/processed_data/macs2/$WOX5
head ${workingDir}/processed_data/macs2/$racine
bedtools intersect -v -a ${workingDir}/processed_data/macs2/$WOX5 -b ${workingDir}/processed_data/macs2/$racine > $annotationsDir/${WOX5/.nearest.genes.txt/}_${racine/.nearest.genes.txt/}_difference.txt

wc -l $annotationsDir/${WOX5/.nearest.genes.txt/}_${racine/.nearest.genes.txt/}_difference.txt


echo $annotationsDir/${WOX5/.nearest.genes.txt/}_${racine/.nearest.genes.txt/}_difference.txt

#Now we merge the two conditions with bedtools merge

bedtools merge –i ${workingDir}/processed_data/macs2/$WOX5 ${workingDir}/processed_data/macs2/$racine > $annotationsDir/${WOX5/.nearest.genes.txt/}_${racine/.nearest.genes.txt/}_union.txt

bedtools unionbedg -i ${workingDir}/processed_data/macs2/$WOX5 ${workingDir}/processed_data/macs2/$racine > $annotationsDir/${WOX5/.nearest.genes.txt/}_${racine/.nearest.genes.txt/}union.txt

WOX5=${workingDir}/processed_data/uploaded_broadpeak/2019_007_S7_R_peaks.broadPeak
WR=${workingDir}/processed_data/uploaded_broadpeak/2020_374_S4.corrected_peaks.broadPeak


WOX5=${workingDir}/processed_data/macs2/2019_007_S7_R_peaks.broadPeak
WR=${workingDir}/processed_data/uploaded_broadpeak/2020_374_S4.corrected_peaks.broadPeak


head $WR
echo $WR
bedtools unionbedg -i $WOX5 $WR > $annotationsDir/2019_007_S7_R_2020_374_S4_union.txt

touch $annotationsDir/2019_007_S7_R_2020_374_S4_union.bed
cat $WOX5 >> $annotationsDir/2019_007_S7_R_2020_374_S4_union.bed
cat $WR >> $annotationsDir/2019_007_S7_R_2020_374_S4_union.bed

sort -k1,1 -k2,2n $annotationsDir/2019_007_S7_R_2020_374_S4_union.bed > $annotationsDir/2019_007_S7_R_2020_374_S4_union_sorted.bed
bedtools merge -c 4 -o "collapse" -i $annotationsDir/2019_007_S7_R_2020_374_S4_union_sorted.bed > $annotationsDir/2019_007_S7_R_2020_374_S4_union_sorted_merged.bed

grep -v -E "C" $annotationsDir/2019_007_S7_R_2020_374_S4_union_sorted_merged.bed > tmp && mv tmp $annotationsDir/2019_007_S7_R_2020_374_S4_union_sorted_merged.bed


WOX5bam=${workingDir}/processed_data/filtered/2019_007_S7_Rmapped_sortedmarked_duplicates_filtered.bam
WRbam=${workingDir}/processed_data/filtered/2020_374_S4_Rmapped_sortedmarked_duplicates_filtered.bam

#bedtools coverage -split -a $annotationsDir/2019_007_S7_R_2020_374_S4_union_sorted_merged.bed -b $WOX5bam $WR5bam > $annotationsDir/2019_007_S7_R_2020_374_S4_coverage.txt

bedtools coverage -counts -a $annotationsDir/2019_007_S7_R_2020_374_S4_union_sorted_merged.bed -b $WOX5bam  > $annotationsDir/2019_007_S7_R_coverage.txt
bedtools coverage -a $annotationsDir/2019_007_S7_R_2020_374_S4_union_sorted_merged.bed -b $WRbam > $annotationsDir/2020_374_S4_coverage.txt

bedtools closest -a $annotationsDir/2019_007_S7_R_2020_374_S4_union_sorted_merged.bed

for f in $annotationsDir/*coverage.txt
do
echo ${f/_coverage.txt/}.nearest.genes.txt
bedtools closest -a $f -b ${gtf_filtered} -D ref > ${f/_coverage.txt/}.nearest.genes.txt
done

