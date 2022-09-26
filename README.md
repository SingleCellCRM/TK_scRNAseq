# Tilo Kunath scRNAseq project

In *docs* there are files with:

- sequencing process

- analysis steps we would like to carry on

*data* contains the raw data from this project, and also from Gioele La Manno, we will use for annotation

In *src* are saved the scripts to run Cellranger and generate summary reports.

In *rmarkdown* we have: 

- import.R : to import the libraries, all batches together

- QC: using isOutlier threshold separate by chip. 

- Normalisation by deconvolution: also by chip

- Feature selection and batch correction


*processed* contains intermediate R objects

The R analysis project uses *renv*, ensuring we can use the same set of libraries anywhere we clone the project.




**TODO:**

Clustering at different resolutions

Annotation (with Gioele la manno)

(...)


