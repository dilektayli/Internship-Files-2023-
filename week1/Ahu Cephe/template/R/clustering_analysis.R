# KÜMELEME ANALİZLERİ
## Analiz Hazırlık Aşaması
### Kütüphanelerin Yüklenmesi

library(dplyr)
library(magrittr)
library(ggplot2)
library(factoextra)
library(gridExtra)
library(ClusterR)
library(fpc)
library(cluster)
library(stringr)
library(GGally)
library(NbClust)
library(mclust)
library(clValid)
library(tidyverse)  
library(dendextend) 

### Veri Okuma
# iris veri seti yüklenir
data <- iris[,-5]

# Veri setinin yapısı ve değişkenlerin veri türleri kontrol edilir
str(data)

# Değişken isimleri
names(data)

# Veri setinde en üstten 5 satır döndürür
head(data)

# Veri setinde en alttan 5 satır döndürür
tail(data)

# Değişkenlerin tanımlayıcı istatistikleri 
summary(data)

# Toplam NA'lar
f <- function(x){sum(is.na(x))}
sapply(data,f)%>%as.data.frame()

# Toplam infinite değerlerin kontrolü
f <- function(x){sum(is.infinite(x))}
sapply(data,f) %>% as.data.frame()

# Toplam NaN değerleri
f <- function(x){sum(is.nan(x))}
sapply(data,f)%>%as.data.frame()


### Değişken Dağılımlarının İncelenmesi
# Histogram ve yoğunluk grafiği oluşturulur
histf<-function(z){
  feature=str_replace_all(deparse(substitute(z)),"[data$]","")
  ggplot(data) +
    aes(x = z) +
    geom_histogram(aes(y=..density..), position="identity", alpha=0.5,bins = 14L, fill = "#497AD2", colour = "blue") +
    geom_density(alpha=0.2, fill = "#4411D2", colour = "#4411D2")+
    labs(x =  paste("Özellik: ",feature),y = "Gözlem Numarası",
         title = paste(feature, "İçin Histogram Grafiği"),
         subtitle = paste(feature, "Özelliğinin Dağılımı"),
         caption = "iris veri seti") +
    theme_grey()
}

# 4 özellik için histogram grafikleri
histf(data$Sepal.Length)
histf(data$Sepal.Width)
histf(data$Petal.Length)
histf(data$Petal.Width)


iris1 <- as.data.frame(data)
iris1 %>%
  gather(attributes, value, 1:4) %>%
  ggplot(aes(x = value)) +
  geom_histogram(fill = 'lightblue2', color = 'black') +
  facet_wrap(~attributes, scales = 'free_x') +
  labs(x="Değerler", y="Sıklık") +
  theme_bw()

### Veri Standartlaştırma

# özelliklerin ortalaması
apply(data,2,mean) %>% as.data.frame()

# özelliklerin varyansı
apply(data,2,var)%>%as.data.frame()

# özelliklerin kutu-çizgi grafikleri
boxplot(data, xlab="özellikler",ylab="değerler", main ="Özelliklerin Kutu-Çizgi Grafiği", col = "blue",
        border = "black",cex.axis=.5)

# veri setini standartlaştır
data.scaled <- scale(data)

# standartlaştırılmış verinin özeti
summary(data.scaled)

# standartlaştırılmış verinin ortalaması
apply(data.scaled,2,mean)%>%as.data.frame()

# standartlaştırılmış verinin varyansı
apply(data.scaled,2,var)%>%as.data.frame()

# standartlaştırılmış özelliklerin kutu-çizgi grafikleri
boxplot(data.scaled, xlab="özellikler",ylab="değerler", main ="Özelliklerin Kutu-Çizgi Grafiği", col = "blue",border = "black",cex.axis=.5)

## Küme Sayısının Belirlenmesi

table(iris[,5])
library(relimp, pos=4)
car::scatterplotMatrix(~Petal.Length + Petal.Width + Sepal.Length + Sepal.Width, reg.line=FALSE, smooth=FALSE, spread=FALSE, span=0.5, id.n=0, diagonal = 'density', data=iris)
car::scatterplotMatrix(~Petal.Length + Petal.Width + Sepal.Length + Sepal.Width | Species, reg.line=FALSE, smooth=FALSE, spread=FALSE, span=0.5, id.n=0, diagonal= 'density', by.groups=TRUE, data=iris)

