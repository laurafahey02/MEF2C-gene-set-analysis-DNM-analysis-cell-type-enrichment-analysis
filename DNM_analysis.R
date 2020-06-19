### De novo Analysis ###

library(denovolyzeR)

# Read in de novo data (each file has two columns, the first is gene name and the sencond is the mutation class (synonomous, missense, nonsense and splice) 
SZdeNovos <- read.table("SZ_genes_genovese.txt", header = TRUE)
ASDdeNovos <- read.table("ASD_genes_genovese.txt", header = TRUE)
IDdeNovos <- read.table("ID_genes_genovese.txt", header = TRUE)
SIBdeNovos <- read.table("UNAFF_SIB_genes_genovese.txt", header = TRUE)
CNTRLdeNovos <- read.table("CNTRL_denovos_howrigan.txt", head=TRUE)


# Read in gene-list
MEF2C <- readLines("MEF2C_DEGs.txt")

# Test for enrichment of each mutational class for each phenotype in the gene-set.
denovolyzeByClass(genes=SZdeNovos$gene,
                  classes=SZdeNovos$class,
                  nsamples=1024,
                  includeGenes=MEF2C)

denovolyzeByClass(genes=ASDdeNovos$gene,
                  classes=ASDdeNovos$class,
                  nsamples=3985,
                  includeGenes=MEF2C)

denovolyzeByClass(genes=IDdeNovos$gene,
                  classes=IDdeNovos$class,
                  nsamples=192,
                  includeGenes=MEF2C)

denovolyzeByClass(genes=SIBdeNovos$gene,
                  classes=SIBdeNovos$class,
                  nsamples==1995,
                  includeGenes=MEF2C)

denovolyzeByClass(genes=CNTRLdeNovos$gene,
                  classes=CNTRLdeNovos$class,
                  nsamples=54,
                  includeGenes=MEF2C)
