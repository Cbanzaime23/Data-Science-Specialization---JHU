

#Given
n <- 40
sample_size <- 10000
set.seed(127)
lambda <- 0.2



simulated_sample <- replicate(sample_size, rexp(n, lambda))
means_exponentials <- apply(simulated_sample, 2, mean)

#Mean Comparison

sample_mean <- mean(means_exponentials)
theoretical_mean <- 1/lambda


#Variance Comparison

sample_var <- var(means_exponentials)
theoretical_var <- (1/lambda) ^ 2 / (n)
sample_sd <- sd(means_exponentials)
theoretical_sd <- 1/(lambda * sqrt(n))

#Distribution

library("ggplot2")
plotdata <- data.frame(means_exponentials)
m <- ggplot(plotdata, aes(x <- means_exponentials))

m <- m + geom_histogram(aes(y =..density..), colour = "grey", fill = "grey66")

m <- m + labs(title = "Distribution of means of 40 Samples", x = "Mean of 40 Samples", y = "Density")

m <- m + geom_vline(aes(xintercept = sample_mean, colour = "sample"))

m <- m + geom_vline(aes(xintercept = theoretical_mean, colour = "theoretical"))

m <- m + stat_function(fun = dnorm, args = list(mean = sample_mean, sd = sample_sd), color = "gold1", size = 1.0)

m <- m + stat_function(fun = dnorm, args = list(mean = theoretical_mean, sd = theoretical_sd), colour = "red", size = 1.0)

m


#Confidence Interval
simulated_confinterval <- round(mean(means_exponentials) + c(-1,1) * 1.96 * sd(means_exponentials) / sqrt(n), 3)

theoretical_confinterval <- theoretical_mean + c(-1, 1) * 1.96 * sqrt(theoretical_var) / sqrt(n)
simulated_confinterval
theoretical_confinterval



