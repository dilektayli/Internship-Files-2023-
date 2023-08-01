# Binomial Distribution
# it is a discrete distribution and has only two outcomes. All its trials are independent, the probability of sucess remains the same and the previous outcome does not affect the next outcome. 

# example 1
# dbinom() -> used to find probability at a particular value for a data that follows binomial distributions
dbinom(3, size = 13, prob = 1/6)
probabilities <- dbinom(x = c(0:10), size = 10, prob = 1 / 6)
plot(0:10, probabilities, type = "l")


# example 2
# pbinom() -> used to find the cumulative probability of data following binomial distribution till a given value ie its finds. 
pbinom(3, size = 13, prob = 1/6)
plot(0:10, pbinom(0:10, size = 10, prob = 1/6), type = "l")


# example 3
# qbinom() -> used to find the nth quantile
qbinom(0.841, size = 13, prob = 1/6)
x <- seq(0, 1, by = 0.1)
y <- qbinom(x, size = 13, prob  =1/6)
plot(x, y, type = "l")


# example 4
# rbinom() -> generates n random variables of a particular probability
rbinom(8, size= 13, prob = 1/6)
hist(rbinom(8, size = 13, prob = 1/6))























