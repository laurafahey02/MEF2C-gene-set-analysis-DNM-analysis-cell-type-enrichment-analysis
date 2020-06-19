# MEF2C-genetic-analysis

### MAGMA Gene-set Analysis (GSA.sh)

A gene-set analysis (GSA) is a statistical method for simultaneously analysing multiple genetic markers in order to determine their joint effect. We performed GSA using [MAGMA](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004219) and GWAS summary statistics for [SZ](https://www.nature.com/articles/s41588-018-0059-2) (40,675 cases and 64,643 controls), [ASD](https://www.nature.com/articles/s41588-019-0344-8) (18,381 cases and 27,969 controls), [IQ](https://www.nature.com/articles/s41588-018-0152-6) (269,867 individuals) and [EA](https://www.nature.com/articles/s41588-018-0147-3) (766,345 individuals). 


### Enrichment analysis for genes containing de novo mutations (DNM_analysis.R)

Lists of genes harbouring DNMs identified in patients with SZ (N=1,024), ASD (N=3,985), ID (N=192) and in unaffected siblings (N=1,995) and controls (N=54) based on exome sequencing of trios were sourced from [Genovese et al. 2016](https://www.nature.com/articles/nn.4402). DNMs were categorized as silent, missense and loss-of-function (includes splice and nonsense). We tested for enrichment of our MEF2C gene-set in these gene lists using the R package, [denovolyzeR](http://denovolyzer.org/).

### Enrichment analysis of single cell transcriptomic data from the mouse nervous system

The expression weighted cell-type enrichment [(EWCE)](https://github.com/NathanSkene/EWCE) R package represents a method to statistically evaluate if a set of genes (e.g. our MEF2C gene-set) has higher expression within a particular cell type than can be reasonably expected by chance. The probability distribution for this is estimated by randomly generating gene-sets of equal length from a set of background genes. We used scRNA-seq data from 19 regions across the central and peripheral nervous system of post-natal day (P) 12-30 and 6-8 week old mice [(Zeisel et al. 2018)](https://pubmed.ncbi.nlm.nih.gov/30096314/) and from nine regions of the adult (P60-70) mouse brain [(Saunders et al. 2018)](https://pubmed.ncbi.nlm.nih.gov/30096299/).
