## ----setup, include=FALSE---------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----data, warning=FALSE, message=FALSE-------------------------------------------------------------
data = read.table(file = "../data/wbdc2.txt", header = TRUE)
head(data[1:5])


## ----dataDim, warning=FALSE, message=FALSE----------------------------------------------------------
dim(data)


## ----str, warning=FALSE, message=FALSE--------------------------------------------------------------
str(data[,1:5])


## ----scatter, warning=FALSE, message=FALSE, fig.height=6, fig.width=6-------------------------------
library(caret)

featurePlot(x = data[,6:9], 
            y = factor(data$diagnosis), 
            plot = "ellipse",
            auto.key = list(columns = 3))



## ----box, warning=FALSE, message=FALSE--------------------------------------------------------------
library(caret)
featurePlot(x = data[,6:9], 
            y = factor(data$diagnosis), 
            plot = "box",
            auto.key = list(columns = 3))



## ----nzv, warning=FALSE, message=FALSE--------------------------------------------------------------
nzv <- nearZeroVar(data, saveMetrics= TRUE, freqCut = 10, uniqueCut = 10)
nzv


## ----dimData, warning=FALSE, message=FALSE----------------------------------------------------------
dim(data)


## ----filteredData, warning=FALSE, message=FALSE-----------------------------------------------------
nzv <- nearZeroVar(data, saveMetrics= FALSE, freqCut = 10, uniqueCut = 10)
names(data[nzv])


## ----filteredData2, warning=FALSE, message=FALSE----------------------------------------------------
filteredData <- data[, -nzv]
dim(filteredData)


## ----corr, warning=FALSE, message=FALSE-------------------------------------------------------------
corr <-  cor(filteredData[,-1])
highlyCorr <- findCorrelation(corr, cutoff = 0.95)
removedVars <- names(filteredData[,-1])[highlyCorr]
removedVars


## ----filteredHighCorr, warning=FALSE, message=FALSE-------------------------------------------------
filteredData <- filteredData[,!(names(filteredData)%in%removedVars)]
dim(filteredData)


## ----ztransform, warning=FALSE, message=FALSE, eval=FALSE-------------------------------------------
## ## bu fonksiyon şu anda çalıştırılmayacak
## ## eğitim ve test setleri belirlendikten sonra çalıştırılacak
## # preProcValues <- preProcess(training, method = c("center", "scale"))
## # trainStandardized <- predict(preProcValues, training)
## # testStandardized <- predict(preProcValues, test)


## ----partioning, warning=FALSE, message=FALSE-------------------------------------------------------
 library(caret)
 set.seed(1881)
 inTrain <- createDataPartition(y = filteredData$diagnosis, ## sınıf değişkeni
 p = 0.80, ## eğitim seti oranı 
 list = FALSE,
 times = 1)

 head(inTrain)



## ----trainSize, warning=FALSE, message=FALSE--------------------------------------------------------
 training <- filteredData[inTrain, ]
 testing <- filteredData[-inTrain, ]
 nrow(training)


## ----testSize, warning=FALSE, message=FALSE---------------------------------------------------------
 nrow(testing)


## ----preproc, warning=FALSE, message=FALSE, eval=TRUE-----------------------------------------------
preProcValues <- preProcess(training, method = c("center", "scale"))
trainStandardized <- predict(preProcValues, training)
testStandardized <- predict(preProcValues, testing)


## ----sbf, warning=FALSE, message=FALSE, eval=TRUE---------------------------------------------------
set.seed(1881)
filterCtrl <- sbfControl(functions = caretSBF, method = "repeatedcv", number = 5, repeats = 1)
featureSelect <- sbf(x=trainStandardized[,-1], y=factor(trainStandardized[,1]), sbfControl = filterCtrl)
featureSelect


## ----sbf2, warning=FALSE, message=FALSE, eval=TRUE--------------------------------------------------
featureSelect$variables$selectedVars


## ----rfe, warning=FALSE, message=FALSE, eval=TRUE---------------------------------------------------
set.seed(1881)

ctrl <- rfeControl(functions = rfFuncs,
                   method = "repeatedcv",
                   number = 5,
                   repeats = 1,
                   verbose = FALSE)

featureSelect <- rfe(x=trainStandardized[,-1], y=factor(trainStandardized[,1]),
                 sizes = c(1:30),
                 metric = "Accuracy",
                 rfeControl = ctrl)