## olası küme sayısı için histogram grafikleri
distance <- get_dist(data.scaled)
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

## korelasyon değerleri ve saçılım grafikleri
ggpairs(data)

# korelasyon grafiği
options(repr.plot.width=12, repr.plot.height=9)
ggcorr(data)


# Benzerlik matrisi
pca <- prcomp(data.scaled, center = TRUE,scale. = FALSE)

summary(pca)

# biplot
fviz_pca_biplot(pca)

## Benzerlik ve/veya Uzaklık Matrislerinin Oluşturulması

# Benzerlik matrisi
dist.eucl <-dist(data.scaled, method = "euclidean")
head(dist.eucl)




## Kümeleme Algoritmaları
### k-ortalamalar Kümelemesi

# Elbow yöntemi

fviz_nbclust(data.scaled, kmeans, method = "wss")+
  geom_vline(xintercept = 3, linetype = 2)+labs(subtitle = "Elbow Yöntemi")

# Silhouette yöntemi
fviz_nbclust(data.scaled, kmeans, method = "silhouette")+labs(subtitle = "Silhouette Yöntemi")

# Gap istatistiği
set.seed(123)
fviz_nbclust(data.scaled, kmeans, nstart = 25, method = "gap_stat", nboot = 50)+labs(subtitle = "Gap İstatistik Yöntemi")

# NbClust 
nb <- NbClust(as.matrix(data.scaled), distance = "euclidean", min.nc = 2, max.nc = 10, method = "kmeans", index = "all")
nb
table(nb$Best.nc[1,])

# k = 3 kümeye göre k-ortalamalar kümelemesi

set.seed(123)
km.res <- kmeans(data.scaled, centers = 3, nstart = 25)
str(km.res)
summary(km.res)
km.res
table(km.res$cluster, iris[,5])

# k-ortalamalar sonuçlarının görselleştirilmesi
fviz_cluster(km.res, data = data.scaled)

# k-ortalamalar sonuçlarının görselleştirilmesi
fviz_cluster(km.res, data = data.scaled,
             palette = c( "#00AFBB", "#E7B800", "#FC4E07"),
             ellipse.type = "euclid", 
             star.plot = TRUE, 
             repel = TRUE, 
             ggtheme = theme_minimal())


#Farklı küme sayıları ile k-ortalamalar algoritması grafikleri 

k4 <- kmeans(data.scaled, centers = 4, nstart = 25)
k5 <- kmeans(data.scaled, centers = 5, nstart = 25)
k6 <- kmeans(data.scaled, centers = 6, nstart = 25)

# Grafikleri karşılaştır
p1 <- fviz_cluster(km.res, geom = "point", data = data.scaled) + ggtitle("k = 3")
p2 <- fviz_cluster(k4, geom = "point",  data = data.scaled) + ggtitle("k = 4")
p3 <- fviz_cluster(k5, geom = "point",  data = data.scaled) + ggtitle("k = 5")
p4 <- fviz_cluster(k6, geom = "point",  data = data.scaled) + ggtitle("k = 6")

grid.arrange(p1, p2, p3, p4, nrow = 2)


#Ortalamalar için

# kümeleri faktöre çevir
km.res$cluster <- as.factor(km.res$cluster)

# orjinal iris veri seti kümeye atanır
data.clust.kmeans <- cbind(data, cluster = km.res$cluster)

# kümeye göre özellikler toplanır
aggar.kmeans <- aggregate(data.clust.kmeans[,1:4], by=list(data.clust.kmeans$cluster), mean) %>% as.data.frame()

aggar.kmeans%>%knitr::kable()

# Grafikler
ggpairs(data.clust.kmeans,aes(color=cluster, alpha=0.5),lower = list(combo = wrap("facethist"))
        ,upper = list(continuous = wrap('cor', size = 1)),binwidth = 0.1) + theme(strip.text = element_text(size = 2))


### k-medoids Kümelemesi

# Elbow yöntemi
fviz_nbclust(data.scaled, pam, method = "wss") +
  geom_vline(xintercept = 3, linetype = 2)+
  labs(subtitle = "Elbow Yöntemi")

# Silhouette yöntemi
fviz_nbclust(data.scaled, pam, method = "silhouette")+
  labs(subtitle = "Silhouette Yöntemi")

# Gap istatistiği
fviz_nbclust(data.scaled, pam, method = "silhouette")+labs(subtitle = "Silhouette Yöntemi")

