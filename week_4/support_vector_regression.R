###### Step 1 ---- Linear Regression Model
# Load the data from csv file
data <- read.csv(file = "regression.csv",sep = ",", header = T)

plot(data, pch = 16)

# create a linear regression model 
linear_regression_model <- lm(Y ~ X, data)

# add the fitted line
abline(linear_regression_model, col = "green")

# display the predictions
predicted_Y <- predict(linear_regression_model, data)

# compute RMSE (root mean square error)
rmse <- function(error){
  sqrt(mean(error^2))
}

error <- linear_regression_model$residuals # same as data$Y - predicted_Y
predictionRMSE <- rmse(error)
predictionRMSE


####### Step 2 ------ Support Vector Regression
# SVR Model

if(require(e1071)){
  model <- svm(Y ~ X, data)
  svr_predicted_Y <- predict(model, data)
  
  points(data$X, svr_predicted_Y, col = "red", pch = 4)

  # compute error
  error <- data$Y - svr_predicted_Y
  svr_prediction_rmse <- rmse(error) # 3.157061
  
  # okay now let's improve the performance by tuning
  tune_result <- tune(svm, Y ~ X, data = data, ranges = list(epsilon = seq(0, 1, 0.1), cost = 2^(2:9)))
  print(tune_result)
  # plot(tune_result)
  
  # draw the second tuning graph
  tune_result <- tune(svm, Y ~ X, data = data, ranges = list(epsilon = seq(0, 1, 0.2), cost = 2^(2:9)))
  print(tune_result)
  # plot(tune_result)
  
  
  plot(data, pch = 16)
  tuned_model <- tune_result$best.model
  predicted_tuned_model_Y <- predict(tuned_model, data)
  
  points(data$X, svr_predicted_Y, col = "red", pch = 2)
  lines(data$X, svr_predicted_Y, col = "red", pch = 2)
  
  points(data$X, predicted_tuned_model_Y, col = "blue", pch = 4)
  lines(data$X, predicted_tuned_model_Y, col = "blue", pch = 4)
  
  error <- data$Y - predicted_tuned_model_Y
  
  tuned_RMSE <- rmse(error)
  
  
  # now trying to find the functions coefficients 
  # y = w * x + b
  # Extract the coefficients (weights)
  weights <- tuned_model$coefs
  
  # Extract the intercept (bias)
  b <- tuned_model$rho  # Intercept term
  
  # but how we will convert hyperplane into a function with weight and bias values ???
  
  
}
svr_prediction_rmse


# linear regression line
abline(linear_regression_model, col = "green")