featureSelect


## ----bestrfe, warning=FALSE, message=FALSE, eval=TRUE-----------------------------------------------
    bestSubset <- featureSelect$optVariables
    bestSubset


## ----fit, warning=FALSE, message=FALSE--------------------------------------------------------------

vars = c("diagnosis", bestSubset)
train = trainStandardized[,vars]
test = testStandardized[,vars]

train[1:5,1:4]



## ----dimTrain, warning=FALSE, message=FALSE---------------------------------------------------------

dim(train)



## ----fit2, warning=FALSE, message=FALSE-------------------------------------------------------------

 set.seed(1881)
 svmFit <- train(diagnosis ~ ., data = train, method = "svmRadial") 
 svmFit



## ----tune, warning=FALSE, message=FALSE-------------------------------------------------------------
set.seed(1881)
svmFit <- train(diagnosis ~ .,
 data = train,
 method = "svmRadial",
 tuneLength = 10)
 
 svmFit


## ----tune2, warning=FALSE, message=FALSE------------------------------------------------------------
 set.seed(1881)
 ctrl <- trainControl(method = "repeatedcv", number = 5, repeats = 3)

 svmFit <- train(diagnosis ~ .,
 data = train,
 method = "svmRadial",
 tuneLength = 10,
 trControl = ctrl)
 
 svmFit


## ----finalModel, warning=FALSE, message=FALSE-------------------------------------------------------
 set.seed(1881)
 ctrl <- trainControl(method = "repeatedcv", number = 5, repeats = 3,
                        classProbs = TRUE, summaryFunction = twoClassSummary)
 
 svmFit <- train(diagnosis ~ ., data = train,
                   method = "svmRadial",
                   tuneLength = 10,
                   trControl = ctrl,
                   metric = "ROC")
 
 svmFit


## ----predictClassesAccuracySvmFit, warning=FALSE, message=FALSE-------------------------------------
svmClasses <- predict(svmFit, newdata = test)


## ----confusionMatrixSvmFit, warning=FALSE, message=FALSE--------------------------------------------
confusionMatrix(data = svmClasses, factor(test$diagnosis), positive = "M")


## ----roc2, warning=FALSE, message=FALSE-------------------------------------------------------------

svmProbs <- predict(svmFit, newdata = test, type = "prob")
rocData <- data.frame(obs = factor(test$diagnosis), pred = svmClasses, svmProbs)
twoClassSummary(rocData, lev = levels(factor(test$diagnosis)))


## ----rdm, warning=FALSE, message=FALSE--------------------------------------------------------------
 set.seed(1881)

 ctrl <- trainControl(method = "repeatedcv", number = 5, repeats = 3,
                        classProbs = TRUE, summaryFunction = twoClassSummary)


 rfFit <- train(diagnosis ~ .,
 data = train,
 method = "rf",
 tuneLength = 10,
 trControl = ctrl,
 metric = "ROC")
 
 rfFit


## ----confusionMatrix9, warning=FALSE, message=FALSE-------------------------------------------------
 rfProbs <- predict(rfFit, newdata = test, type = "prob")
 rfClasses <- predict(rfFit, newdata = test)
 confusionMatrix(rfClasses, factor(test$diagnosis), positive = "M") 


## ----rocRF, warning=FALSE, message=FALSE------------------------------------------------------------
rocData <- data.frame(obs = factor(test$diagnosis), pred = rfClasses, rfProbs)
twoClassSummary(rocData, lev = levels(factor(test$diagnosis)))


## ----resamples, warning=FALSE, message=FALSE--------------------------------------------------------
 resamps <- resamples(list(svm = svmFit, rf = rfFit))
 head(resamps$values)


## ----diffs, warning=FALSE, message=FALSE------------------------------------------------------------
 diffs <- diff(resamps)
 summary(diffs)


## ----roc, warning=FALSE, message=FALSE--------------------------------------------------------------
library(pROC)

svmRoc=roc(test$diagnosis ~ svmProbs[,1])
rfRoc=roc(test$diagnosis ~ rfProbs[,1])

{plot = plot(svmRoc)
plot(rfRoc, add=TRUE, col='red')}




## ----varImp, warning=FALSE, message=FALSE-----------------------------------------------------------
plot(varImp(rfFit, scale = TRUE))


