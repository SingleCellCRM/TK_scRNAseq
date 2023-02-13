# correct the metadata
# a new metadata sheet has been provided at this stage, with updated and corrected information
# in this script I will swap the metadata values from the sce object. 

# load packages
library(SingleCellExperiment) # to load sce

# import metadata, and specify the factor-> chr with as.is and the int -> factor with colClasses
new_metadata <-  read.csv(here("data/metadata_TK2.csv"), 
                          as.is = c("Sample", "ShortName", "Description"), 
                          colClasses = c("Chip"="factor", "EXPT"="factor", "CMO"="factor", "Day"="factor"))


# load sce
project <- "TK_all"
sce <- readRDS(here("processed", project, "sce_norm_01.RDS"))

# delete the ND column, replaced by EXPT
sce$ND <- NULL
# delete all the duplicated columns... except sample [1], used to merge
duplicated_cols <- colnames(colData(sce)) %in% colnames(new_metadata)[-1]
colData(sce)[, duplicated_cols] <- NULL

# merge new meatadata with existing colData from sce
colData(sce) <- merge(x= new_metadata, y= colData(sce), by = "Sample", all.y=TRUE)

# save sce updated.
saveRDS(sce, here("processed", project, "sce_norm_newmeta_01.RDS"))
