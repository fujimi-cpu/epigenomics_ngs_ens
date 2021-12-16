
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

WOX5[log(WOX5$norm) - log(WR$norm)>1]