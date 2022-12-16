library(scran) # For feature selcetion
library(scater) # for pca
library(ggplot2) # modify plots
library(here) #reproducible paths
library(batchelor) #batch correct with fastmnn
library(harmony) # batch correct harmony

# load
project <- "TK_all"
sce <- readRDS(here("processed", project, "sce_norm_01.RDS"))

# DELETE CMO
CMO_genes <- grep("^CMO3", rownames(sce), value = TRUE)
keep_genes <- !(rownames(sce) %in% CMO_genes)
sce <- sce[keep_genes,]

##HVG
#The density weights are removed because the genes
# with highest mean abundance are also HVG, this avoids overfiting
gene_var_df <- modelGeneVar(sce, density.weights=FALSE, block = sce$Chip )
gene_var <- metadata(gene_var_df)
#plot(gene_var$mean, gene_var$var, xlab= "Mean of log-expression", ylab= "Variance of log-expression")
#curve(gene_var$trend(x), lwd=2, add=T, col = "red")
hvgs <- getTopHVGs(gene_var_df, prop=0.15)
# save them in the object
rowSubset(sce) <- hvgs



#DIMRED
set.seed(1000)
sce <- runPCA(sce)

#HARMONY
CMO <- sce$CMO
sce$CMO <- NULL
set.seed(1)
PCA <- reducedDim(sce, "PCA")
harmony <- HarmonyMatrix(PCA, meta_data=colData(sce), vars_use="Chip" , do_pca=FALSE )
reducedDim(sce, "harmony") <- harmony
sce <- runUMAP(sce,  dimred="harmony", name="UMAP-harmony")
sce$CMO <- CMO
umap <- plotReducedDim(sce[,sce$Library %in% c("TK_5", "TK_1")], colour_by = "Sample", dimred = "UMAP-harmony", other_fields = "CMO" ) + ggtitle("UMAP after batch correction")
umap
umap + facet_wrap(~CMO)

set.seed(100)
sce <- runUMAP(sce,  dimred="harmony", name="UMAP-global-harmony", n_neighbors = 100)
umap3 <- plotReducedDim(sce, colour_by = "Sample", dimred = "UMAP-global-harmony", point_size = 0.1, other_fields = "CMO" ) + ggtitle("UMAP after batch correction - Global structure") 
umap3
umap3 + facet_wrap(~CMO)
