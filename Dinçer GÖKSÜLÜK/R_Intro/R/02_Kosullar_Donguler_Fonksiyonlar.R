## ----setup, include = FALSE-----------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.width = 6, fig.height = 4, fig.align = 'center',
                      message = FALSE, warning = TRUE)


## ----chunk1: if..else.. yapısı, eval = FALSE------------------------------------------------------------------------------------------------------
## # İki durumlu mantıksal sınama:
## if (koşul){
##   <Koşul doğru ise>
## } else {
##   <Koşul yanlış ise>
## }
## 
## ## İkiden fazla durumlu mantıksal sınama:
## if (koşul1){
##   <Koşul1 doğru ise>
## } else if (koşul2){
##   <Koşul2 yanlış ise>
## } ... {
## 
## } else {
##   <Yukarıdaki koşulların hiç birisi doğru değil ise>
## }


## ----chunk2: if..else.. örnek---------------------------------------------------------------------------------------------------------------------
Cinsiyet <- "K"

if (Cinsiyet == "K"){
  Cinsiyet <- "Kadın"
  print("K olarak girilmiş olan cinsiyet bilgisi 'Kadın' olarak yeniden düzenlendi.")
} else {
  Cinsiyet <- "Erkek"
  print("E olarak girilmiş olan cinsiyet bilgisi 'Erkek' olarak yeniden düzenlendi.")
}


## ----chunk3: ifelse() fonksiyonu, eval = FALSE----------------------------------------------------------------------------------------------------
## cinsiyet <- "K"
## cinsiyet2 <- ifelse(cinsiyet == "K", "Kadın", "Erkek")
## 
## print(cinsiyet2)


## ----chunk4: çoklu if..else.. yapıları------------------------------------------------------------------------------------------------------------
# Kişilere ait bilgiler bir listede birleştirilmiştir.
person1 <- list(Ad = "Dinçer", Soyad = "Göksülük", Kolesterol = 182, Cinsiyet = 1, Tanı = NA)
person2 <- list(Ad = "Ayşe", Soyad = "Aslan", Kolesterol = 194, Cinsiyet = 2, Tanı = NA)

if (person1$Cinsiyet == 1){
  if (person1$Kolesterol >= 200 ){
    tani1 <- "Pozitif"
  } else {
    tani1 <- "Negatif"
  }
} else {
  if (person1$Kolesterol >= 180 ){
    tani1 <- "Pozitif"
  } else {
    tani1 <- "Negatif"
  }
}

person1$Tanı <- tani1

if (person2$Cinsiyet == 1){
  if (person2$Kolesterol >= 200 ){
    tani2 <- "Pozitif"
  } else {
    tani2 <- "Negatif"
  }
} else {
  if (person2$Kolesterol >= 180 ){
    tani2 <- "Pozitif"
  } else {
    tani2 <- "Negatif"
  }
}

person2$Tanı <- tani2

data <- list(person1, person2)
data


## ----if..else.. condition length > 1 hatası, eval = FALSE-----------------------------------------------------------------------------------------
## cinsiyet <- c(1, 2, 1, 2, 2)  # 1: Erkek  2: Kadın
## cinsiyet == 1
## 
## # R 4.2.0 sürümü itibari ile hata mesajı olarak dönmektedir.
## # 4.2.0 öncesi sürümlerde bu durum uyarı mesajı olarak dönecektir.
## if (c(cinsiyet == 1)){
##   cat("\n Cinsiyet: Erkek")
## } else {
##   cat("\n Cinsiyet: Kadın")
## }


## ----if..else.. condition length > 1 hatası (örnek 2), eval = FALSE-------------------------------------------------------------------------------
## x <- c(1, 3, 4, 5, 11)
## 
## x > 10
## 
## if (x > 10){
##   cat("\nVeri setinde 10'dan büyük değer vardır.")
## } else {
##   cat("\nVeri setinde 10'dan büyük değer yoktur.")
## }


## ----any() ve all() fonksiyonları, eval = FALSE---------------------------------------------------------------------------------------------------
## # x vektöründe 10'dan küçük değerin olup olmadığının araştırılması
## sonuc <- (x < 10)  # TRUE/FALSE vektörü
## 
## # sonuc vektöründe en az 1 TRUE olup olmadığı
## any(x < 10)
## 
## # sonuc vektöründe bütün değerlerin TRUE olup olmadığı
## all(x < 10)


## ----logical sonuçların as.numeric() dönüşümü, eval = FALSE---------------------------------------------------------------------------------------
## # x vektöründe 10'dan küçük değerin olup olmadığının araştırılması
## sonuc <- (x < 10)  # TRUE/FALSE vektörü
## 
## # TRUE/FALSE vektörünün 1/0 vektörüne dönüştürülmesi
## sonuc2 <- as.numeric(sonuc)
## 
## # sonuc2 vektörü yardımı ile x vektöründe 10'dan küçük değer olup olmadığını
## # nasıl belirleyebiliriz?


