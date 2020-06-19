# MEF2C-genetic-analysis

## MAGMA Gene-set Analysis
#### Step 1: Annotation
Map SNPs from GWAS results on to genes (GRCh37/hg19 start-stop coordinates +/-20kb).

Reference data files (g100_eur) and gene locations file were obtained from the [MAGMA homepage](https://ctg.cncr.nl/software/magma)
```
magma --annotate window=20,20 --snp-loc g1000_eur.bim --gene-loc NCBI37.3.gene.loc --out ncbi37_eur
```
#### Step 2: Gene analysis 
Compute gene P values for each GWAS dataset (ASD, SCZ, ID and EA).
```
magma --bfile g1000_eur --pval [summary statistic file] N=[number of samples] --gene-annot ncbi37_eur.genes.annot --out [output_file_name] 
```

#### Step 3: Gene-set analysis
Test if the genes in each gene-set are more strongly associated with either phenotype than other genes in the genome.

First convert a list of HGNC symbols to entrez IDs in the file format accepted by MAGMA by running hgnc2entrez.R.

Combine multiple genesets together:
```
awk 'FNR==1 && NR!=1 {print '\n'}{print}' geneset1.tab geneset2.tab > genesets.tab
```
Perform the gene-set analysis on all .raw files (output of step 2) for each geneset in genesets.tab 
```
for i in *.raw; do id=$(echo ${i} | sed 's/.raw//'); magma --gene-results ${id}.raw --set-annot genesets.tab --out ${id}.results; done
```
