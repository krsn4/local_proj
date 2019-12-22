#library(readr) #read_csv (instead of read.csv)
base.dir <- "/Users/akira/Documents/SharedFolder/Datasets/"
setwd(base.dir)

readdir <- function(directory, id = 1:332){
  file.list <- list.files(path=directory, pattern = '*.csv')
  df.list <- lapply(paste(directory, "/", file.list[id], sep = ""), read.csv)
}

pollutantmean <- function(directory, pollutant, id = 1:332) {
  df.list <- readdir(directory, id)
  df <- do.call(rbind, df.list)
  mean(df[[pollutant]], na.rm = TRUE)
}

  