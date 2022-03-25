# The samples were run in two different flow cells ( two days). 
# We rename the samples from the second run, in order to differentiate them 
# in the config file for cellranger multi 
#( email exchange with support: [10x Genomics] Cellranger multi with multiple flow cells)

cd $SCRATCH/TK/data/raw_data/2022-03-21/TK_140322/outs/fastq_path/AAAL35KHV/
for file in *.fastq.gz
do
  mv ${file} Run2_${file}

done
