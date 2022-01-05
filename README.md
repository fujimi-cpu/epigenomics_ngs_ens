# Next Generation Sequencing practical work project: 
## Table of Contents 
1. [ Project description ](#desc)
    1. [  Data and biological context ](#biocontext)
    2. [  Data processing ](#dataprocess)
    3. [  Data Analysis ](#analysis)
2. [ How to run the project ](#run)
    1. [  Data download ](#Data_d)
    2. [  Data processing ](#dataprocess_instruction)
    3. [  Data Analysis ](#analysis_instruction)


<a name="desc"></a>
## 1. Project description

<a name="dataprocess"></a>
### i. Data and biological context

During development, genetic regulation establishes the identity of cells and their differentiation pathway. In particular through gene mastering. Through a game of activation and hinibition of different genes, the cells differentiate. One way of activating and repressing is the shaping of the chromatin state, a strategy known in particular in the development of plants. By studying the state of this chromatin we can compare the different epigenetic states of cells. A known technique is the chromatin immunoprecipitation sequencing (ChIP-seq) techinque, which targets histones with antibodies, the analysis then allows to map the antibodies on the genome, we can also map transcript factors if we have the right antibodies. This technique is nevertheless specialized in antibodies. We could try to have the global epigenomic landscape of dna accessibility by taking into account the different folds and proteins interacting with the dna, this is the objective of the Assay for Transposase-Accessible Chromatin with highthroughput sequencing (ATAC-seq).
We use here the famous Arabidopsis thaliana model for the study of root development. In particular we are interested in the root apical meristem (RAM) and the cells of the quiescent centre (QC).
Note that the atac seq is a bulk method. That is to say that we need enough nuclei to study a cell type. We therefore lose the information linked to the heterogeneity within the extracted group of cells.
INTACT is a technique that allowed us to study specialized cells. By using a cell marker promoter expressing a gfp to a biotin binding peptide and a nuclear envelope attachment we can recover the nuclei associated with these cells.
How is stem cell quiescence programmed? By comparing the accessible regions in the genomes of quiescent cells and root cells in general, we can find genes that are accessible only in the latter. On the other hand it is expected to find few genes more expressed in the whole root and not in the stem cells because all the cells of the root include different differentiated types very different from each other


<a name="biocontext"></a>
### ii. Data processing

#### Evaluation of sequencing with fastqc
fastqc is a sequencing quality study software. It allows to evaluate the mean quality score, the bias with respect to the transposase (in particular the 15 nucleotides at the level of the cut which can interact with the enzyme), the distribution of the length of the sequences, the level of duplication, the over-representation of certain sequences, and finally the quantity of adapters produced by the transposase during the cut.

#### Trimming with trimmomatic
Trimming is a first step of data processing, it allows to remove the adapters introduced by transposase and pcr (nextera adapters) and the bad quality sequences. We also removes chloroplastic and mitochondrial genome. We use the trimmomatic software.

#### Mapping with bowtie2
Mapping is used to place reads on the Arabidopsis thaliana reference genome.

#### Filtering with samtools
Filtering removes reads with low mapping quality, duplicate reads, and reads in blacklisted regions. samtools is a multipurpose tool that allows us to filter our data.

#### Peak calling with macs2
The peak calling allows the localization of peaks, i.e. the zones accessible to transposase. For this we use macs2, a software using a fish model on the cuts. The signal being noisy because the cuts are all along the genome, we want to differentiate a part of the genome accessible from the background noise.


<a name="analysis"></a>
### iii. Data Analysis
Once the peaks are found, several approaches are possible, for example, we can look for unique peaks on one of the two conditions. The problem is that these peaks are not in the same place, so we can compare the closest genes. Another approach is to take all the peaks present in either condition, then evaluate the coverage in each condition. This way we can select the peaks that are at least twice as accessible in one condition. For example, WOX5 is more accessible in quiescent cells, but also XX which is a peptide inhibiting differentiation.



<a name="run"></a>
## 2. How to run the project

Bash scripts are available to download the data and process it. It can be ran from the bash terminal using ```sh script.sh```
The analysis script is a R script and can be ran from Rstudio or from a bash terminal with ```Rscript script.R``` command
<a name="Data_d"></a>
The scripts are annotated so you may follow step by step. You may also want to change the folder path defined to save or import the files at the beginning of the different scripts.

### i. Data download
To download the data run the following script ``` downloading_data.sh ```
The data has different parts. The first part is the data from the ATAC-seq analysis. The second part is the genomic information of A. thaliana allowing the mapping of the sequences. The zipped data in ''.gz'' can be unzipped with '''gzip -d file.gz'''. The files named R2 R2 correspond to the technical replicas, i.e. two same samples in the same conditions


<a name="dataprocess_instruction"></a>
### ii. Data processing
The bash files to run to process the data are the following ``` multiQC.sh ``` (needs to add fastqc)
Rrimming step which consists in removing adapters and fragments of bad quality ``` trimmomatic.sh ```
Mapping step placing reads on the Arabidopsis thaliana reference genome ``` bowtie.sh ```
Filtering step removes reads with low mapping quality, duplicate reads and reads in blacklisted regions ``` filtering.sh ```
Evaluation of the quality of ATAC-seq by checking the tss enrichment and the distance between two paired reads ``` atac_qc.sh ``` in order to evaluate the quality of the ATAC seq data
Peak calling using macs2 finds statistically the areas of the genome that are significantly more covered by reads and therefore accessible to dnase ``` atac_qc.sh ``` 

<a name="analysis_instruction"></a>
### iii. Data Analysis on R
All the peaks from the two conditions (whole root and quiescent cells) are taken and mapped on the genome, then the coverage is computed on these conditions ``` analysis.sh ``` 
```analysis_comparison_WOX5-WR.R``` plot and extract the conditions for which the coverage is stronger on the whole root or quiescent cells data set.


<!--region masquee : regions repeteés
genome cachee, ex chromosome 2, genome mitochondrial inséré-->
