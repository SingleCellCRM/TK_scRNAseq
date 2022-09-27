library(ShinyCell)
library(here)

# project
project <- "TK_all"
# import dataset
sce <- readRDS(here("processed", project,  "sce_labels.RDS"))
#import colours
source(here("src","colours.R"))

# configruation
scconf <- createConfig(sce)

# define colours and change them
metadata_categorical <- c("lamanno")
for(metadata in metadata_categorical){
  # transform to factor
  sce[[metadata]] <- droplevels(as.factor(sce[[metadata]]))
  # replace colours ( need to specify the exact n of colours)
  length <- length(levels((sce[[metadata]])))
  conf <- modColours(conf, meta.to.mod = metadata,
                     new.colours = cols[1:length])
}


# make the shiny app
makeShinyApp(sce, scconf, 
             gene.mapping = TRUE, 
             shiny.title = "scRNAseq - Tilo Kunath")
