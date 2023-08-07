install.packages("ISLR")
install.packages("earth")

library(ISLR)
library(dplyr)
library(ggplot2)
library(earth)
library(caret)

head(Wage) # view the data

# Build and Optimize the MARS Model

hyper_grid <- expand.grid(degree = 1:3, nprune = seq(2, 50, length.out = 10) %>% floor())

set.seed(1)

# fit MARS model using k-fold cross-validation
cv_mars <- train(
  x = subset(Wage, select = -c(wage, logwage)),
  y = Wage$wage,
  method = "earth",
  metric = "RMSE",
  trControl = trainControl(method = "cv", number = 10),
  tuneGrid = hyper_grid
)

# display model with lowest test RMSE
cv_mars$results %>%
  filter(nprune == cv_mars$bestTune$nprune, degree == cv_mars$bestTune$degree)

ggplot(cv_mars)




















