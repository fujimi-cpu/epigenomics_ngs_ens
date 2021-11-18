#Construction d'un index à partir d'un genome de référence
workdir=~/mydatalocal/epigenomics_ngs_ens/data/supporting_data
index_dir=~/mydatalocal/epigenomics_ngs_ens/data/supporting_data/index
mkdir -p $index_dir

cd $index_dir
bowtie2-build -f ${workdir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa TAIR10
