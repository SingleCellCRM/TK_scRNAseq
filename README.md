# Tilo Kunath scRNAseq project

In *docs* there are files with:

- sequencing process

- analysis steps we would like to carry on

In *src* are saved the scripts to run Cellranger and generate summary reports.

In *rmarkdown* we have: 

- import.R : to import the libraries, all batches together

- QC: using isOutlier threshold separate by chip. 

The R analysis project uses *renv*, ensuring we can use the same set of libraries anywhere we clone the project.

