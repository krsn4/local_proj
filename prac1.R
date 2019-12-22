set.seed(123)

n=10
random = cbind(rnorm(n,20.5), rbinom(n,1,.25), runif(n,0,10),rexp(n, 1/5))

random = cbind(random, rgeom(n, .1))

group = rep(1:5, each=3)
n=length(group)
random2 = cbind(group, 1:n, rpois(n,25), rbeta(n,.5,.5))

q=seq(-3,3,by=0.5)
d=dnorm(q,0,1)
p=pnorm(q,0,1)
random3=cbind(q,d,p,qnorm(p,0,1))


mylm = lm(Sales ~ Income + Advertising, data=Carseats) 
summary(mylm)
anova(mylm)
plot(mylm)
predict(mylm)

mylm = lm(Sales ~ Income + Advertising + as.factor(ShelveLoc), data=Carseats)
summary(mylm)
anova(mylm)
plot(mylm)