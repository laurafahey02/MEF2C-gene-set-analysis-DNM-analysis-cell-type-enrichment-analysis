# hgnc2entrez.R inputfile outputfile
library(biomaRt)
args <- commandArgs(trailingOnly = TRUE)
geneset <- args[1]
genes_hgnc <- readLines(geneset) # should be one gene per row
mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
genes_hgnc_entrez=getBM(attributes = c("hgnc_symbol", "entrezgene_id"), filters = "hgnc_symbol", values = genes_hgnc, mart = mart)
output_file <- args[2]
cat("MEF2C", na.omit(genes_hgnc_entrez$entrezgene_id), file = output_file, sep="\t")
