#library(readr) #read_csv (instead of read.csv)
#base.dir <- "/Users/akira/Documents/SharedFolder/Datasets/"
#setwd(base.dir)

source("../Programming/R/Coursera/pollutantmean.R")  # readdir()

complete <- function(directory, id = 1:332){
  dflist <- readdir(directory, id)
  cc <- lapply(dflist, complete.cases)
  ncc <- sapply(cc, sum)
  data.frame( id=id, nobs=ncc )
}
