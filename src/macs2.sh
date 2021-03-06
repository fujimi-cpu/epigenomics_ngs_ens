

workingDir=/home/rstudio/mydatalocal/epigenomics_ngs_ens

outputDir=/home/rstudio/mydatalocal/epigenomics_ngs_ens/processed_data/macs2
mkdir -p ${outputDir}
cd $outputDir

bam_suffix=mapped_sortedmarked_duplicates_filtered.bam

for f in ${workingDir}/processed_data/filtered/*filtered.bam
do
idbase="$(basename -- $f)"
ID="${idbase//$bam_suffix/}"
echo $f
echo ${idbase}
echo ${ID}
macs2 callpeak -t $f -n ${ID} --outdir ${outputDir} --nomodel --broad --extsize 50 --shift -25 -q 0.01 -g 10e7 --broad-cutoff 0.01 --keep-dup "all" -B 

#no model, indeed the model is used for the chip-seq
#-q 0.01 corresponds to the confidence threshold
#-g 10e7 is the size of the arabidposis genome

#Rscript ${outputDir}/NA_model.r
done

#macs2 callpeak -f "BAM" -t ${f} -n ${IDbase/$bam_suffix/} --outdir ${PeakcallingDir} -q 0.01 --nomodel --shift -25 --extsize 50 --keep-dup "all" -B --broad --broad-cutoff 0.01 -g 10E7



cd ${workingDir}/processed_data/filtered
for f in ${workingDir}/processed_data/filtered/*filtered.bam
do
samtools index $f
done
#We can load these files on IGV (+link) to visualize the coverage and the peaks found
