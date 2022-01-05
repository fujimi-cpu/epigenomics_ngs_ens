#downloading data
cd ~/mydatalocal/epigenomics_ngs_ens/data/non_published
wget --user='tp_ngs' --password='Arabido2021!' https://flower.ens-lyon.fr/tp_ngs/arabidocontratac/Data/2020_372_S2_R1.fastq.gz
wget --user='tp_ngs' --password='Arabido2021!' https://flower.ens-lyon.fr/tp_ngs/arabidocontratac/Data/2020_372_S2_R2.fastq.gz
wget --user='tp_ngs' --password='Arabido2021!' https://flower.ens-lyon.fr/tp_ngs/arabidocontratac/Data/2019_007_S7_R1.fastq.gz
wget --user='tp_ngs' --password='Arabido2021!' https://flower.ens-lyon.fr/tp_ngs/arabidocontratac/Data/2019_007_S7_R2.fastq.gz

#unzip files
gunzip -d 2020_372_S2_R1.fastq.gz
gunzip -d 2020_372_S2_R2.fastq.gz
gunzip -d 2019_007_S7_R1.fastq.gz
gunzip -d 2019_007_S7_R2.fastq.gz


#download quality control
cd ~/mydatalocal/epigenomics_ngs_ens/src
wget --user='tp_ngs' --password='Arabido2021!' https://flower.ens-lyon.fr/tp_ngs/arabidocontratac/Scripts/atac_qc.sh
wget --user='tp_ngs' --password='Arabido2021!' https://flower.ens-lyon.fr/tp_ngs/arabidocontratac/Scripts/plot_tlen.R
wget --user='tp_ngs' --password='Arabido2021!' https://flower.ens-lyon.fr/tp_ngs/arabidocontratac/Scripts/plot_tss_enrich.R	

#genome data
cd ~/mydatalocal/epigenomics_ngs_ens/data/supporting_data
wget http://ftp.ebi.ac.uk/ensemblgenomes/pub/release-52/plants/gtf/arabidopsis_thaliana/Arabidopsis_thaliana.TAIR10.52.gtf.gz
gunzip Arabidopsis_thaliana.TAIR10.52.gtf.gz

wget --user='tp_ngs' --password='Arabido2021!' https://flower.ens-lyon.fr/tp_ngs/arabidocontratac/Supporting_files/TAIR10_ChrLen.bed
wget --user='tp_ngs' --password='Arabido2021!' https://flower.ens-lyon.fr/tp_ngs/arabidocontratac/Supporting_files/TAIR10_ChrLen.txt

cd ~/mydatalocal/epigenomics_ngs_ens/processed_data/filtered
wget --user='tp_ngs' --password='Arabido2021!' https://flower.ens-lyon.fr/tp_ngs/arabidocontratac/Data/2020_374_S4.corrected.bam
mv 2020_374_S4.corrected.bam 2020_374_S4_Rmapped_sortedmarked_duplicates_filtered.bam
