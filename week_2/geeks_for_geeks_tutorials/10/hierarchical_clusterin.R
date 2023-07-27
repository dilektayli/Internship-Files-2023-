# Hierarchical Clustering
# Types => 
# 1. Agglomerative Hierarchical clustering => starts at individual leaves and merges clusters. Bottom-up approach
# 2. Divisive Hierarchical clustering => starts at the root and recursively split clusters. Top-down approach


# Algorithm 
# make each data point in a single point of cluster that forms N clusters
# take the two closest data points and make them one cluster that forms N-1 clusters
# take the two closest clusters and make them one clusters that forms N-2 clusters
# repeat steps 3 until only one cluster


install.packages("dplyr")
library(dplyr)

head(mtcars)

# finding distance matrix 
distance_mat <- dist(mtcars, method = "euclidean")
distance_mat

# creating model
set.seed(22)
hier_model <- hclust(distance_mat, method = "average")
hier_model

plot(hier_model)

# cutting the tree by height
abline(h = 110, col = "green")

# choosing the number of clusters 
# 
fit <- cutree(hier_model, k = 3)
fit
table(fit)
rect.hclust(hier_model, k = 3, border = "red")













