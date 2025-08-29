# Tilo Kunath scRNAseq project

In __*docs*__ there are files with:

- sequencing process

- analysis steps we would like to carry on

__*data*__ contains the raw data from this project, and also from Gioele La Manno, we will use for annotation

In *src* are saved the scripts to run Cellranger and generate summary reports.

In __*rmarkdown*__ we have: 

- Global analysis:

  - import.R : to import the libraries, all batches together

  - QC: using isOutlier threshold separate by chip. 

  - Normalisation by deconvolution: also by chip

  - Feature selection and batch correction

  - Label transfer (from Gioele LaManno's) - we tested with linnarson too but wasn't informative.

  - Clustering at different resolutions

  - Analyse with alternative workflows (Seurat, Liger)

- Analysis separated by cell lines:
 
   - Same as for Global
   - RC17: further annotations and trajectory analysis

__*processed*__ contains intermediate R objects

The R analysis project uses *renv*, ensuring we can use the same set of libraries anywhere we clone the project.




**TODO:**

- Annotate the Mshef7 (label transfer form RC17 done, Tilo is working on annotation)
- Annotate the other cell lines



