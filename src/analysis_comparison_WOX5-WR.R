
WOX5=read.table(file = "~/mydatalocal/epigenomics_ngs_ens/processed_data/analysis/2019_007_S7_R_coverage.txt")
WR=read.table(file = "~/mydatalocal/epigenomics_ngs_ens/processed_data/analysis/2020_374_S4_coverage.txt")

WOX5=read.table(file = "~/mydatalocal/epigenomics_ngs_ens/processed_data/analysis/2019_007_S7_R.nearest.genes.txt")
WR=read.table(file = "~/mydatalocal/epigenomics_ngs_ens/processed_data/analysis/2020_374_S4.nearest.genes.txt")



WOX5$norm=WOX5$V5/sum(WOX5$V5)
WR$norm=WR$V5/sum(WR$V5)


head(WR)
head(WOX5)

plot(log(WOX5$norm), log(WR$norm), col=alpha("black", 0.3), cex=0.1, ylim=c(-14,-8))
text(log(WOX5$norm), log(WR$norm), labels=WR$V12, cex= 0.3)


plot(log(WOX5$norm), log(WR$norm), col=alpha("black", 0.3), cex=0.1, ylim=c(-14,-8))
text(log(WOX5$norm), log(WR$norm), labels=ifelse(log(WOX5$norm) - log(WR$norm)>2, WR$V12, ''), cex= 0.5)

library(ggplot2)
library(magrittr)
library(ggrepel)

WOX5$normwr = WR$norm

WOX5 %>% 

  
  ggplot(data=WOX5, mapping=aes(x=log(norm), y=log(normwr), label=V9))+
  geom_text_repel(data = WOX5[log(WOX5$norm) - 0.85*log(WR$norm)<(-2.3),])+
  geom_point(size=0.2)


ggplot(data=WOX5, mapping=aes(x=log(norm), y=log(normwr), label=V9))+
  geom_text_repel(data = WOX5[1.4*log(WOX5$norm) - log(WR$norm)>(-2.6),])+
  geom_point(size=0.2)


ggplot(data=WOX5, mapping=aes(x=log(norm), y=log(normwr), label=V9))+
  geom_text_repel(data = WOX5[log(WOX5$norm)>(-7.8),])+
  geom_point(size=0.2)

  
  ggplot(data=WOX5, mapping=aes(x=log(norm), y=log(normwr), label=V9))+
  geom_text_repel(data = WOX5[WOX5$V9=='AT3G11260',])+
  geom_point(size=0.2, color=ifelse(1.4*log(WOX5$norm) - log(WR$norm)>(-2.6), 'red', ifelse(0.85*log(WOX5$norm) - log(WR$norm)<(0.7), 'blue', 'black')))


tab = WOX5[log(WOX5$norm) - log(WR$norm)>2,]
write.table(tab, "~/mydatalocal/epigenomics_ngs_ens/processed_data/analysis/WOX5_genes.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("org.At.tair.db")
library(org.At.tair.db)




## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
## Bimap interface:
x <- org.At.tairGO
# Get the TAIR gene identifiers that are mapped to a GO ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {
  # Try the first one
  got <- xx[[1]]
  got[[1]][["GOID"]]
  got[[1]][["Ontology"]]
  got[[1]][["Evidence"]]
}
# For the reverse map:
# Convert to a list
xx <- as.list(org.At.tairGO2TAIR)
if(length(xx) > 0){
  # Gets the TAIR gene ids for the top 2nd and 3nd GO identifiers
  goids <- xx[2:3]
  # Gets the TAIR ids for the first element of goids
  goids[[1]]
  # Evidence code for the mappings
  names(goids[[1]])
}

test = toTable(xx)

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
## Bimap interface:
# Convert to a list
xx <- as.list(org.At.tairGO2ALLTAIRS)
if(length(xx) > 0){
  # Gets the tair identifiers for the top 2nd and 3nd GO identifiers
  goids <- xx[2:3]
  # Gets all the tair identifiers for the first element of goids
  goids[[1]]
  # Evidence code for the mappings
  names(goids[[1]])
}


head(xx)
toTable(xx)

xx['GO:0000002']
xx['AT1G31760']

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
## Bimap interface:
x <- org.At.tairGENENAME
# Get the TAIR identifiers that are mapped to a gene name
mapped_tairs <- mappedkeys(x)
# Convert to a list

xx <- as.list(x[mapped_tairs])
if(length(xx) > 0) {
  # Get the GENENAME for the first five tairs
  xx[1:5]
  # Get the first one
  xx[[1]]
}
head(xx)
xx['AT3G11260']

BiocManager::install("topGO")
