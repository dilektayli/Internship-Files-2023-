# K-MEANS CLUSTERING
# Algorithm
# 1. specify the number of clusters (k)
# 2. Randomly assign each data point to a cluster
# 3. Calculate cluster centroids 
# 4. Re-allocate each data point their nearest cluster
# 5. Re-figure cluster centroid


install.packages("factoextra")
library(factoextra)

data <- mtcars

# Omitting NA values
data <- na.omit(data) 

# Scaling dataset
data <- scale(data)

km_model <- kmeans(data, centers = 4, nstart = 25)

# Visualize the clusters
fviz_cluster(km_model, data = data)











