#library(readr) #read_csv (instead of read.csv)
#base.dir <- "/Users/akira/Documents/SharedFolder/Datasets/"
#setwd(base.dir)
source("../Programming/R/Coursera/complete.R")

corr <- function(directory, threshold=0){
  dflist <- readdir(directory) #default: id=1:332
  cu <- complete(directory) # all ids (332x2)
  use <- cu$nobs > threshold
  v <- as.vector(NULL)
  for(i in 1:length(use)){
    if (use[i]){
      v[i] <- cor(dflist[[i]][,2], dflist[[i]][,3], use = "pairwise.complete.obs")
      # 2=sulfate, 3=nitrate in column
    }
  }
  v[use]
}
