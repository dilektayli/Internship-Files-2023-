# Geometric distribution

# example 1
x_dgeom <- seq(2, 10, by= 1)
y_dgeom <- dgeom(x_dgeom, prob = 0.5)
plot(y_dgeom)

# example 2
x_dgeom <- seq(1, 7, by = 1)
y_dgeom <- dgeom(x_dgeom, prob = 0.05)
plot(y_dgeom)
