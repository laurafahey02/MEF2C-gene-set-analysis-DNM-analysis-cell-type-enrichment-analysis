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

# mgi to hgnc
#genes = getLDS(attributes = c("mgi_symbol"), filters = "mgi_symbol", values = genelist ,mart = mouse, attributesL = c("hgnc_symbol"), martL = human, uniqueRows=T)
#human.hits <- genes$HGNC.symbol

#  Get 'sct_data' ready
expData = exp_mat_fixed
l1=annot$ClusterName
l2=annot$TaxRank1
annotLevels = list(l1=l1,l2=l2)

fNames_ALLCELLS = generate.celltype.data(exp=expData,annotLevels,"annot265")
load(fNames_ALLCELLS[1])

# Loop through 1,000 randomized gene-set
for(i in 1:1000) {
genelist <- readLines(paste("harrington_sample",i,sep =""))
full_results = bootstrap.enrichment.test(sct_data=ctd,hits=genelist,bg=human.bg,reps=100,annotLevel=1,
                                         geneSizeControl=TRUE,genelistSpecies="human",sctSpecies="mouse")
 
results <- full_results$results[order(full_results$results$CellType),]

write.table(results$sd_from_mean, paste("harrington_result",i,sep=""), quote = FALSE, row.name=F, col.name=F)
}