# k=3 ile k-medoid kümelemesi
pam.res <- pam(data.scaled, 3)
table(pam.res$cluster, iris[,5])

# kümelerin görselleştirilmesi
fviz_cluster(pam.res,
palette = c("#00AFBB", "#FC4E07","#00AB33"), 
ellipse.type = "t", 
repel = TRUE, 
ggtheme = theme_classic()
)


# Ortalamalar için

# kümeler faktör haline getirilir
pam.res$cluster <- as.factor(pam.res$cluster)

# iris veri setine küme atanır
data.clust.pam <- cbind(data, cluster = pam.res$cluster)

# kümelenmiş verileri kümeye göre toplama
aggregate(data.clust.pam[,1:4], by=list(cluster=km.res$cluster), mean)%>%knitr::kable()

# Grafikler
ggpairs(data.clust.pam,aes(color=cluster, alpha=0.5),lower = list(combo = wrap("facethist"))
        ,upper = list(continuous = wrap('cor', size = 1)),binwidth = 0.1) + theme(strip.text = element_text(size = 2))


### Model-tabanlı Kümeleme

mc<-Mclust(data.scaled)
mc$G
table(mc$classification, iris[,5])

# Classification: kümelemeyi göstererek grafikler
fviz_mclust(mc, "classification", geom = "point",pointsize = 1.5, palette = "jco")

# Ortalamalar için
# kümeler faktör haline getirilir
mc$classification <- as.factor(mc$classification)

# orjinal veri seti kümelere atanır
data.clust.gmm <- cbind(data, cluster = mc$classification)

# kümelenmiş verileri kümeye göre toplama
aggregate(data.clust.gmm[,1:4], by=list(data.clust.gmm$cluster), mean)%>%knitr::kable()

# Grafikler
ggpairs(data.clust.gmm,aes(color=cluster, alpha=0.5),lower = list(combo = wrap("facethist"))
        ,upper = list(continuous = wrap('cor', size = 1)),binwidth = 0.1) + theme(strip.text = element_text(size = 2))


### Hiyerarşik Kümeleme


# Elbow yöntemi
fviz_nbclust(data.scaled, hcut, method = "wss") +
geom_vline(xintercept = 3, linetype = 2)+
labs(subtitle = "Elbow Yöntemi")

# Silhouette yöntemi
fviz_nbclust(data.scaled, hcut, method = "silhouette")+
labs(subtitle = "Silhouette Yöntemi")

# Gap istatistiği
set.seed(123)
fviz_nbclust(data.scaled, hcut, nstart = 25, method = "gap_stat",
nboot = 50)+
labs(subtitle = "Gap İstatistik Yöntemi")

# "tam bağlantı (complete)" için hiyerarşik kümelemede optimum küme sayısı:
# complete bağlantısı
nb.complete <- NbClust(data.scaled, distance = "euclidean", min.nc = 2,max.nc = 10, method = "complete", index = "ch")

# sonuçlar görselleştirilir
suppressWarnings(fviz_nbclust(nb.complete))

# "ward bağlantı" için hiyerarşik kümelemede optimum küme sayısı:
# ward bağlantısı
nb.ward2 <- NbClust(data.scaled, distance = "euclidean", min.nc = 2,max.nc = 10, method = "ward.D", index = "ch")
options(repr.plot.width=12, repr.plot.height=9)

# sonuçlar görselleştirilir
suppressWarnings( fviz_nbclust(nb.ward2))

# "ortalama bağlantı (average)" için hiyerarşik kümelemede optimum küme sayısı:
# average bağlantısı
nb.avg <- NbClust(data.scaled, distance = "euclidean", min.nc = 2,max.nc = 10, method = "average", index = "ch")

# sonuçlar görselleştirilir
suppressWarnings(fviz_nbclust(nb.avg))

# euclidean uzaklık matrisi oluşturulur
dist.mat <- dist(data.scaled, method = "euclidean")

# farklı bağlantılara göre hiyerarşik kümeleme uygulanır
hc.comp<-hclust(dist.mat,method = "complete")
hc.ward<-hclust(dist.mat,method = "ward.D2")
hc.avg<-hclust(dist.mat,method = "average")

#Complete bağlantısı (k=3):

