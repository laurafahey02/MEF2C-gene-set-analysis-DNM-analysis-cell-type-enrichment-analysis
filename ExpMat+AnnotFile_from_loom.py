## Below was run interactively in Jupyter notebook

# import necessary libraries
import loompy
import numpy as np
import pandas as pd

# Connect to loom file. 
agg = loompy.connect("l5_all.agg.loom")

# Create a matrix with genes as row names and ClusterNames as column names and write to file
mat = agg[:, :]
genes = agg.ra.Gene
clusterNames = agg.ca.ClusterName
f = pd.DataFrame(mat, index=genes, columns=clusterNames)
f.to_csv('/home/laura/loom/df_agg.csv', index=True, header=True, sep=' ')


# Ceate a 5 column file with ClusterName as the first column and correspondng TaxRanks as the remaining columns
tax1 = agg.ca.TaxonomyRank1
tax2 = agg.ca.TaxonomyRank2
tax3 = agg.ca.TaxonomyRank3
tax4 = agg.ca.TaxonomyRank4

f = open("/home/laura/loom/annotation_agg.txt", "w")
for i in range(len(clusterNames)):
    f.write("{} {} {} {} {}\n".format(clusterNames[i] + '\t', tax1[i] + '\t', tax2[i] + '\t', tax3[i] + '\t', tax4[i]))

f.close()

# Close loom file
agg.close()