## ----çoklu koşul tanımlamaları (AND ve OR yapıları), eval = FALSE---------------------------------------------------------------------------------
## person1 <- list(Ad = "Dinçer", Soyad = "Göksülük", Kolesterol = 182, Cinsiyet = 1, Tanı = "Negatif")
## person2 <- list(Ad = "Ayşe", Soyad = "Aslan", Kolesterol = 194, Cinsiyet = 2, Tanı = "Pozitif")
## 
## if (person1$Cinsiyet == 1 & person1$Tanı == "Pozitif"){
##   cat("Person1 pozitif tanı alan bir erkek hastadır.")
## } else {
##   cat("Person1 pozitif tanı alan bir erkek hasta değildir.")
## }
## 
## if (person2$Cinsiyet == 1 & person2$Tanı == "Pozitif"){
##   cat("Person2 pozitif tanı alan bir erkek hastadır.")
## } else {
##   cat("Person2 pozitif tanı alan bir erkek hasta değildir.")
## }


## ----mantıksal sınamalarda || ve && kullanımları, eval = FALSE------------------------------------------------------------------------------------
## v1 <- c(TRUE, FALSE, TRUE, TRUE)
## v2 <- c(TRUE, TRUE)
## v3 <- c(FALSE, FALSE, TRUE)
## 
## v1 & v2
## v2 & v1
## v1 | v2
## 
## v1 & v3  # Uyarı veriyor. Neden?
## 
## # R 4.2.0 sürümünde uyarı veriyor.
## # 4.2.1 ve sonraki sürümlerde && ve || kullanımlarında da logical vektör kullanılması durumunda hata mesajı dönecektir.
## v1 && v3


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## x1 <- 40
## x2 <- 17
## 
## # x1 ve x2 sayılarının 20'den küçük veya  50'dan büyük bir çift sayı olup
## # olmadığını belirleyelim.
## 
## # Çift sayı:
## kalan <- x1 %% 2  # x1'in 2'ye bölümünden kalan
## 
## # if ((x1 20'den küçük çift sayı) VEYA (x1 40'dan büyük çift sayı)) {
## #   ....
## # } else {
## #   ....
## # }


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## for (<dizi>){
##   <komutlar>
## }


## -------------------------------------------------------------------------------------------------------------------------------------------------
x <- 1:100
# x <- seq(from = 1, to = 100, by = 1)

## Yöntem 1:
sonuc <- NULL
for (i in 1:length(x)){
  if (x[i] %% 7 == 0){
    sonuc <- c(sonuc, x[i])
  }
}

## Yöntem 2:
sonuc2 <- NULL
for (i in x){
  if (i %% 7 == 0){
    sonuc2 <- c(sonuc2, i)
  }
}

rbind(sonuc, sonuc2)


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## # 1 ile 100,000 arasındaki bütün değerlerin logaritmasını üç farklı yöntem ile
## # hesaplayalım.
## 
## x <- 1:100000
## # x <- seq(from = 1, to = 100, by = 1)
## 
## # Yöntem 1: Vektörel hesaplama
## # log(...) fonksiyonu içerisinde vektör kullanılır ise logaritma işlemi vektörün
## # her elemanına hızlı bir şekile uygulanır.
## system.time({
##   logx1 <- log(x)
## })
## 
## # Yöntem 2: for döngüsü ile birlikte elde edilen her sonucun birbiri ardına
## # eklenerek bütün değerlerin logaritmasının alınması.
## system.time({
##   logx2 <- NULL
##   for (i in 1:length(x)){
##     logx2 <- c(logx2, log(x[i]))
##   }
## })


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## # x vektörü ile aynı boyutta bütün elemanları 0 olan bir sonuç vektörü
## # oluşturulur. Her adımda elde edilen sonuç, ilgili vektörün ilgili elemanına
## # aktarılır.
## 
## logx3 <- numeric(length(x))
## system.time({
##   for (i in 1:length(x)){
##     logx3[i] <- log(x[i])
##   }
## })
## 
## # Elde edilen sonuçların aynı olup olmadığının kontrol edilmesi
## identical(logx1, logx2, logx3)


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## x <- 1:100
## 
## for (<dizi>){
##   <komutlar>
## }
## 
## # x vektörünün ortalaması
## 


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## while (koşul){
##   <kodlar>
## }


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## x <- 1:100
## n <- length(x)
## 
## i <- 1
## toplam <- 0
## 
## # while döngüsüne girebilmek için koşulun sağlanmış olması gerekir.
## # Aksi durumda döngü çalıştırılmadan bir sonraki kod satırlarına geçilir.
## while (i < n){
##   toplam <- toplam + x[i]
##   i <- i + 1   ## Koşulun incelendiği eleman döngü içinde
##                ## düzenli olarak güncellenmelidir.
## }
## mu <- toplam / n
## 
## print(mu)


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## # 10 binde 1 ihtimal ile Bernoulli dağılımından sonuç 1 veya 0 olacak
## # şekilde veri üretiliyor.
## sma_sonuc <- rbinom(n = 1, size = 1, prob = 1/10000)
## sma_sonuc


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## x <- 1:5
## 
## # Yöntem 1:
## x^2
## 
## # Yöntem 2:
## n <- length(x)   # x vektörünün eleman sayısı
## x_kare <- numeric(n)
## 
## for (i in 1:n){
##   x_kare.i <- x[i] * x[i]
##   x_kare[i] <- x_kare.i
## }
## print(x_kare)
## 
## # Yöntem 3:
## ?sapply
## 
## sapply(x, FUN = "^", 2)
## 
## sapply(x, FUN = function(x){
##   x * x
## })


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## ?apply
## 
## x <- matrix(c(1:25), nrow = 5, ncol = 5, byrow = TRUE)
## 
## # Sütun toplamları
## colSums(x)
## apply(x, MARGIN = 2, FUN = sum)
## 
## # Logaritmik sütun toplamları
## colSums(log(x))
## apply(x, 2, function(x){
##   sum(log(x))
## })


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## ?lapply
## 
## x <- matrix(c(1:25), nrow = 5, ncol = 5, byrow = TRUE)
## x2 <- as.data.frame(x)
## 
## # Sütun toplamları
## colSums(x)
## lapply(x, FUN = sum)
## lapply(x2, FUN = sum)


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## x <- matrix(c(1:25), nrow = 5, ncol = 5, byrow = TRUE)
## 
## myfun <- function(y, seviye = 8){
##   sum(y >= seviye)
## }
## 
## apply(x, 1, myfun)
## apply(x, 2, myfun)


