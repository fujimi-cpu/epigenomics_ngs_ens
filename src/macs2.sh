

workingDir=/home/rstudio/mydatalocal/epigenomics_ngs_ens

outputDir=/home/rstudio/mydatalocal/epigenomics_ngs_ens/processed_data/macs2
mkdir -p ${outputDir}
cd $outputDir


for f in ${workingDir}/processed_data/filtered/*filtered.bam
do
idbase="$(basename -- $f)"
echo $idbase
macs2 callpeak -t $f --outdir ${outputDir}/${idbase} --nomodel --broad
#Rscript ${outputDir}/NA_model.r
done

