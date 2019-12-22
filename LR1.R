# Learn R
mydata <- mtcars
mynewdata <- as_tibble(mydata)
cit_comm_loan_tape <- read_excel("C:/Users/akirasano/Documents/AuditAssisst/CIT/Commercial Loans Private Balance Amount.xlsx", sheet = "Fiserv - Commercial Loans")

make.power <- function(n) {
  pow <- function(x) {
    x^n
  }
}
cube <- make.power(3)
square <- make.power(2)

ls(environment(cube))
get("n", environment(cube))
ls(environment(square))

y <- 10
f <- function(x){
  y <- 2
  y^2 + g(x)
}
g <- function(x){
  x*y
}

make.NegLogLik <- function(data, fixed=c(F,F)){
  params <- fixed
  function(p){
    params[!fixed] <- p
    mu <- params[1]
    sigma <- params[2]
    a <- -0.5*length(data)*log(2*pi*sigma^2)
    b <- -0.5*sum((data-mu)^2) / (sigma^2)
    -(a + b)
  }
}

set.seed(1); normals <- rnorm(100, 1, 2)
nLL <- make.NegLogLik(normals)

ls(environment(nLL))
optim(c(mu = 0, sigma = 1), nLL)$par
#Fixing sigma=2
nLL <- make.NegLogLik(normals, c(F, 2))
optimize(nLL, c(-1, 3))$minimum

nLL <- make.NegLogLik(normals, c(1, FALSE))
x <- seq(1.7, 1.9, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y-min(y))), type = "l")


printmessage<- function(x){
  if(is.na(x))
    print("is a missing value")
  else if(x>0) 
    print(">0") 
  else 
    print("<=0") 
  invisible(x)}




set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)

set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x,y)

set.seed(1)
sample(1:10, 4)

system.time({
  n <- 1000
  r <- numeric(n)
  for (i in 1:n) {
    x <- rnorm(n)
    r[i] <- mean(x)
  }
})
