library(here)
library(scater)
project <- "TK_all"
# load object
sce <- readRDS(here("processed", project, "sce_labels.RDS"))


# correlations we want.
genes <- c("CORIN", "TH", "EN1", "PITX2", "DBX1", "NKX2-1", "GBX2", "HOXA2", "EGR2", "NKX6-1", "NPAS1", "POU4F1", "CD99", "COL1A1", "COL1A2", "DCN", "LUM", "ASCL1", "DCX", "TUBB3", "MAPT")

### for all dataset
result_correlation <- qlcMatrix::corSparse(t(logcounts(sce)),
                                           t(logcounts(sce)[genes,]))

# https://support.bioconductor.org/p/p132986/ why logged
rownames(result_correlation) <- rownames(sce)
colnames(result_correlation) <- genes

write.csv(result_correlation,here("outs", project, "correlations", "correlation_all_samples.csv"))

# plot big correlation
result_correlation_sub <- result_correlation[!(rownames(result_correlation) %in% genes), ]
#which(result_correlation_sub > abs(0.5), arr.ind = TRUE)
# cor_CORIN <- rownames(which(result_correlation_sub > abs(0.5), arr.ind = TRUE))[1:46]
# cor_EN1 <- rownames(which(result_correlation_sub > abs(0.5), arr.ind = TRUE))[47]
# cor_NKX2_1 <- rownames(which(result_correlation_sub > abs(0.5), arr.ind = TRUE))[48]

#plotExpression(sce, features = cor_CORIN, x = "CORIN")

#### separate samples
collapse_rep <- paste0(sce$CellLine, "_D", sce$Day, "_", sce$Protocol)
sce$collapse_rep <- collapse_rep

for(sample in unique(collapse_rep)){
  print(sample)
  sce_x <- sce[,sce$collapse_rep == sample]
  result_correlation <- qlcMatrix::corSparse(t(logcounts(sce_x)),
                                             t(logcounts(sce_x)[genes,]))
  rownames(result_correlation) <- rownames(sce_x)
  colnames(result_correlation) <- genes
  
  write.csv(result_correlation,here("outs", project, "correlations", paste0("correlation_", sample,".csv")))
  
}

# other requests
#1) just the day 16, 2) just the day 28 and 3) day 16 plus day 28
days <- c(16, 28)
for(sample in days){
  print(sample)
  sce_x <- sce[,sce$Day == sample]
  result_correlation <- qlcMatrix::corSparse(t(logcounts(sce_x)),
                                             t(logcounts(sce_x)[genes,]))
  rownames(result_correlation) <- rownames(sce_x)
  colnames(result_correlation) <- genes
  
  write.csv(result_correlation,here("outs", project, "correlations", paste0("correlation_day_", sample,".csv")))
  
}

# combined
sce_x <- sce[,as.numeric(as.character(sce$Day)) > 0]
result_correlation <- qlcMatrix::corSparse(t(logcounts(sce_x)),
                                           t(logcounts(sce_x)[genes,]))
rownames(result_correlation) <- rownames(sce_x)
colnames(result_correlation) <- genes

write.csv(result_correlation,here("outs", project, "correlations", paste0("correlation_day_16&28.csv")))


# Testing options
# # plot correlations
# plotExpression(sce, features = rownames(sce)[c(1:4)], x = rownames(sce)[3] )
# 
# # compute correlataions
# start_time <- Sys.time()
# cor(as.matrix(logcounts(sce)["AL627309.3",]), as.matrix(logcounts(sce)[1,]))
# end_time <- Sys.time()
# end_time - start_time
# cor(logcounts(sce)[1,], logcounts(sce)[1,])
# cor(logcounts(sce)[1,], -logcounts(sce)[1,])
# 
# 
# # Time
# start_time <- Sys.time()
# cor(as.matrix(logcounts(sce)["AL627309.3",]), as.matrix(logcounts(sce)[1,]))
# end_time <- Sys.time()
# end_time - start_time
# 
# # with package for sparse matrices 
# start_time <- Sys.time()
# qlcMatrix::corSparse(as.matrix(logcounts(sce)["AL627309.3",]), as.matrix(logcounts(sce)[1,]))
# end_time <- Sys.time()
# end_time - start_time
# 
# # another option from sparse matrices package # the other output is better, not worth.
# start_time <- Sys.time()
# qlcMatrix::cosSparse(as.matrix(logcounts(sce)["AL627309.3",]), as.matrix(logcounts(sce)[1,]))
# end_time <- Sys.time()
# end_time - start_time
# 
# # other form time
# system.time(qlcMatrix::corSparse(as.matrix(logcounts(sce)["AL627309.3",]), as.matrix(logcounts(sce)[1,])))
# system.time(qlcMatrix::cosSparse(as.matrix(logcounts(sce)["AL627309.3",]), as.matrix(logcounts(sce)[1,])))
# 
# 
# # how long to transpose?
# start_time <- Sys.time()
# ((logcounts(sce)))
# end_time <- Sys.time()
# notrans <- end_time - start_time
# start_time <- Sys.time()
# t((logcounts(sce)))
# end_time <- Sys.time()
# trans <- end_time - start_time
# 
# trans - notrans
# # 17 secs. 
