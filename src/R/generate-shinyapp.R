library(ShinyCell)
library(here)
library(SingleCellExperiment) # access the coldata

# project
project <- "TK_all"
# import dataset
sce <- readRDS(here("processed", project,  "sce_labels.RDS"))

#import colours
source(here("src","R", "colours.R"))

# configruation
scconf <- createConfig(sce)

# define colours and change them
# clusters 
srt_res <- grep("res",names(colData(sce)), value = TRUE)


metadata_categorical <- c("lamanno", "Sample","ShortName", srt_res)
for(metadata in metadata_categorical){
  # transform to factor
  sce[[metadata]] <- droplevels(as.factor(sce[[metadata]]))
  # replace colours ( need to specify the exact n of colours)
  length <- length(levels((sce[[metadata]])))
  scconf <- modColours(scconf, meta.to.mod = metadata,
                     new.colours = cols[1:length])
}

scconf <- delMeta(scconf, meta.to.del = c( "subsets_mt_sum", "subsets_mt_detected",
                                               "outlier", "discard", "total"))
# modify metadata names
scconf <- modMetaName(scconf,
                    meta.to.mod = c("sum", "detected", "subsets_mt_percent", srt_res),
                    new.name = c("umi counts", "detected genes", "% mt genes", paste("cluster", srt_res))
)

# make the shiny app
makeShinyApp(sce, scconf, 
             gene.mapping = TRUE, 
             shiny.title = "scRNAseq - Tilo Kunath")
