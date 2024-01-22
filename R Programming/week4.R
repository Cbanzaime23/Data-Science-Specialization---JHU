#Simulation

#Functions for probability distribution in R
#rnorm: generate random Normal variates with a given mean and standard deviation
#dnorm: evaluate the Normal probability density (with a given mean/SD) at a point (or a vector of points)
#pnorn: evaluate the cummulative distribution function for a Normal distribution
#rpois: generate random Poisson variates with a given rate


#Generating Random Numbers
#d for density
#r for random number generation
#p for cumulative distribution
#q for quantile function

#Working with the Normal Dist requires using these four functions
dnorm(x, mean = 0, sd = 1, log = FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean = 0, sd = 1)

x <- rnorm(10)
x
#generating  10 random variable, mean 20 and sd = 2
x <- rnorm(10, 20, 2)
x
mean(x)
sd(x)
summary(x)

#Seed
set.seed(1)
rnorm(5)
rnorm(5)
set.seed(1)
rnorm(5)

rpois(10, 1)
rpois(10, 2)
rpois(10, 20)

ppois(2, 2) #Cumulative Distribution Pr(x <= 2)
ppois(4, 2) #Pr(x <= 4)
ppois(6, 2) #Pr(x <= 6)

#Generating a random numbers from a linear model
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)

#What if x is binary?
set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)

#rpois function
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)


#Random sampling
set.seed(2)
sample(1:10, 4)
sample(1:10, 4)
sample(letters,5)
sample(1:10) # permutation
sample(1:10)
sample(1:10, replace = TRUE)

#Profiler
#Elaspe time is experienced by the programmer
#Elapse time > user time
system.time(readLines("http://www.jhsph.edu"))

#Elapse time < user time
hilbert <- function(n){
        i <- 1:n
        1 / outer(i - 1, i, "+")
}
x <- hilbert
system.time(svd(x))

#Timing longer expression
system.time({
        n <- 1000
        r <- numeric(n)
        for (i in 1:n) {
                x <- rnorm(n)
                r[i] <- mean(x)
                
        }
})

set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e

library(datasets)
Rprof()
fit <- lm(y ~ x1 + x2)
Rprof(NULL)






