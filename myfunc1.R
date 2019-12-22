myfunction <- function() {
  N <- rnorm(100)
  mean(N)
}

second <- function(x) {
  x + rnorm(length(x))
}

add2 <- function(x,y) {
  x+y
}

above_n <- function(v, n=10) {
  v[v > n]
}

colmean <- function(y, removeNA=TRUE) {
  nc <- ncol(y)
  means <- numeric(nc)
  for (i in 1:nc) {
    means[i] <- mean(y[,i], na.rm = removeNA)
  }
  means
}

x <- Sys.time()
quarters(x)
months(x)
p <- as.POSIXlt(x)
unclass(p)
names(unclass(p))
p$sec
unclass(x)

datestring <- c("January 10, 2010 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")

x <- as.Date("2012-01-01")
y <- strptime("9 January, 2011 1:34:21", "%d %B, %Y %H:%M:%S")
x-y
as.POSIXlt(x) - y


