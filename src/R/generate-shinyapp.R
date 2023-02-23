library(ShinyCell)
library(here)
library(SingleCellExperiment) # access the coldata

# import datasets
# TODO add this into the loop
project <- "TK_all"
sce_all <- readRDS(here("processed", project,  "sce_labels.RDS"))

project <- "TK_RC17"
sce_RC17 <- readRDS(here("processed", project,  "sce_clusters_01.RDS"))

# combine them
sce_list <- list(TK_all = sce_all, TK_RC17 = sce_RC17)

#import colours
source(here("src","R", "colours.R"))

for(name in names(sce_list)){
  sce <- sce_list[[name]]
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
  
  scconf <- delMeta(scconf, meta.to.del = c("subsets_mt_sum", "subsets_mt_detected",
                                            "outlier", "discard", "total"))
  # modify metadata names
  scconf <- modMetaName(scconf,
                        meta.to.mod = c("sum", "detected", "subsets_mt_percent", srt_res),
                        new.name = c("umi counts", "detected genes", "% mt genes", paste("cluster", srt_res))
  )
  
  # make the shiny app files
  makeShinyFiles(sce, scconf, 
                 shiny.prefix = name,
                 gene.mapping = TRUE, 
  )
  
}

# build shiny app
makeShinyCodesMulti(shiny.title = "scRNAseq - Tilo Kunath", 
                    shiny.prefix = names(sce_list),
                    shiny.dir = "shinyApp/",
                    shiny.footnotes = NA,
                    shiny.headers = c("Whole DataSet", "RC17")
)


