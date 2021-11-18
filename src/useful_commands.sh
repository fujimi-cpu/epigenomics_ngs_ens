for f in data/non_published/*1.fastq.gz
do
n=${f%%1.fastq.gz}
prefixe=${n/"data/non_published/"/"processed_data/trimmed_data/"}
echo $n
echo $prefixe
echo ${prefixe}2_unpaired.fastq.gz
done



#change fastc files from processed_data/trimmed_data to processed_data/fatqc_trimmed_data


for f in *.fastq.gz #permet de prendre tous les reads en une seule fois pour viter de prendre reverse et forward
do
n=${f%%.fastq.gz} 
mv ${n}_fastqc.zip ~/mydatalocal/epigenomics_ngs_ens/processed_data/fastqc_trimmed_data/${n}_fastqc.zip
mv ${n}_fastqc.html ~/mydatalocal/epigenomics_ngs_ens/processed_data/fastqc_trimmed_data/${n}_fastqc.html
done