library(EWCE)
library(biomaRt)

# Read in annotation file, setting fist column as row names
annot<-read.table("annotation_agg.txt",header=TRUE,sep="\t")

# Read in expression matrix and convert to an R matrix 
exp <- read.table("df_agg.csv",header=TRUE, row.names=1, sep=" ")
exp_mat <- data.matrix(exp, rownames.force = TRUE)

# Fix incorrect gene symbols
if(!file.exists("MRK_List2.rpt")){
  download.file("http://www.informatics.jax.org/downloads/reports/MRK_List2.rpt", destfile="MRK_List2.rpt")
}
exp_mat_fixed = fix.bad.mgi.symbols(exp_mat,mrk_file_path="MRK_List2.rpt")

# Get background genelist
human = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mouse = useMart("ensembl", dataset = "mmusculus_gene_ensembl")
all_hgnc <- getBM(attributes = ("hgnc_symbol"), mart = human)
human.bg <- all_hgnc$hgnc_symbol

#  Get 'sct_data' ready
expData = exp_mat_fixed
l1=annot$ClusterName
l2=annot$TaxRank1
annotLevels = list(l1=l1,l2=l2)

fNames_ALLCELLS = generate.celltype.data(exp=expData,annotLevels,"annot265")
load(fNames_ALLCELLS[1])

genelist <- readLines("MEF2C_DEGs.txt")
hgnc.hits <- genelist[genelist %in% human.bg]
full_results = bootstrap.enrichment.test(sct_data=ctd,hits=hgnc.hits,bg=human.bg,reps=100000,annotLevel=1,
                                         geneSizeControl=TRUE,genelistSpecies="human",sctSpecies="mouse")
 
results <- full_results$results[order(full_results$results$p),]

write.table(results, "MEF2C.results", quote = FALSE, row.name=F, col.name=F)
