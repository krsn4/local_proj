#Plotting
with(cars, plot(speed, dist))
#Lattice System
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))
#ggplot2
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)

# basic plot
hist(airquality$Ozone)
with(airquality, plot(Wind, Ozone))
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in NYC")

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC"), type = "n")
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

par(mfrow = c(1,2))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  })

x <- rnorm(100)
hist(x)
y <- rnorm(100)
plot(x,y)
par(mfrow = c(1,1))
par(mar = c(2,2,2,2))
plot(x,y)
par(mar = c(4,4,2,2))

plot(x,y, pch=20)
example(points)

x <- rnorm(100)
y <- x + rnorm(100)
g <- gl(2, 50)
g <- gl(2,50,labels=c("Male", "Female"))
str(g)
plot(x,y,type="n") #make the plot, but don't actually put the data
points(x[g == "Male"], y[g == "Male"], col="green")
points(x[g == "Female"], y[g == "Female"], col="blue", pch=19)

?Devices
