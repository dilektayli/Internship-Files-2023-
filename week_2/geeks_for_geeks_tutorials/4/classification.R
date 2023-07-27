install.packages("dplyr")
install.packages("caTools")
install.packages("caret")
install.packages("e1071")

library(dplyr)
library(caTools)
library(caret)
library(e1071)

data(iris)
str(iris)

set.seed(22)
split <- sample.split(iris$Species, SplitRatio = 0.7)
train_set <- subset(iris, split == TRUE)
test_set <- subset(iris, split == FALSE)

c_model <- glm(Species  ~. , data = train_set, family = "binomial")
predictions <- predict(c_model, newdata = test_set, type = "response")


predicted_classes <- ifelse(predictions > 0.5, "versicolor", "setosa")

conf_matrix <- table(predicted_classes, test_set$Species)
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)


















