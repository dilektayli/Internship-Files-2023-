## ----setup, include = FALSE-------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.align='center',
                      message = FALSE, warning=FALSE, fig.pos = 'h')


## ----"kutuphane_yükleme"----------------------------------------------------------------------------
library(caret)
library(magrittr)
library(dplyr)
library(lattice)

source("../functions/findOutliers.R")
source("../functions/diagnosticPlots.R")
source("../functions/multiplot.R")
source("../functions/rmse.R")


## ----"veri_yükleme"---------------------------------------------------------------------------------
bfd <- read.table("../data/bodyfat.txt", header = TRUE)
bfd <- bfd[,-2]
head(bfd)


## ----"veri_görsel_önincelemesi"---------------------------------------------------------------------
theme1 <- trellis.par.get()
theme1$plot.symbol$col = rgb(.2, .2, .2, .4)
theme1$plot.symbol$pch = 16
theme1$plot.line$col = rgb(1, 0, 0, .7)
theme1$plot.line$lwd <- 2
trellis.par.set(theme1)

featurePlot(x = bfd[, -1], y = bfd[, 1], plot = "scatter", type = c("p", "r"), span = 0.7)


## ----"asiri_degerlerin_tespiti_ve_cikarilmasi"------------------------------------------------------
tmp <- lapply(bfd, findOutliers, abs.cutoff.z = 3)
out.idx <- unique(unlist(tmp)) ## Aykırı gözlemlerin sıra numaraları.
if (!is.null(out.idx)){
  bfd <- bfd[-out.idx, ]
}
out.idx


## ----"veri_görsel_yeniden_incelemesi"---------------------------------------------------------------
theme1 <- trellis.par.get()
theme1$plot.symbol$col = rgb(.2, .2, .2, .4)
theme1$plot.symbol$pch = 16
theme1$plot.line$col = rgb(1, 0, 0, .7)
theme1$plot.line$lwd <- 2
trellis.par.set(theme1)

featurePlot(x = bfd[, -1], y = bfd[, 1], plot = "scatter", type = c("p", "r"), span = 0.7)


## ----"near_zero_variance"---------------------------------------------------------------------------
nzv <- nearZeroVar(bfd, saveMetrics= TRUE, freqCut = 10, uniqueCut = 10)
nzv


## ---------------------------------------------------------------------------------------------------
corr <- cor(bfd)
highlyCorr <- findCorrelation(corr, cutoff = 0.95)
highlyCorr


## ---------------------------------------------------------------------------------------------------
set.seed(1881)
inTrain <- createDataPartition(y = bfd$UnderwaterDensity, ## sınıf değişkeni
                               p = 0.80, ## eğitim seti oranı 
                               list = FALSE,
                               times = 1)

head(inTrain)
train <- bfd[inTrain, ]
test <- bfd[-inTrain, ]
dim(train)
dim(test)


## ---------------------------------------------------------------------------------------------------
preProcValues <- preProcess(train, method = c("center", "scale"))
train.std <- predict(preProcValues, train)
test.std <- predict(preProcValues, test)


## ---------------------------------------------------------------------------------------------------
set.seed(1881)
ctrl <- rfeControl(functions = rfFuncs,
                   method = "repeatedcv",
                   number = 5,
                   repeats = 1,
                   verbose = FALSE)

featureSelect <- rfe(x=train.std[,-1], y=train.std[,1],
                     sizes = c(1:30),
                     metric = "RMSE",
                     rfeControl = ctrl)

featureSelect
bestSubset <- featureSelect$optVariables
bestSubset

vars <- c("UnderwaterDensity", bestSubset)
tr <- train.std[,vars]
ts <- test.std[,vars]


## ---------------------------------------------------------------------------------------------------
fitLM <- train(x = tr[,-1], y = tr[,1], method = "lm", tuneLength = 10,
               trControl = trainControl(method = "repeatedcv", number = 5, repeats = 3))
fitLM


## ---------------------------------------------------------------------------------------------------
fitSVM <- train(x = tr[,-1], y = tr[,1], method = "svmRadial", tuneLength = 10,
               trControl = trainControl(method = "repeatedcv", number = 5, repeats = 3))
fitSVM


## ---------------------------------------------------------------------------------------------------
fitRF <- train(x = tr[,-1], y = tr[,1], method = "rf", tuneLength = 10,
                trControl = trainControl(method = "repeatedcv", number = 5, repeats = 3))
fitRF


## ---------------------------------------------------------------------------------------------------
fitLASSO <- train(x = tr[,-1], y = tr[,1], method = "lasso", tuneLength = 10,
               trControl = trainControl(method = "repeatedcv", number = 5, repeats = 3))
fitLASSO


## ---------------------------------------------------------------------------------------------------
predLM <- predict(fitLM, newdata = ts[,-1])
predSVM <- predict(fitSVM, newdata = ts[,-1])
predRF <- predict(fitRF, newdata = ts[,-1])
predLASSO <- predict(fitLASSO, newdata = ts[,-1])

RMSE <- data.frame(rmseLM = rmse(predLM, ts[,1]), rmseRF = rmse(predRF, ts[,1]), 
                   rmseSVM = rmse(predSVM, ts[,1]), rmseLASSO = rmse(predLASSO, ts[,1]))
print(RMSE)


## ---------------------------------------------------------------------------------------------------
model <- fitLM
res.train <- data.frame(Actual = ts[,1], Predicted = predLM)

res.train <- res.train %>%
  mutate(Residuals = Actual - Predicted, 
         Std.Residuals = Residuals / sd(Residuals))

res.train <- data.frame(ResidID = 1:nrow(res.train), res.train)

plots <- diagnosticPlots(res.train)
multiplot(plotlist = plots, cols = 2)



## ---------------------------------------------------------------------------------------------------
sessionInfo()

