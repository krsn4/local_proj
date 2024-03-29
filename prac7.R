library('quantregForest')
################################################
## Load air-quality data (and preprocessing) ##
################################################
data(airquality)
set.seed(1)
## remove observations with mising values
airquality <- airquality[ !apply(is.na(airquality), 1,any), ]
## number of remining samples
n <- nrow(airquality)
## divide into training and test data
indextrain <- sample(1:n,round(0.6*n),replace=FALSE)
Xtrain <- airquality[ indextrain,2:6]
Xtest <- airquality[-indextrain,2:6]
Ytrain <- airquality[ indextrain,1]
Ytest <- airquality[-indextrain,1]
################################################
## compute Quantile Regression Forests ##
################################################
qrf <- quantregForest(x=Xtrain, y=Ytrain)
qrf <- quantregForest(x=Xtrain, y=Ytrain, nodesize=10,sampsize=30)
## predict 0.1, 0.5 and 0.9 quantiles for test data
conditionalQuantiles <- predict(qrf, Xtest)
print(conditionalQuantiles[1:4,])
## predict 0.1, 0.2,..., 0.9 quantiles for test data
conditionalQuantiles <- predict(qrf, Xtest, what=0.1*(1:9))
print(conditionalQuantiles[1:4,])
## estimate conditional standard deviation
conditionalSd <- predict(qrf, Xtest, what=sd)
print(conditionalSd[1:4])
4 quantregForest
## estimate conditional mean (as in original RF)
conditionalMean <- predict(qrf, Xtest, what=mean)
print(conditionalMean[1:4])
## sample 10 new observations from conditional distribution at each new sample
newSamples <- predict(qrf, Xtest,what = function(x) sample(x,10,replace=TRUE))
print(newSamples[1:4,])
## get ecdf-function for each new test data point
## (output will be a list with one element per sample)
condEcdf <- predict(qrf, Xtest, what=ecdf)
condEcdf[[10]](30) ## get the conditional distribution at value 30 for i=10
## or, directly, for all samples at value 30 (returns a vector)
condEcdf30 <- predict(qrf, Xtest, what=function(x) ecdf(x)(30))
print(condEcdf30[1:4])
## to use other functions of the package randomForest, convert class back
class(qrf) <- "randomForest"
importance(qrf) ## importance measure from the standard RF