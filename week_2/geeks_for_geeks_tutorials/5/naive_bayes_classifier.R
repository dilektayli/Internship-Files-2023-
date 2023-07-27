# NAIVE BAYES CLASSIFIER
data(iris)
str(iris)

install.packages("e1071")
install.packages("caTools")
install.packages("caret")
library(e1071)
library(caTools)
library(caret)

# split data 
split <- sample.split(iris, SplitRatio = 0.7)
train_set <- subset(iris, split == "TRUE")
test_Set <- subset(iris, split == "FALSE")

# Feature Scaling
train_scale <- scale(train_set[, 1:4])
test_scale <- scale(test_set[,1:4])

# fitting Naive Bayes Model
set.seed(22)
nbc_model <- naiveBayes(Species ~., data = train_set)
nbc_model

# prediction with test data
prediction <- predict(nbc_model, newdata = test_set)

# confusion matrix 
cm <- table(test_set$Species, prediction)
cm

confusionMatrix(cm)



