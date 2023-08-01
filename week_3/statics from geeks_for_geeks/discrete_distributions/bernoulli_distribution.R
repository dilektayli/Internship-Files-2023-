# Bernoulli Distribution 
# it is a special case of Binomial distribution where only a single trial is performed. 
# It is a discrete probability distribution for a Bernoulli trial (a trial that has only two outcomes i.e. either success or failure)

install.packages("Rlab")
library(Rlab)

# example 1 
# dbern() measures density function of Bernoulli distribution
x <- seq(0, 10, by = 1)
y <- dbern(x, prob = 0.7)
plot(y, type = "o")


# example 2
# pbern() -> programming giver the distribution function for the Bernoulli distribution
x <- seq(0, 10, by = 1)
y <- pbern(x, prob = 0.7)
plot(y, type = "o")


# example 3
# qbern() -> quantile function for Bernoulli distribution
x <- seq(0, 1, by = 0.2)
y <- qbern(x, prob = 0.5, lower.tail = T, log.p = F)
plot(y, type = "o")


# example 4
# rbern() -> to generate a vector of random numbers which are Bernoulli distributed
set.seed(98999)
N <- 1000
random_values <- rbern(N, prob = 0.5)
hist(random_values, breaks = 10, main = "")















