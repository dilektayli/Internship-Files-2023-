## ----setup, include = FALSE-------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.width=6, fig.height=4, fig.align='center',
                      message = FALSE, warning=FALSE)


## ---------------------------------------------------------------------------------------------------
library(caret)
library(ggplot2)


## ---------------------------------------------------------------------------------------------------
pca <- prcomp(iris[iris$Species %in% c("virginica","versicolor"), 1:4], 
              retx = TRUE,  scale = TRUE, tol=0.4)
predicted <- predict(pca,iris[,1:4])
ggplot(data.frame(predicted)) +
  aes(x = PC1, y = PC2, color = iris$Species) +
  geom_point(aes(size = iris$Sepal.Length)) +
  stat_ellipse() +
  stat_ellipse(level = 0.8)


## ---------------------------------------------------------------------------------------------------
set.seed(1881) #sayı önemli değil rastgele verilmiş

n <- nrow(iris)
p <- ncol(iris)
nTest <- ceiling(n*0.3)
ind <- sample(n, nTest, FALSE)

tr <- iris[-ind,] # training set with 150*0.7 cols => 105 objects
ts <- iris[ind,] # test set with 150*0.3 cols => nTest => 45 objects 

# remove the column that you want to predict
tr.input <- tr[,-5]
ts.input <- ts[,-5]
tr.output <- factor(tr[,5])
ts.output <- factor(ts[,5])


## ---------------------------------------------------------------------------------------------------
# what you do in the train set do the same in the test set
prep <- preProcess(tr.input, method = c("center", "scale"))
tr.input.transformed <- predict(prep, tr.input)
ts.input.transformed <- predict(prep, ts.input)


## ---------------------------------------------------------------------------------------------------
ctrl <- trainControl(method = "repeatedcv", number = 5, repeats = 3) 
# monta carlo cross validation used -> divide the value into 5 parts that do cross validation ( 4 used compare with the 5th one) && and do 3 repetitions.


## ---------------------------------------------------------------------------------------------------
# Random forest method is used
fitRF <- train(y = tr.output, x = tr.input.transformed, method = "rf", trControl = ctrl, metric = "Accuracy")
fitRF


## ---------------------------------------------------------------------------------------------------
predRF <- predict(fitRF, ts.input.transformed)
predRF


## ---------------------------------------------------------------------------------------------------
tblRF <- table(predRF, ts.output)
confusionMatrix(tblRF)

