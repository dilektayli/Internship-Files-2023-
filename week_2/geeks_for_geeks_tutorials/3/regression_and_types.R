# TYPES OF REGRESSION IN R
# Linear, Multiple, and Logistic Regression 

# LINEAR REGRESSION  y = ax + b where x is predictor/independent variable, y is response/dependent variable and a&b are coefficients
x <- c(153, 169, 140, 186, 128, 136, 178, 163, 152, 133)
y <- c(64, 81, 58, 91, 47, 57, 75, 72, 62, 49)

# creating a linear regression model
lr_model <- lm(y~x)

print(lr_model)

# find the weight of a person with height of 182
df <- data.frame(x = 168)
prediction <- predict(lr_model, df)

cat("Predicted value of a person with height 168: ")
print(prediction)

plot(x,y,main="Height vs Weight Linear Regression Model")
abline(lm(y~x))


# MULTIPLE REGRESSION
# y = a + x1*b1 + x2*b2 + x3*b3 + x4*b4...... + xn*bn

# dataset
input <- airquality[1:50, c("Ozone", "Wind", "Temp")]

# create multiple regression
mr_model <- lm(Ozone ~ Wind + Temp, data = input)

cat("Regression Model")
print(mr_model)
plot(mr_model)


# Logistic Regression 
# y = 1 / (1 + e^-z) where y is response variable and z is equation of independent variables/features

# creating model
lor_model <- glm(formula = vs ~wt, family = binomial, data = mtcars)

# creating a range of wt values
x <- seq(min(mtcars$wt), max(mtcars$wt), 0.01)

prediction <- predict(lor_model, list(wt = x), type = "response")
print(lor_model)
plot(mtcars$wt, mtcars$vs, pch = 16, xlab = "Weight", ylab = "VS")
lines(x,prediction)























