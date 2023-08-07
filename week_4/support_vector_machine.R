# link: https://koalatea.io/r-svm-regression/ 

library(MASS) # to use the dataset Boston


###########
set.seed(1)
library(caret)
library(kernlab)
data(Boston)

model <- train(medv ~ . , data = Boston, method = "svmRadial") 
model
plot(model)


###########
# preprocessing with Caret
set.seed(1)
model_2 <- train(medv ~ ., data = Boston, method = "svmRadial", preProcess = c("center", "scale"))
model_2
plot(model_2)



###########
# splitting the data set, so we can check for overfitting
set.seed(1)
inTraining <- createDataPartition(Boston$medv, p = .8, list = F)
training <- Boston[inTraining, ]
testing <- Boston[-inTraining, ]

set.seed(1)
model_3 <- train(
  medv ~.,
  data = training, 
  method = "svmRadial",
  preProcess = c("center", "scale")
)
model_3
plot(model_3)


###########
# check on the test set by using subset method and make predictions with predict method
test.features = subset(testing, select = -c(medv))
test.target = subset(testing, select = medv)[, 1]

predictions = predict(model_3, newdata = test.features)

# RMSE
sqrt(mean((test.target - predictions)^2))

# R2
cor(test.target, predictions)^2



###########
# Cross validation
set.seed(1)
ctrl <- trainControl(
  method = "cv",
  number = 10
)

# now retrain the model and pass the trainControl parameter
set.seed(1)
model_4 <- train(
  medv ~., 
  data = testing,
  method = "svmRadial",
  preProcess = c("center", "scale"),
  trCtrl = ctrl
)
model_4 
plot(model_4)


predictions = predict(model_4, newdata = test.features)
sqrt(mean((test.target - predictions) ^2))
cor(test.target, predictions) ^2



###########
# Tuning Hyper Parameters
set.seed(1)

tuneGrid <- expand.grid(
  C = c(0.25, .5, 1),
  sigma = 0.1
)

model_5 <- train(
  medv~.,
  data = training, 
  method = "svmRadial",
  preProcess = c("center", "scale"),
  trControl = ctrl,
  tuneGrid = tuneGrid
)
model_5
plot(model_5)



