# K-NEAREST NEIGHBOR SUPERVISED NON-LINEAR CLASSIFICATION ALGORITHM
# Steps 
# 1. choose the number of k
# 2. take the k nearest neighor of unknown data point according to distance
# 3. Among the k-neighbors, count the number of data points in each category
# 4. Assign the new data point to a category, where you counted the most neighbors (you can use Euclidean Distance)

install.packages("e1071")
install.packages("caTools")
install.packages("class")

library(e1071)
library(caTools)
library(class)


data(iris)
str(iris)

# Split data
split <- sample.split(iris, SplitRatio = 0.7)
train_set <- subset(iris, split == TRUE)
test_set <- subset(iris, split == FALSE)

# Feature Scaling
train_scale <- scale(train_set[,1:4])
test_scale <- scale(test_set[,1:4])

# fit the model
knn_model <- knn(train = train_scale, test = test_scale, cl = train_set$Species, k = 1)

# Confusion matrix
cm <- table(test_set$Species, knn_model)
cm

# Evaluating Model - Calculating out of sample error
misClassError <- mean(knn_model != test_set$Species)
print(paste("Accuracy = ", 1- misClassError))


# K = 3
knn_model <- knn(train = train_scale, test = test_scale, cl = train_set$Species, k = 3)
misClassError <- mean(knn_model != test_set$Species)
print(paste("Accuracy = ", 1- misClassError))


# K = 5
knn_model <- knn(train = train_scale, test = test_scale, cl = train_set$Species, k = 5)
misClassError <- mean(knn_model != test_set$Species)
print(paste("Accuracy = ", 1- misClassError))

# K = 7
knn_model <- knn(train = train_scale, test = test_scale, cl = train_set$Species, k = 7)
misClassError <- mean(knn_model != test_set$Species)
print(paste("Accuracy = ", 1- misClassError))


# K = 9
knn_model <- knn(train = train_scale, test = test_scale, cl = train_set$Species, k = 9)
misClassError <- mean(knn_model != test_set$Species)
print(paste("Accuracy = ", 1- misClassError))

# K = 17
knn_model <- knn(train = train_scale, test = test_scale, cl = train_set$Species, k = 17)
misClassError <- mean(knn_model != test_set$Species)
print(paste("Accuracy = ", 1- misClassError))

# K = 40
knn_model <- knn(train = train_scale, test = test_scale, cl = train_set$Species, k = )
misClassError <- mean(knn_model != test_set$Species)
print(paste("Accuracy = ", 1- misClassError))










