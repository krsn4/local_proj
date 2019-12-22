#dplyr
library(dplyr)
# select: returns a subset of the *columns* of a df 
# filter: extracts a subset of *rows* of a df
# arrange: reorders *rows* of a df
# rename: generates summary statistics of diff vars, possibly within strata
# mutate: creates, transforms variables
# group_by
# print: prevents from a lot of data to the console
chicago <- readRDS("chicago.rds") #where?
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
chicago %>% 
  mutate(month = as.POSIXlt(data)$mon +1) %>%
  group_by(month) %>%
  summarize(pm25 = mean(pm25, na.rm = TRUE), o3 - mean(o3mean2), no2=median(no2tmean2))

filter(iris, Petal.Width > 0.3) %>% 
  select(-c(Petal.Width)) %>% 
  arrange(desc(Sepal.Width)) %>% 
  head(5)
iris2 <- rename(iris, S.length=Sepal.Length);head(iris2,5)
iris2 <- mutate(iris2, S.length_tr=S.length-mean(S.length, na.rm = TRUE))
iris2 <- mutate(iris2, S.length_cat = factor(S.length_tr >0, labels=c("neg","pos")))
group_by(iris2, S.length_cat) %>% summarize(S.length=mean(S.length), S.WIdth=mean(Sepal.Width))


# merge
# x, y, by, by.x, by.y, all (by.x = left merge)

# join
df1 <- data.frame(id=sample(1:10), x=rnorm(10))
df2 <- data.frame(id=sample(1:10), y=rnorm(10))
arrange(join(df1,df2),id)
join(df1,df2) %>% arrange(id)
df3 <- data.frame(id=sample(1:10), z=rnorm(10))
dfList <- list(df1,df2,df3)
join_all(dfList) %>% arrange(id)


if(!file.exists("Coursera/Data")){dir.create("Coursera/Data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "Coursera/Data/data_ss06hid.csv")
myData <- read.csv("Coursera/Data/data_ss06hid.csv")
myData$agricultureLogical <- (myData$ACR==3 & myData$AGS==6)

library(jpeg)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile = "Coursera/Data/data2.jpg")
jpegdata <- readJPEG("Coursera/Data/data2.jpg", native = TRUE)
quantile(jpegdata, c(0.3, 0.8))

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "Coursera/Data/gdp.csv")
gdpdata <- read.csv("Coursera/Data/gdp.csv", skip = 4, nrows = 190, stringsAsFactors = FALSE)
gdpdata <- rename(gdpdata, Abbr=X, Ranking=X.1, Country=X.3, GDP=X.4)
gdpdata$X.2=NULL
gdpdata$X.5=NULL
gdpdata$X.6=NULL
gdpdata$X.7=NULL
gdpdata$X.8=NULL
gdpdata$X.9=NULL
#gdpdata$Abbr <- as.character(gdpdata$Abbr)
#gdpdata$Ranking <- as.integer(gdpdata$Ranking)
#gdpdata$Region.Economy <- as.character(gdpdata$Region.Economy)
#gdpdata <- gdpdata[!gdpdata$Abbr == "",]
#gdpdata[gdpdata$GDP %in% c("..", ""), "GDP"] <- NA
library(stringr)
gdpdata$GDP <- as.numeric(str_replace_all(gdpdata$GDP, ",", ""))
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
              destfile = "Coursera/Data/educ.csv")
educdata <- read.csv("Coursera/Data/educ.csv")
mergeData <- merge(gdpdata, educdata, by.x = "Abbr", by.y = "CountryCode", all.y = TRUE)
head(mergeData[order(mergeData$GDP), "Country"],n=13)
mergeData %>% group_by(Income.Group) %>% summarize(average = mean(Ranking, na.rm = TRUE))

mergeData[mergeData$Ranking <= 38 & mergeData$Income.Group == 'Lower middle income', "Abbr"]