names(dat) # Stock_FX_Bond.csv imported, named as dat
attach(dat)
par(mfrow=c(1,2))
plot(GM_AC)
plot(F_AC)
n=dim(dat)[1]
GMReturn = GM_AC[2:n]/GM_AC[1:(n-1)] - 1
FReturn = F_AC[2:n]/F_AC[1:(n-1)] - 1
par(mfrow=c(1,1))
plot(GMReturn, FReturn)
