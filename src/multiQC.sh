cd ~/mydatalocal/epigenomics_ngs_ens/data/lu_et_al

fastqc SRR4000472_1.fastq
fastqc SRR4000472_2.fastq
fastqc SRR4000473_1.fastq
fastqc SRR4000473_2.fastq

cd ~/mydatalocal/epigenomics_ngs_ens/data/non_published

2020_380_S10_R2.fastq.gz
2020_380_S10_R1.fastq.gz
2019_007_S7_R2.fastq.gz
2019_007_S7_R1.fastq.gz
2020_372_S2_R2.fastq.gz
2020_372_S2_R1.fastq.gz


#move the analysis and fastqc and summarize all the data with multiqc
cd ~/mydatalocal/epigenomics_ngs_ens/processed_data/fastqc
multiqc .
