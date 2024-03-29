library('MeanShift')
## an example using the iris dataset
## help( iris )
## prepare data matrix
iris.data <- t( iris[,c( "Sepal.Length", "Sepal.Width" )] )
## run blurring mean shift algorithm
clustering <- bmsClustering( iris.data )
print( clustering )
## plot the clusters
## Not run:
plot( iris.data[1,], iris.data[2,], col=clustering$labels+2, cex=0.8,
      pch=16, xlab="Sepal.Length", ylab="Sepal.Width" )
points( clustering$components[1,], clustering$components[2,],
        col=2+( 1:ncol( clustering$components ) ), cex=1.8, pch=16 )
## End(Not run)
