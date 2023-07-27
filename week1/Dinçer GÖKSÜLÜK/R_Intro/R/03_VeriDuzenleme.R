library("haven")

# dosyanın nerede olduğunu biliyorsan
veri <- read.csv(file = "data/MPV.csv", sep = ",", header = TRUE, stringsAsFactors = TRUE, dec = ".")

# dosyanın yerini bilmediğin zaman
veri <- read.csv(file = file.choose(), sep = ",", header = TRUE, stringsAsFactors = TRUE)

head(veri)

write.csv(veri, sep = ";", dec = ",", col.names = TRUE, row.names = FALSE, file = "data/yeni_veri.csv")
#after changing the warnings
write.csv(veri, row.names = FALSE, file = "data/yeni_veri.csv")
write.csv2() # Türkiye standartlarına göre yazmak için


summary(veri)
# ilk satırın silinmesi
veri_yeni <- veri[-1,] 

veri_bolunmus <- split(veri, veri$cinsiyet)
veri_bolunmus$'0'

names(veri_bolunmus$'0')
names(veri_bolunmus) <- c("Erkek", "Kadin")

# Veri filtreleme
install.packages("dplyr")
library("dplyr")

veri_filtre <- filter(veri, yas > 100, cinsiyet == 0)
select(veri, yas)
select(veri, yas, cinsiyet, adsoyad)
select(veri, starts_with("d",ignore.case = TRUE))


NLR <- veri$notrofil / veri$lenfosit
logPlat <- log(veri$Platelet)
veri[ ,"NLR"] <- NLR
veri[ ,"logPlat"] <- logPlat

veri_yedek <- veri
yeniveri <- mutate(veri, logWBC = log(wbc))


# install.packages(c("dplyr","magrittr","rlang"))




