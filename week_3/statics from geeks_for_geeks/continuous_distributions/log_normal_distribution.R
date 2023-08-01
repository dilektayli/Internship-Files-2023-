# plot log normal distribution


# example 1
curve(dlnorm(x, meanlog = 0, sdlog = 1), from = 0, to = 25)


# example 2
curve(dlnorm(x), from = 0, to = 25)


# example 3
curve(dlnorm(x, meanlog=0, sdlog=.3), from=0, to=25, col='blue')
curve(dlnorm(x, meanlog=1, sdlog=.5), from=0, to=25, col='red', add=TRUE)
curve(dlnorm(x, meanlog=2, sdlog=1), from=0, to=25, col='purple', add=TRUE)



















