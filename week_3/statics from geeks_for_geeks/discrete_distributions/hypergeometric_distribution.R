# Hypergeometric Distribution
# it is used to calculate probabilities when sampling without replacement is to be done in order to get the density value
# 4 functions -> dhyper, phyper, qhyper, rhyper

# example 1
# dhyper() -> to get the density value
x_dhyper <- seq(0, 22, by = 1.2)
y_dhyper <- dhyper(x_dhyper,  m = 45, n = 30, k = 20)
plot(y_dhyper)


# example 2
# phyper() -> used estimating the number of faults initially resident in a program at the beginning of the test or debugging process based on the hypergeometric distribution and calculate each value in x using the corresponding values.
x_hyper <- seq(0, 22, by = 1)
y_phyper <- phyper(x_hyper, m = 40, n = 20, k = 31)
plot(y_phyper)


# example 3
# qhyper() -> used to specify a sequenct of probabilites btw 0 and 1
x_qhyper <- seq(0, 1, by = 0.02)
y_qhyper <- qhyper(x_qhyper, m = 49, n = 18, k = 30)
plot(y_qhyper)



# example 4
# rhyper() -> generating random numbers function by specifiying a seed and sample size
set.seed(400)
N <- 10000
y_rhyper <- rhyper(N, m = 50, n = 20, k = 30)
hist(y_rhyper, breaks = 50, main = "")













