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


<a name="biocontext"></a>
### ii. Data processing


#####
##### peak calling


<a name="analysis"></a>
### iii. Data Analysis




<a name="run"></a>
## 2. How to run the project

Bash scripts are available to download the data and process it. It can be ran from the bash terminal using ```sh script.sh```
The analysis script is a R script and can be ran from Rstudio or from a bash terminal with ```Rscript script.R``` command
<a name="Data_d"></a>
The scripts are annotated so you may follow step by step. You may also want to change the folder path defined to save or import the files at the beginning of the different scripts.

### i. Data download
To download the data run the following script ``` downloading_data.sh ```
The data has different parts. The first part is the data from the ATAC-seq analysis. The second part is the genomic information of A. thaliana allowing the mapping of the sequences

<a name="dataprocess_instruction"></a>
### ii. Data processing
The bash files to run to process the data are the following ``` multiQC.sh ``` ``` trimmomatic.sh ``` ``` bowtie.sh ``` ``` filtering.sh ```
``` atac_qc.sh ``` in order to evaluate the quality of the ATAC seq data

``` atac_qc.sh ``` Peak calling

<a name="analysis_instruction"></a>
### iii. Data Analysis on R
``` analysis.sh ``` All the peaks from the two conditions (whole root and quiescent cells) are taken and mapped on the genome, then the coverage is computed on these conditions

```analysis_comparison_WOX5-WR.R``` plot and extract the conditions for which the coverage is stronger on the whole root or quiescent cells data set.


<!--region masquee : regions repeteés
genome cachee, ex chromosome 2, genome mitochondrial inséré-->
