# DENSITY-BASED CLUSTERING 
# it is an unsupervised learning non-linear algorithm. 
# The data is partitioned into groups with similar characteristics or clusters but it does not require specifying the number of those groups in advance.

# Algorithm 
# 1. randomly select a point p
# 2. retrieve all the points that are density reachable from p with regard to Maximum radius of the neighborbood(EPS) and minimum number of points within eps neighborhood (Min Pts)
# 3. If the number of points in the neighborhood is more than Min Pts then p is a core point
# 4. For p core points, a cluster is formed. If p is not a core point, then mark it as a noise/outlier and move to the next point.
# 5. Contiune the process until all the points have been processed.


install.packages("fpc")
library(fpc)


data(iris)

# remove label aka species column that we want to predict
iris_1 <- iris[-5]

set.seed(22)
dbscan_cl <- dbscan(iris_1, eps = 0.45, MinPts = 5)
dbscan_cl

# checking cluster
dbscan_cl$cluster

# table
table(dbscan_cl$cluster, iris$Species)

# plotting cluster
plot(dbscan_cl, iris_1, main = "DBScan")
plot(dbscan_cl, iris_1, main = "Petal Width vs Sepal length")












