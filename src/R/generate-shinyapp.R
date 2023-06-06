library(ShinyCell)
library(here)
library(SingleCellExperiment) # access the coldata

# list of datasets
projects <- c("TK_RC17", "TK_Mshef7", "TK_404C2", "TK_1231A3")
#import colours
source(here("src","R", "colours.R"))

for(project in projects){
  
  sce <- readRDS(here("processed", project,  "sce_clusters_01.RDS"))
  
  # configruation
  scconf <- createConfig(sce)
  
  # define colours and change them
  # clusters 
  srt_res <- grep("res",names(colData(sce)), value = TRUE)
  
  
  metadata_categorical <- c( "lamanno", "Sample","ShortName", "batch", "Day", "CellLine", "Protocol", srt_res)
  
  for(metadata in metadata_categorical){
    # transform to factor
  #  sce[[metadata]] <- droplevels(as.factor(sce[[metadata]]))
    sce[[metadata]] <- (as.factor(sce[[metadata]]))
    print(metadata)
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
                 shiny.prefix = project,
                 gene.mapping = TRUE, 
  )
  
}


########
# build shiny app
# this is too big, I will need to split in two
makeShinyCodesMulti(shiny.title = "scRNAseq - Tilo Kunath", 
                    shiny.prefix = projects,
                    shiny.dir = "shinyApp/",
                    shiny.footnotes = NA,
                    shiny.headers = stringr::str_remove_all(projects, "TK_")
)


