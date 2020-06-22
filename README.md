# MEF2C-genetic-analysis

This repository contains the code used for methods in the Manuscript entitled "Genes influenced by MEF2C contribute to neurodevelopmental disease via gene expression changes that affect multiple types of cortical excitatory neurons".

### MAGMA Gene-set Analysis (GSA)

We performed GSA using [MAGMA](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004219) and GWAS summary statistics for [SZ](https://www.nature.com/articles/s41588-018-0059-2) (40,675 cases and 64,643 controls), [ASD](https://www.nature.com/articles/s41588-019-0344-8) (18,381 cases and 27,969 controls), [IQ](https://www.nature.com/articles/s41588-018-0152-6) (269,867 individuals) and [EA](https://www.nature.com/articles/s41588-018-0147-3) (766,345 individuals). The MHC region is strongly associated with SZ in GWAS, to avoid the excessive number of MHC associated genes biasing the GSA, we removed SNPs in this region from the SZ summary summary statistics.

hgnc2entrez.R was used to convert a list of HGNC symbols into entrez IDs in the format accepted by MAGMA and the analyis was run according to GSA.sh.

### Enrichment analysis for genes containing de novo mutations

Lists of genes harbouring DNMs identified in patients with SZ (N=1,024), ASD (N=3,985), ID (N=192) and in unaffected siblings (N=1,995) and controls (N=54) based on exome sequencing of trios were sourced from [Genovese et al. 2016](https://www.nature.com/articles/nn.4402). DNMs were categorized as silent, missense and loss-of-function (includes splice and nonsense). We tested for enrichment of our MEF2C gene-set in these gene lists using the R package, [denovolyzeR](http://denovolyzer.org/), according to, DNM_analysis.R 

### Enrichment analysis of single cell transcriptomic data from the mouse nervous system

Expression weighted cell-type enrichment [(EWCE)](https://github.com/NathanSkene/EWCE) was used to evaluate if genes in our MEF2C gene-set have higher expression within a particular cell type than can be reasonably expected by chance. The probability distribution for this is estimated by randomly generating gene-sets of equal length from a set of background genes. We used scRNA-seq data from 19 regions across the central and peripheral nervous system of post-natal day (P) 12-30 and 6-8 week old mice [(Zeisel et al. 2018)](https://pubmed.ncbi.nlm.nih.gov/30096314/) and from nine regions of the adult (P60-70) mouse brain [(Saunders et al. 2018)](https://pubmed.ncbi.nlm.nih.gov/30096299/).

The Zeisel data came in the form of a .loom file. An expression matrix and annotation data frame that could be used with EWCE were created from this data, using ExpMat+AnnotFile_from_loom.py. EWCE_MEF2C_DEGs.R was run to test for cell type enrichment of the MEF2C gene-set.

The MEF2C gene-set was generated based on expression data from forebrain excitatory neurons [Harrington et al. 2016](https://elifesciences.org/articles/20059). To make sure the identified cell types enriched for genes within the MEF2C gene-set are not biased by this specific brain location, we generated 1000 randomized gene-sets from the full set of genes reported on by Harrington et al. and tested each one using EWCE and both the Zeisel and Saunders data using EWCE_simulations.R.

