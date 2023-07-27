install.packages("ClusterR")
install.packages("cluster")

library(ClusterR)
library(cluster)

data(iris)
str(iris)

# remove labels
iris_1 <- iris[,-5]

set.seed(42)
kmeans.re <- kmeans(iris_1, centers = 3, nstart = 20)
kmeans.re

#cluster identification for each observation
kmeans.re$cluster

# confusion matrix
cm <- table(iris$Species, kmeans.re$cluster)

# model evaluation and visualization
plot(iris_1[c("Sepal.Length", "Sepal.Width")])
plot(iris_1[c("Sepal.Length", "Sepal.Width")], col = kmeans.re$cluster)
plot(iris_1[c("Sepal.Length", "Sepal.Width")], col = kmeans.re$cluster, main = "K-means with 3 clusters")

# Ploting cluster centers
kmeans.re$centers
kmeans.re$centers[,c("Sepal.Length","Sepal.Width")]

points(kmeans.re$centers[,c("Sepal.Length", "Sepal.Width")], col = 1:3, pch = 8, cex = 8)

# Visulaize clusters
y_kmeans <- kmeans.re$cluster
clusplot(iris_1[, c("Sepal.Length","Sepal.Width")], y_kmeans, lines = 0, shade = TRUE, color = TRUE, labels = 2, plotchat = FALSE, span = TRUE, main = paste("Cluster Iris"), xlab = "Sepal Length", ylab="Sepal Width")

