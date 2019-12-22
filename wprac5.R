# file.exists("directorName")
# di.create("directoryName")
# download.file()
# read.table() (CSV)
# library(xlsx) read.xlsx


if (!file.exists("data")){
  dir.create("data")
}

fileUrl <- "https://"
download.file(fileUrl, destfile = ".data/camera.csv", method = "curl")
list.files("./data")

dateDownloaded <- date()

cameraData <- read.table(".data/camera.csv", sep = ",", header = TRUE)
#setting quote="" often resolves ' or " quotation trouble.

#library(xlsx) #or 
library(readxl) #, library(XLConnect), XLConnect vignette
cameraData <- read.xlsx(".data/cameras.xlsx", sheetIndex=1, header=TRUE )

library(XML)
#XPath (whole another language)

library(jsonlite)
myjson <- toJSON(iris, pretty=TRUE)
iris2 <- fromJSON(myjson)

library(data.table)
DF <- data.frame(x=rnorm(9), y=rep(c("a","b","c"),each=3), z=rnorm(9))
DT <- data.table(x=rnorm(9), y=rep(c("a","b","c"),each=3), z=rnorm(9))
tables()
DT[2,]
DT[DT$y=="a",]
DT[c(2,3)]
DT[,c(2,3)]
DT[,list(mean(x), sum(z))]
DT[,table(y)]
DT[, w:=z^2]
DT2 <- DT
DT[, y:=2] #will change DT2 as well, since DT2 is not a copy of DT
DT[, m:= {tmp <- (x+z); log2(tmp+5)}]
DT[, a:=x>0]
DT[,b:=mean(x+w), by=a]

set.seed(123);
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]

DT <- data.table(x=rep(c("a","b","c"), each=100), y=rnorm(300))
setkey(DT, x) # for subsetting, joins
DT['a']

DT1 <- data.table(x=c('a','a','b','dt1'), y=1:4)
DT2 <- data.table(x=c('a','b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2,x)
merge(DT1, DT2) #left join?

big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))
# vs
system.time(read.table(file, header=TRUE, sep="\t"))

con <- url("http://")
htmlCode <- readLines(con)
close(con)
htmlCode

#better
library(XML)
url <- ""
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)

library(httr)
html2 <- GET(url)
content2 <- content(html2, as="text")
parsedHtml <- htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

google <- handle("http://google.com")
pg1 <- GET(handle=google, path="/")
pg2 <- GET(handle=google, path="search")

#con <- file(), url(), gzfile(), bzfile(), ?connections
#remember to close connections

#read.octave(), read.xport (SAS)