options(ggrepel.max.overlaps = Inf)
# Complete bağlantısı (k=3)
# kümeler 3 grupta toplanır ve farklı kümeler farklı renklerle gösterilir
fviz_dend(hc.comp, k = 3, # Cut in three groups
cex = 0.5, # label size
k_colors = c("#2E00DF", "#55AFBB", "#E7B800"),
color_labels_by_k = TRUE, # color labels by groups
rect = TRUE,
rect_fill=F,main = "Dendrogram - Complete (k=3)",
xlab = "Nesneler", ylab = "Uzaklık", sub = "",
ggtheme = theme_minimal()
)


#Ward.D2 bağlantısı (k=3):

# Ward.D2 bağlantısı (k=3)
# kümeler 3 grupta toplanır ve farklı kümeler farklı renklerle gösterilir
fviz_dend(hc.ward, k = 3, 
cex = 0.5, # label size
k_colors = c("#2E00DF", "#55AFBB", "#E7B800"),
color_labels_by_k = TRUE, # color labels by groups
rect = TRUE,
rect_fill=F,main = "Dendrogram - Complete (k=3)",
xlab = "Nesneler", ylab = "Uzaklık", sub = "",
ggtheme = theme_minimal()
)


#Average bağlantısı (k=3):

# Average bağlantısı (k=3)
# kümeler 3 grupta toplanır ve farklı kümeler farklı renklerle gösterilir
fviz_dend(hc.avg, k = 3, 
cex = 0.5, # label size
k_colors = c("#2E00DF", "#55AFBB", "#E7B800"),
color_labels_by_k = TRUE, 
rect = TRUE,
rect_fill=F,main = "Dendrogram - Complete (k=3)",
xlab = "Nesneler", ylab = "Uzaklık", sub = "",
ggtheme = theme_minimal()
)

Average bağlantısı (k=8):

# Average bağlantısı (k=8)
#  kümeler 8 grupta toplanır ve farklı kümeler farklı renklerle gösterilir
fviz_dend(hc.avg, k = 8, 
cex = 0.5, # label size
k_colors = c("#2E00DF", "#55AFBB", "#E7B800"),
color_labels_by_k = TRUE, 
rect = TRUE,
rect_fill=F,main = "Dendrogram - Complete (k=3)",
xlab = "Nesneler", ylab = "Uzaklık", sub = "",
ggtheme = theme_minimal()
)

#Ortalama tablosu:

# dendoram 3 küme olarak oluşturulur (complete bağlantısı) 
grp.comp <- cutree(hc.comp,3)

# kümeler faktöre çevrilir
grp.comp <- as.factor(grp.comp)

# orjinal veri seti kümelere atanır
data.clust.hier <- cbind(data, cluster = grp.comp)

# kümelenmiş verileri kümeye göre toplama
aggregate(data.clust.hier[,1:4], by=list(data.clust.hier$cluster), mean)%>%knitr::kable()

# Grafik
ggpairs(data.clust.hier,aes(color=cluster, alpha=0.5),lower = list(combo = wrap("facethist"))
        ,upper = list(continuous = wrap('cor', size = 1)),binwidth = 0.1) + theme(strip.text = element_text(size = 2))

## Küme Sonuçlarını Karşılaştırma

# kemans ve pam
xtabs(~data.clust.kmeans$cluster+data.clust.pam$cluster)

# kmeans ve gmm
xtabs(~data.clust.kmeans$cluster+data.clust.gmm$cluster)


# kmeans ve hiyerarşik
xtabs(~data.clust.kmeans$cluster+data.clust.hier$cluster)


# pam ve gmm
xtabs(~data.clust.pam$cluster+data.clust.gmm$cluster)

# pam ve hiyerarşik
xtabs(~data.clust.pam$cluster+data.clust.hier$cluster)

# gmm ve hiyerarşik
xtabs(~data.clust.gmm$cluster+data.clust.hier$cluster)


## Model Seçimi

# İç ölçümler:

clmethods <- c("hierarchical","kmeans","pam","model") 
suppressWarnings( intern <- clValid(data.scaled, nClust = 3,clMethods = clmethods, 
                                    validation = "internal",method="complete"))

# Özet
suppressWarnings( summary(intern))


# Stability ölçümler:

clmethods <- c("hierarchical","kmeans","pam","model")  

suppressWarnings( stab <- clValid(data.scaled, nClust = 3, clMethods = clmethods,
                                  validation = "stability",method="complete"))

# Sadece optimal skorları göster
optimalScores(stab)%>%knitr::kable()




