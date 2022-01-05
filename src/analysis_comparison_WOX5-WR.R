
WOX5=read.table(file = "~/mydatalocal/epigenomics_ngs_ens/processed_data/analysis/2019_007_S7_R_coverage.txt")
WR=read.table(file = "~/mydatalocal/epigenomics_ngs_ens/processed_data/analysis/2020_374_S4_coverage.txt")

WOX5=read.table(file = "~/mydatalocal/epigenomics_ngs_ens/processed_data/analysis/2019_007_S7_R.nearest.genes.txt")
WR=read.table(file = "~/mydatalocal/epigenomics_ngs_ens/processed_data/analysis/2020_374_S4.nearest.genes.txt")

#load peakcalling analysis

WOX5$norm=WOX5$V5/sum(WOX5$V5)
WR$norm=WR$V5/sum(WR$V5)
#normalize data for both conditions

head(WR)
head(WOX5)

#show peak coverage for both condition in log scale
plot(log(WOX5$norm), log(WR$norm), col=alpha("black", 0.3), cex=0.1, ylim=c(-14,-8))
text(log(WOX5$norm), log(WR$norm), labels=WR$V12, cex= 0.3)


plot(log(WOX5$norm), log(WR$norm), col=alpha("black", 0.3), cex=0.1, ylim=c(-14,-8))
text(log(WOX5$norm), log(WR$norm), labels=ifelse(log(WOX5$norm) - log(WR$norm)>2, WR$V12, ''), cex= 0.5)

library(ggplot2)
library(magrittr)
library(ggrepel)

WOX5$normwr = WR$norm


  
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