## -------------------------------------------------------------------------------------------------------------------------------------------------
myFun <- function(x, y){
  x / y
}

myFun(x = 10, y = 3)    # Bölme işlemi


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## set.seed(1)
## 
## # Ortalaması 20, standart sapması 3 olan normal dağılımdan 100 genişliğinde bir
## # veri üretiliyor.
## x <- rnorm(n = 100, mean = 20, sd = 3)
## 
## mean(x)
## sd(x)
## median(x)
## min(x)
## max(x)
## 
## descStats <- function(<function_arguments>){
##   code lines ...
##   code lines ...
## }


## ---- eval = FALSE, echo = FALSE------------------------------------------------------------------------------------------------------------------
## set.seed(1)
## 
## # Ortalaması 20, standart sapması 3 olan normal dağılımdan 100 genişliğinde bir
## # veri üretiliyor.
## x <- rnorm(n = 100, mean = 20, sd = 3)
## 
## descStats <- function(data = NULL, ...){
##   if (is.null(data)){
##     warning("Tanımlayıcı istatistikleri hesaplanacak veri seti tanımlanamadı. \n")
##     return(NULL)
##   }
## 
##   if (class(data) != "numeric"){
##     stop("Veri seti sayısal değerler içermelidir.")
##   }
## 
##   if ((length(data) < 2) & (!is.null(data))){
##     stop("Veri seti en az 2 gözlemden oluşmalıdır.")
##   }
## 
##   ortalama <- mean(data, na.rm = TRUE)
##   std_sapma <- sd(data, na.rm = TRUE)
##   ortanca <- median(data, na.rm = TRUE)
##   enkucuk <- min(data, na.rm = TRUE)
##   enbuyuk <- max(data, na.rm = TRUE)
## 
##   sonuc <- list(Ortalama = ortalama, Standart_Sapma = std_sapma, Ortanca = ortanca,
##                 EnKucuk = enkucuk, EnBuyuk = enbuyuk)
## 
##   return(sonuc)
## }
## 
## descStats(NULL)


## ---- eval = FALSE--------------------------------------------------------------------------------------------------------------------------------
## 
## fibonacci <- function(<function_arguments>){
##   code lines ...
##   code lines ...
## }


## ---- eval = FALSE, echo = FALSE------------------------------------------------------------------------------------------------------------------
## fibonacci <- function(y = NULL, n = NULL, ...){
## 
##   if (is.null(y) & is.null(n)){
##     stop("'y' veya 'n' değerlerinden en az birisi için değer girilmelidir. \n")
##   }
## 
##   if (!is.null(y)){
##     if (y < 1){
##       stop("'y' değeri için 1'den büyük tamsayı değerler girilmelidir.")
##     }
## 
##     if (!is.null(n)){
##       warning("'y' ve 'n' değerleri birlikte tanımlanmış. 'y' değeri öncelikli olarak dikkate alınacaktır.")
##     }
##   } else {
##     if (n < 1){
##       stop("'n' değeri için 1'den büyük tamsayı değerler girilmelidir.")
##     }
##   }
## 
##   fib <- c(0,1)  # ilk iki fibonacci sayısı
## 
##   if (!is.null(y)){
##     fib.last <- 1
##     while (fib.last <= y){
##       idx <- length(fib)
##       fib.next <- fib[idx] + fib[idx - 1]
## 
##       if (fib.next <= y){
##         fib <- c(fib, fib.next)
##       }
## 
##       fib.last <- fib.next
##     }
##   }
## 
##   if (is.null(y) & !is.null(n)){
##     while (length(fib) < n) {
##       idx <- length(fib)
##       fib.next <- fib[idx] + fib[idx - 1]
##       fib <- c(fib, fib.next)
##     }
##   }
## 
##   return(fib)
## }

