
Trimmomatic=/softwares/Trimmomatic-0.39/trimmomatic-0.39.jar
Nextera=/softwares/Trimmomatic-0.39/adapters/NexteraPE-PE.fa

cd ~/mydatalocal/epigenomics_ngs_ens #we place ourselves in the data folder

for f in data/non_published/*1.fastq.gz #allows to take all reads at once to avoid taking reverse and forward
do
n=${f%%1.fastq.gz} #we remove the forward index to recover then  
prefixe=${n/"data/non_published/"/"processed_data/trimmed_data/"}
java -jar $Trimmomatic PE -threads 6 ${n}1.fastq.gz ${n}2.fastq.gz \
${prefixe}1_paired.fastq.gz ${prefixe}1_unpaired.fastq.gz \
${prefixe}2_paired.fastq.gz ${prefixe}2_unpaired.fastq.gz \
ILLUMINACLIP:${Nextera}:2:30:10 SLIDINGWINDOW:4:15 MINLEN:25
done


for f in data/lu_et_al/*1.fastq #allows to take all reads at once to avoid taking reverse and forward
do
n=${f%%1.fastq} #we remove the forward index to recover then 
prefixe=${n/"data/lu_et_al/"/"processed_data/trimmed_data/"}
java -jar $Trimmomatic PE -threads 6 ${n}1.fastq ${n}2.fastq \
${prefixe}1_paired.fastq.gz ${prefixe}1_unpaired.fastq.gz \
${prefixe}2_paired.fastq.gz ${prefixe}2_unpaired.fastq.gz \
ILLUMINACLIP:${Nextera}:2:30:10 SLIDINGWINDOW:4:15 MINLEN:25
done
#Nextera and the type of adapters
#MINLEN:36 allows to drop reads under 36 bases long
#Allows to remove trailings and leadings of bad quality


cd ~/mydatalocal/epigenomics_ngs_ens/processed_data/fastqc_trimmed_data

for f in ~/mydatalocal/epigenomics_ngs_ens/processed_data/trimmed_data/*.fastq.gz #permet de prendre tous les reads en une seule fois pour viter de prendre reverse et forward
do
echo $f
fastqc $f
done


multiqc .
