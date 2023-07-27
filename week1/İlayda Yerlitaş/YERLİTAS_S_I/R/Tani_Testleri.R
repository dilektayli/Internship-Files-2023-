## ----setup, include=FALSE------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE, error = FALSE)


## ----isimlendirilmis listeler, warning = FALSE, message = FALSE----
library(APtools)

data(mayo)
head(mayo)


## ----değişkenleri düzenleme, warning = FALSE, message = FALSE----
library(pROC)

# mayoscore5 tanı testi için ROC analizi
roc.m5 <- roc(mayo$censor ~ mayo$mayoscore5, plot = TRUE, print.auc = TRUE, 
                      direction = "<", col = "red", lwd = 4, legacy.axes = TRUE, 
                      percent = FALSE, main = "ROC Curves for Combined Diagnostic Test")

# mayoscore4 tanı testi için ROC analizi
roc.m4 <- roc(mayo$censor ~ mayo$mayoscore4, plot = TRUE, print.auc = TRUE, 
                      direction = "<", col = "blue", lwd = 4, legacy.axes = TRUE, 
                      percent = FALSE, main = "ROC Curves for Combined Diagnostic Test")


## ---- warning = FALSE, message = FALSE-----------------------
library(epiR)

#Roc koordinatları

coord.m5 <- coords(roc.m5)
coord.m4 <- coords(roc.m4)

# Karmaşıklık matrisi (confusion matrix) veya 2×2 tablo
best.m5 <- coords(roc.m5, "best", ret = c("threshold","tp","tn","fp","fn"), 
                          best.method = "youden")
best.m4 <- coords(roc.m4, "best", ret = c("threshold","tp","tn","fp","fn"), 
                          best.method = "youden")
 
best.m5.tbl <- as.table(matrix(c(best.m5$tp, best.m5$fp, best.m5$fn, best.m5$tn), 
                                 nrow = 2, byrow = TRUE))
best.m4.tbl <- as.table(matrix(c(best.m4$tp, best.m4$fp, best.m4$fn, best.m4$tn), 
                                 nrow = 2, byrow = TRUE))

# Performans Degerlendirmesi
DiagStatMayoscore5 <- epi.tests(best.m5.tbl, conf.level = 0.95)
DiagStatMayoscore5
DiagStatMayoscore4 <- epi.tests(best.m4.tbl, conf.level = 0.95)
DiagStatMayoscore4


## ---- warning = FALSE, message = FALSE-----------------------
library(dtComb)



## ----exampleData1, warning = FALSE---------------------------
# load exampleData1
data(exampleData1)


## ----trainData-testData, warning = FALSE---------------------
# # train set of the exampleData1
trainData <- exampleData1[-c(83:138),]
testData <- exampleData1[c(83:138), 2:3]
head(trainData)



## ----Değişkenlerin oluşturulması,  warning = FALSE-----------
## Değişkenlerin oluşturulması 
markers <- trainData[, -1]
status <- factor(trainData$group, levels = c("not_needed", "needed"))



## ----echo=TRUE, message=FALSE, warning=FALSE, paged.print=TRUE, eval=FALSE----
## 
availableMethods()
## 


## ---- warning = FALSE, message = FALSE-----------------------

set.seed(2128)

#linComb fonksiyonu
lin_result <- linComb(markers = markers, 
                      status = status, 
                      event = "needed", 
                      method = "scoring", 
                      resample = "cv",
                      standardize = "range", 
                      ndigits = 2, direction = "auto", 
                      cutoff.method = "youden")

#nonlinComb fonksiyonu
nonlin_result <- nonlinComb(markers = markers, 
                            status = status, 
                            event = "needed", 
                            method = "lassoreg", 
                            include.interact = "TRUE",
                            resample = "boot", 
                            direction = "auto", 
                            cutoff.method = "youden")
#mlComb fonksiyonu
 ml_result <- mlComb(markers = markers, 
                     status = status, 
                     event = "needed",
                     method = "knn",
                     resample = "repeatedcv", nfolds = 10, nrepeats = 5,
                     preProcess = c("center", "scale"), 
                     direction = "<", cutoff.method = "youden")
 
 #mathComb fonksiyonu
 math_result <- mathComb(markers = markers, 
                         status = status, 
                         event = "needed",
                         method = "distance",
                         distance = "euclidean",
                         direction = "<",
                         cutoff.method = "youden")
 


## ---- warning = FALSE, message = FALSE-----------------------

#Hadi yeni tahmin yapalım! 
predComb(lin_result, testData)

