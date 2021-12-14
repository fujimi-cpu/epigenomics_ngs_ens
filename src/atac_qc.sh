#!/bin/bash
#
# Compute basic quality metrics for ATAC-seq data
# 


# >>> change the value of the following variables

# General variables


workingDir=/home/rstudio/mydatalocal/epigenomics_ngs_ens
scriptDir=/home/rstudio/mydatalocal/epigenomics_ngs_ens/src
outputDir=${workingDir}/processed_data/ATAC_QC


ID=2019_007_S7_R # sample ID
ID=2020_372 # sample ID
ID=SRR4000473_ # sample ID
ID=2019_007_S7_R # sample ID
ID=2020_374_S4_R

bam_suffix=mapped_sortedmarked_duplicates_filtered.bam

for f in ${workingDir}/processed_data/filtered/*filtered.bam
do
idbase="$(basename -- $f)"
echo $idbase
ID="${idbase//$bam_suffix/}"
echo $ID


gtf=${workingDir}/data/supporting_data/Arabidopsis_thaliana.TAIR10.52.gtf #information des s"quences du génome (gene, exons, transposons...)"
selected_regions=${workingDir}/data/supporting_data/TAIR10_selectedRegions_nuc.bed #on sélectionne le séquences du génome nucléaire
genome=${workingDir}/data/supporting_data/TAIR10_ChrLen.txt #longueur des chromosomes

# Variables for TSS enrichment
width=1000
flanks=100

# Variables for insert size distribution
chrArabido=${workingDir}/data/supporting_data/TAIR10_ChrLen.bed
grep -v -E "Mt|Pt" ${chrArabido} > ${workingDir}/data/supporting_data/TAIR10_ChrLen_1-5.bed  #on enlève les génomes mt et pt
chrArabido=${workingDir}/data/supporting_data/TAIR10_ChrLen_1-5.bed



#////////////////////// Start of the script

mkdir -p ${outputDir}

bam=${workingDir}/processed_data/filtered/${ID}${bam_suffix}
#bam=$f
samtools view ${bam} | head 
#on vérifie qu'on a sélectionné le bon fichier


# ------------------------------------------------------------------------------------------------------------ #
# --------------------------- Compute TSS enrichment score based on TSS annotation --------------------------- #
# ------------------------------------------------------------------------------------------------------------ #

#1. Define genomic regions of interest
echo "-------------------------- Define genomic regions of interest"
#on enlève le génome mt et pt, on récupère les tss
#extraire le nom du gène
#unique permet d'éviter les genes dupliqués
#bedtools outil de bioinfo permettant de manipuler les ficiers .bad .bam ect
#$7==+ on vérifie l'orientation du gene forward backward pour regarder si on garde 
#awk modifier les tableaux en bash
grep -v "^[MtPt]" ${gtf} | awk '{ if ($3=="gene") print $0 }'  |\
grep "protein_coding" |\
awk ' BEGIN { FS=OFS="\t" } { split($9,a,";") ; match(a[1], /AT[0-9]G[0-9]+/) ; id=substr(a[1],RSTART,RLENGTH) ; if ($7=="+") print $1,$4,$4,id,$7 ; else print $1,$5,$5,id,$7 } ' |\
uniq | bedtools slop -i stdin -g ${genome} -b ${width} > ${outputDir}/tss_${width}.bed
#chromosome start stop gene
#on decoupe la colone 9 des; et on stock dans a

#bedtools intersect
#on sélectionne les régions qu'on à sélectionner au préalable dans le génome de a.t comme 
bedtools intersect -u -a ${outputDir}/tss_${width}.bed -b ${selected_regions} > ${outputDir}/tmp.tss && mv ${outputDir}/tmp.tss ${outputDir}/tss_${width}.bed
echo `cat ${outputDir}/tss_${width}.bed | wc -l` "roi defined from" ${gtf}

tssFile=${outputDir}/tss_${width}.bed
head ${tssFile}


#2. Compute TSS enrichment
echo "-------- Compute per-base coverage around TSS"

sort -k1,1 -k2,2n ${tssFile} > ${tssFile/".bed"/".sorted.bed"}
#permet d'accélerer le coverage

bedtools coverage -sorted -a ${tssFile/".bed"/".sorted.bed"} -b ${bam} -d > ${outputDir}/${ID}_tss_depth.txt
#On regarde le coverage des reads sur nos régions enregistrées autour du tss
awk -v w=${width} ' BEGIN { FS=OFS="\t" } { if ($5=="-") $6=(2*w)-$6+1 ; print $0 } ' ${outputDir}/${ID}_tss_depth.txt > ${outputDir}/${ID}_tss_depth.reoriented.txt
#on change la sixième colonne pour les gène dont le tss est en 3' (if ($5=="-")), on réoriente donc la numérotation ($6=(2*w)-$6+1)

#on trie
sort -n -k 6 ${outputDir}/${ID}_tss_depth.reoriented.txt > ${outputDir}/${ID}_tss_depth.sorted.txt

bedtools groupby -i ${outputDir}/${ID}_tss_depth.sorted.txt -g 6 -c 7 -o sum > ${outputDir}/${ID}_tss_depth_per_position.sorted.txt
#additione les différents tss

norm_factor=`awk -v w=${width} -v f=${flanks} '{ if ($6<f || $6>(2*w-f)) sum+=$7 } END { print sum/(2*f) } ' ${outputDir}/${ID}_tss_depth.sorted.txt`
echo "Nf: " ${norm_factor}
awk -v w=${width} -v f=${flanks} '{ if ($1>f && $1<(2*w-f)) print $0 }' ${outputDir}/${ID}_tss_depth_per_position.sorted.txt | awk -v nf=${norm_factor} -v w=${width} 'BEGIN { OFS="\t" } { $1=$1-w ; $2=$2/nf ; print $0 }' > ${outputDir}/${ID}_tss_depth_per_position.normalized.txt
Rscript ${scriptDir}/plot_tss_enrich.R -f ${outputDir}/${ID}_tss_depth_per_position.normalized.txt -w ${width} -o ${outputDir}  




# ---------------------------------------------------------------------------------------- #
# ------------------------------- Insert size distribution ------------------------------- #
# ---------------------------------------------------------------------------------------- #

echo "-------- Compute insert size distribution"
samtools view -f 3 -F 16 -L ${chrArabido} -s 0.25 ${bam} | awk ' function abs(v){ return v < 0 ? -v : v } { print abs($9) } ' | sort -g | uniq -c | sort -k2 -g > ${outputDir}/${ID}_TLEN_1-5.txt
#count the length of reads
Rscript ${scriptDir}/plot_tlen.R -f ${outputDir}/${ID}_TLEN_1-5.txt -o ${outputDir}

done

# End of the script \\\\\\\\\\\\\\\\\\\\\\\\\\\\