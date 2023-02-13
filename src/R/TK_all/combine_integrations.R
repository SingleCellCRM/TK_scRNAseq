library(here)
library(Seurat)
library(stringr)
project <- "TK_all"
srt_CCA <- readRDS( here("processed", project, "seurat", "srt_clustered.RDS"))
# pull de integrated asssay
assay_cca <- srt_CCA[["integrated"]]
#pull the umap
umap_cca <- FetchData(srt_CCA, vars= c("UMAP_1", "UMAP_2") )
colnames(umap_cca) <- c("UMAP_CCA_1", "UMAP_CCA_2")
# pull and rename the clustering
srt_cca_cluster_names <- grep("integrated_snn_res", colnames(srt_CCA[[]]), value = TRUE)
srt_cca_clusters_metadata <- srt_CCA[[srt_cca_cluster_names]]
srt_cca_cluster_new_names <- str_replace(srt_cca_cluster_names,"integrated_snn", "cca")
colnames(srt_cca_clusters_metadata) <- srt_cca_cluster_new_names

#liger
srt_liger <- readRDS( here("processed", project, "seurat", "srt_liger_clustered.RDS"))
#pull umap
umap_liger <- FetchData(srt_liger, vars= c("UMAPLiger_1", "UMAPLiger_2") )
colnames(umap_liger) <- c("UMAP_Liger_1", "UMAP_Liger_2") 
# pull dimensional reduction
iNMF <- FetchData(srt_liger, vars= paste0("iNMF_", seq(25)) )
# pull and rename the clustering
srt_liger_cluster_names <- grep("originalexp_snn_res", colnames(srt_liger[[]]), value = TRUE)
srt_liger_clusters_metadata <- srt_liger[[srt_liger_cluster_names]]
srt_liger_cluster_new_names <- str_replace(srt_liger_cluster_names,"originalexp_snn", "liger")
colnames(srt_liger_clusters_metadata) <- srt_liger_cluster_new_names

# load sce corrected with mnn
sce_mnn <- readRDS(here("processed", project, "sce_clusters_01.RDS"))
# rename clustering
sce_mnn_metadata_names <- colnames(colData(sce_mnn))
sce_mnn_new_metadata_names <- str_replace(sce_mnn_metadata_names,"originalexp_snn", "mnn")
colnames(colData(sce_mnn)) <- sce_mnn_new_metadata_names

# manually add the rest of the information to the object
sce_clustered_combined <- sce_mnn
colData(sce_clustered_combined) <- cbind(colData(sce_clustered_combined), srt_liger_clusters_metadata, srt_cca_clusters_metadata )
reducedDim(sce_clustered_combined, "UMAP_Liger") <- umap_liger
reducedDim(sce_clustered_combined, "iNMF") <- iNMF
reducedDim(sce_clustered_combined, "UMAP_CCA") <- umap_cca
# todo: the rownames from the reduceddim are not the cell names (colnames(sce_mnn)), this will be problematic in future bioc releases. 
# save. 
saveRDS(sce_clustered_combined, here(here("processed", project, "sce_clustered_combined.RDS")))

