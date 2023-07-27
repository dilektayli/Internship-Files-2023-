# 4 types of learning => supervised, unsupervised, semi-supervised, and reinforcement
# Supervised learning -> Classification(category) & Regression(numeric)

detach("package:caTools", unload = TRUE)


# SIMPLE LINEAR REGRESSION
data <- read.csv("Salaries.csv")

install.packages("caTools")
library(caTools)

# split data
split <- sample.split(data$salary, SplitRatio = 0.7)
train_set <- subset(data, split == TRUE)
test_set <- subset(data, split == FALSE)

# Fit the Linear Regression
lm.r <- lm(formula = salary ~ rank, data = train_set)

coef(lm.r) #extract model coefficients 

# Predict
predictions <- predict(lm.r, newdata = test_set)

library(ggplot2)

# visualize the predictions for train_set
ggplot() + geom_point(aes(x = train_set$rank, 
                          y = train_set$salary), 
                      colour = 'red') +
  geom_line(aes(x = train_set$rank, 
                y = predict(lm.r, newdata = train_set)), 
            colour = 'blue') +
  
  ggtitle('Salary vs Rank (Training set)') +
  xlab('Rank') +
  ylab('Salary') 

# visualize the predictions for test_set
ggplot() + geom_point(aes(x = test_set$rank, y = test_set$salary), colour = "pink") + 
  geom_line(aes(x = train_set$rank, y = predict(lm.r, newdata = train_set)), colour = "green") + 
  ggtitle("Salary vs Rank (test_set)") + 
  xlab("Rank") + 
  ylab("Salary")











