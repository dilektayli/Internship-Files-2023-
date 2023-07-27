
library(parallel)
library(rbenchmark)
library(foreach)
library(doParallel)
library(caret)

data(iris)
TrainData <- iris[,1:4]
TrainClasses <- iris[,5]


## Paralel işlemcilerin aktive edilmesi. Type olarak "PSOCK" en iyi sonucu vermektedir. 
## "FORK" type seçilebilir, ancak, bu yapı Windows sistemlerde çalışmamaktadır.
## 4 çekirdek aktif ediliyor.
cl <- parallel:::makeCluster(spec = 8, type = "PSOCK")
cl <- parallel:::makeCluster(spec = 4, type = "PSOCK")
cl2 <- snow::makeCluster(spec = 4, type = "SOCK")

## Register multicores for "foreach" package
doParallel:::registerDoParallel(8)

n = 16  # Çekirdeklerde yapılacak olan toplam modelleme sayısı.
ctrl <- trainControl(method = "cv", number = 5, repeats = 5)

# TrainData ve TrainClasses nesneleri bütün paralel işlemcilerde kullanılacağı için bu nesneler çekirdeklere export ediliyor.
clusterExport(cl, c("TrainData", "TrainClasses", "ctrl"))

# "cl" çekirdeklerinde 16 farklı model kurularak bu modellerden elde edilen "Accuracy" değerleri return ediliyor.
# Bu işlemin paralel olarak çalışması için "clusterApply" veya "parLapply" kullanılabilir.

# 1. clusterApply(...)
parallelApply <- function(){
  clusterApply(cl, 1:n, fun = function(x){
    library("caret")
    knnFit1 <- train(TrainData, TrainClasses,
                     method = "knn",
                     preProcess = c("center", "scale"),
                     tuneLength = 2,
                     trControl = ctrl)
    return(knnFit1$results$Accuracy[1])
  })
}

# # Paralel işlem süresi:
# system.time({
#   acc1()
# })

# 2. lapply(...): Yukarıdaki işlemin paralel kodlama olmadan yapılması durumu:
sequentialApply <- function(){
  lapply(1:n, FUN = function(x){
    library("caret")
    knnFit1 <- train(TrainData, TrainClasses,
                     method = "knn",
                     preProcess = c("center", "scale"),
                     tuneLength = 2,
                     trControl = ctrl)
    return(knnFit1$results$Accuracy[1])
  })
}

# # Paralel olmadığı durumda işlem süresi
# system.time({
#   acc2()
# })

# 3. foreach
parallelForeach <- function(...){
  foreach(i=1:n, .inorder = FALSE, 
          .export = c("TrainData", "TrainClasses", "ctrl"), 
          .packages = "caret", .combine = "rbind", ...) %dopar% {
    library("caret")
    knnFit1 <- train(TrainData, TrainClasses,
                     method = "knn",
                     preProcess = c("center", "scale"),
                     tuneLength = 2,
                     trControl = ctrl)
    return(knnFit1$results$Accuracy[1])
  }
}

# ## System time "foreach"
# system.time({
#   acc3()
# })

benchmark(parallelForeach(), parallelApply(), sequentialApply(), replications = 10)
benchmark(parallelForeach(), parallelApply(), replications = 10)
