# Random Forest 
install.packages("caTools")       
install.packages("randomForest")  

library(caTools)
library(randomForest)

data(iris)


# splitting data
split <- sample.split(iris, SplitRatio = 0.7)
train_set <- subset(iris, split == TRUE)
test_set <- subset(iris, split == FALSE)

# create model
set.seed(22)
rf_model <- randomForest(x = train_set[-5], y = train_set$Species, ntree = 500)

# predict on test set
prediction <- predict(rf_model, newdata = test_set[-5])

# confusion matrix 
cm <- table(test_set[,5], prediction)
cm

plot(rf_model)

# importance plot
importance(rf_model)

# variable importance plot
varImpPlot(rf_model)



















