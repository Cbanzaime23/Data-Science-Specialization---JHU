lambda <- 0.2
n <- 40
num.sims <- 1000
set.seed(4)

sim.data <- data.frame
#sim.data

names(sim.data) <- c("simulation.run", "mean")

for(i in 1:num.sims) {
        sim.data[i, 1] <- i
        sim.data[i, 2] <- mean(rexp(n, lambda))
        
}

t.mean <- 1 / lambda
s.mean <- mean(sim.data$mean)

paste0("The theoretical mean is: ", t.mean)

paste0("The simulated mean is: ", round(s.mean, 2))


#PLOT

#Generate normal distribution line
x.norm <- seq(min(sim.data$mean), max(sim.data$mean), length.out = 1000)
y.norm <- dnorm(x.norm, mean = 1/lambda, sd = (1 / lambda)/sqrt(n))

#Plot histogram of sample observed means
ggplot(data = sim.data, aes(mean, ..density..)) + 
        geom_histogram(breaks = seq(2, 8, by = 0.1),col = "dark blue",fill = "dark blue",alpha = 0.5) + 
        labs(title = "Histogram of Simulated Means",
             subtitle = "1,000 simulations of 40 exponentials") + 
        labs(x = "Simulated Mean", y ="Density") +
        geom_vline(aes(xintercept = 5), col = "red") +
        scale_x_continuous(breaks = seq(2, 8, by = 0.5)) +
        scale_y_continuous(breaks = seq(0, 0.6, by = 0.1)) +
        geom_text(aes(x = 5.8, y = 0.6, label = "<- Theoretical Mean"), col = "red") +
        geom_text(aes(x = 5.9, y = 0.5, label = "<- Normal Density")) + 
        theme(legend.position = "none") + 
        geom_line(aes(x.norm, y.norm))


