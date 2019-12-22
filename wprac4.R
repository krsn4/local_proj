set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] <- NA
X[,1]
X[,"var1"]
X[1:2,"var2"]
X[(X$var1 <= 3 & X$var3 > 11),]
X[(X$var1 <= 3 | X$var3 > 11),]
X[which(X$var2 > 8),] #doesn't return NAs
X[X$var2 > 8,] # does.
sort(X$var1)
sort(X$var1, decreasing = TRUE)
sort(X$var2, na.last = TRUE) #default is F
X[order(X$var1),]
order(X$var1)
X[order(X$var1, X$var3),]
library(plyr)
arrange(X, var1)
X$var4 <- rnorm(5)
Y <- cbind(X, rnorm(5))

if(!file.exists("Coursera/Data")){dir.create("Coursera/Data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "Coursera/Data/restaurants.csv")
restData <- read.csv("Coursera/Data/restaurants.csv")
head(restData, n=3)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.9))
table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict, restData$zipCode)
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
colSums(is.na(restData))
all(colSums(is.na(restData))==0)
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"), ]

data("UCBAdmissions")
DF <- as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data = DF) ### useful

warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~., data = warpbreaks)
ftable(xt)

fakeData <- rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")

s1 <- seq(1,10,by=2); s1
s2 <- seq(1,10,length=3); s2
x <- c(1,3,8,25,100); seq(along = x)
y<-c(3,1,8,25,100); seq(along = x)

restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
restData$zipWrong <- ifelse(restData$zipCode <0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

library(Hmisc)
restData$zipGroups <- Hmisc::cut2(restData$zipCode, g=4)
table(restData$zipGroups)

restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

yesno <- sample(c("yes","no"), size=10, replace = TRUE)
yesnofac <- factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref = "yes")
restData2 <- plyr::mutate(restData, zipGroups=cut2(zipCode, g=4))

library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, n=3)
tail(carMelt, n=3)

cylData <- dcast(carMelt, cyl ~ variable)
cylData
cylData <- dcast(carMelt, cyl ~ variable, mean)

head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)
spIns <- split(InsectSprays$count, InsectSprays$spray)
spIns
sprCount <- lapply(spIns,sum)
sprCount
unlist(sprCount)
sapply(spIns,sum)
ddply(InsectSprays, .(spray), summarise, sum=sum(count))
spraySum <- ddply(InsectSprays, .(spray), summarise, sum=ave(count, FUN=sum))