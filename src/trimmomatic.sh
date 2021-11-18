

Trimmomatic=/softwares/Trimmomatic-0.39/trimmomatic-0.39.jar
Nextera=/softwares/Trimmomatic-0.39/adapters/NexteraPE-PE.fa

cd ~/mydatalocal/epigenomics_ngs_ens #on se place dans le dossier de data

for f in data/non_published/*1.fastq.gz #permet de prendre tous les reads en une seule fois pour viter de prendre reverse et forward
do
n=${f%%1.fastq.gz} #on enlève l'indice forward pour récupérer ensuite 
prefixe=${n/"data/non_published/"/"processed_data/trimmed_data/"}
echo ${n}1.fastq.gz
java -jar $Trimmomatic PE -threads 6 ${n}1.fastq.gz ${n}2.fastq.gz \
${prefixe}1_paired.fastq.gz ${prefixe}1_unpaired.fastq.gz \
${prefixe}2_paired.fastq.gz ${prefixe}2_unpaired.fastq.gz \
ILLUMINACLIP:${Nextera}:2:30:10 SLIDINGWINDOW:4:15 MINLEN:25
done