# The samples were run in different flow cells ( different days). 
# We rename the samples, in order to differentiate them 
# in the config file for cellranger multi 
#( email exchange with support: [10x Genomics] Cellranger multi with multiple flow cells)

# variable
SCRATCH=/exports/eddie/scratch/nbestard/
# second run
cd $SCRATCH/TK/data/raw_data/2022-03-21/TK_140322/outs/fastq_path/AAAL35KHV/
for file in *.fastq.gz
do
  echo $file
  mv ${file} Run2_${file}

done

# third run
cd $SCRATCH/TK/data/raw_data/2022-05-03/TK_280422/outs/fastq_path/AAAM5MVHV/
   
for file in *.fastq.gz
do
  echo $file
  mv ${file} Run3_${file}
done

# fourth run 

cd $SCRATCH/TK/data/raw_data/2022-05-20/TK_190522/outs/fastq_path/AAAMGTYHV/
for file in *.fastq.gz
do
  echo $file
  mv ${file} Run4_${file}
done

