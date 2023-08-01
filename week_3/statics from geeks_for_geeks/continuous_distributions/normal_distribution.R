# STATISTICS 
# Statistics is a form of mathematical analysis that concerns the collection, organization, analysis, interpretation, and presentation of data. The statistical analysis helps to make the best use of the vast data available and improves the efficiency of solutions. 


# Normal Distribution in R
# Normal distribution is a probability function used in statistics that tells about how the data values are distributed. 
# 4 ways to generate normal distribution -> dnorm, pnorm, qnorm, rnorm


# example 1
# dnorm() -> measures density function of distribution
x <- seq(-15, 15, by = 0.1)
y <- dnorm(x, mean(x), sd(x))
png(file = "dnorm_example.png")
plot(x, y)
dev.off()
plot(x)


# example 2
# pnorm() -> cumulative distribution function which measures the probability that a random number X takes a value less than or equal to x. 
x <- seq(-10, 10, by = 0.1)
y <- pnorm(x, mean = 2.5, sd = 2)
plot(x, y)


# example 3
# qnorm() -> inverse of pnorm() function. Useful in finding the percentiles of normal distribution
x <- seq(0, 1, by = 0.02)
y <- qnorm(x, mean(x), sd(x))
plot(x, y)
 

# example 4
# rnorm() -> used to generate a vector of random numbers which are normally distributed.
x <- rnorm(10000, mean = 90, sd = 5)
hist(x, breaks = 50)





