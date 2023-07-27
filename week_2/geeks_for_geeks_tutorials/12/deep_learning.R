install.packages("mlbench")
install.packages("deepnet")
library(mlbench)
library(deepnet)

data("BreastCancer")
# remove the rows with missing data
BreastCancer <- BreastCancer[which(complete.cases(BreastCancer) == TRUE),]

head(BreastCancer)
names(BreastCancer)

y <- as.matrix(BreastCancer[,11])
y[which(y == "benign")] = 0
y[which(y == "malignant")] = 1

# applying the deepnet package to data 
y <- as.numeric(y)
x <- as.numeric(as.matrix(BreastCancer[,2:10]))
x <- matrix(as.numeric(x), ncol = 9)

# applying nn.train() function 
nn_model <- nn.train(x, y, hidden = c(5))
prediction <- nn.predict(nn_model, x)
print(head(prediction))

yhat <- matrix(0, length(prediction), 1)
yhat[which(prediction > mean(prediction))] = 1
yhat[which(prediction <= mean(prediction))] = 0

# confusion matrix 
cm <- table(y, yhat)
print(cm)
print(sum(diag(cm))/sum(cm))














