## ----load-libraries, warning=FALSE, message=FALSE----------------------------------------------------------------

library(magrittr)
library(rstatix)
library(ggplot2)
library(forcats)
library(PMCMRplus)
library(readr) 
library(dplyr)
library(moments)



## ----read-data, warning=FALSE, message=FALSE---------------------------------------------------------------------

tmp <- read_delim("data/nafld.txt", col_names = TRUE)
dim(tmp)
head(tmp)



## ---- Değişkenlerin kategorilerini tanımlama, warning=FALSE, message=FALSE---------------------------------------

tmp <- tmp %>%
mutate(Grup = factor(Grup, levels = c(0, 1), labels = c("Kontrol","Steatohepatit")),
       Grup2 = factor(Grup2, levels = c(0, 1, 2), labels = c("Kontrol","nafld_id_yok", "nafld_id_var")),
       Cinsiyet = factor(Cinsiyet, levels = c(1, 2), labels = c("Erkek", "Kadın")), 
       Sigara = factor(Sigara, levels = c(0, 1), labels = c("Kullanmayan", "Kullanan")),
       Bki_grup = factor(Bki_grup, levels = c(0, 1)),
       Bki1 = factor(Bki1, levels = c(0, 1), labels = c("Obez olmayan", "Obez olan")),
       Bki3 = factor(Bki3, levels = c(0, 1), labels = c("Obez olmayan", "Obez olan")),
       Bki6 = factor(Bki6, levels = c(0, 1), labels = c("Obez olmayan", "Obez olan")))



## ---- warning=FALSE, message=FALSE-------------------------------------------------------------------------------

dim(tmp)
head(tmp)



## ---- Nicel değişken için tanımlayıcı istatistikler (AST), warning=FALSE, message=FALSE--------------------------

# Nicel değişken için tanımlayıcı istatistikler (AST)

descAST <- tmp %>%
  group_by(Grup) %>%
  summarise(N = n(), Ortalama = mean(AST), Standart.sapma = round(sd(AST), 2), Medyan = median(AST),
            Q1 = quantile(AST, .25), Q3 = quantile(AST, .75), 
            Çarpıklık = round(skewness(AST),2), Basıklık = round(kurtosis(AST),2))
print.data.frame(descAST)



## ----boxplot-AST, warning=FALSE, message=FALSE-------------------------------------------------------------------
tmp %>%
  ggplot(aes(x = factor(Grup), y = AST)) + 
    geom_boxplot(fill = "gray90") +
    theme_bw(base_size = 14)+
  labs(x="Grup", y="AST")


## ---- Nitel değişken için tanımlayıcı istatistikler ( Bki_grup), warning=FALSE, message=FALSE--------------------
# Nitel değişken için tanımlayıcı istatistikler ( Bki_grup)

tmp %>%
  group_by(Grup2) %>%
  summarise(N = n(), n_obez = sum(Bki_grup == 1),    # 1: Obez olan
            Percentage = round(100 * n_obez / N, 2)) %>%
print.data.frame



## ---- Grouped/Stacked bar graphs, warning=FALSE, message=FALSE---------------------------------------------------

# Grouped/Stacked bar graphs.
tmp %>%
  mutate(Grup2 = factor(Grup2), Bki_grup = factor(Bki_grup)) %>%
  group_by(Grup2, Bki_grup) %>%
  summarise(N = n()) %>%
  group_by(Grup2, .drop = TRUE) %>%
  mutate(Percentage = 100 * N / sum(N)) %>%
  ggplot(aes(x = Grup2, y = Percentage, fill = Bki_grup)) + 
    geom_bar(stat = "identity", colour = "white", 
             position = position_dodge(), width = .7) +
    theme_bw(base_size = 14) + 
    theme(panel.background = element_rect(fill = "gray95")) +
    labs(x = "Grup 2") + 
    scale_fill_discrete(name = "Bki Grup", 
                        labels = c("Obez olan", "Obez olmayan"))

# Grouped/Stacked bar graphs.
myplot <- tmp %>%
  mutate(Grup2 = factor(Grup2), Bki_grup = factor(Bki_grup)) %>%
  group_by(Grup2, Bki_grup) %>%
  summarise(N = n()) %>%
  group_by(Grup2, .drop = TRUE) %>%
  mutate(Percentage = 100 * N / sum(N)) %>%
  ggplot(aes(x = Grup2, y = Percentage, fill = Bki_grup)) + 
    geom_bar(stat = "identity", colour = "white", width = .7) +
    theme_bw(base_size = 14) + 
    theme(panel.background = element_rect(fill = "gray95")) + 
    scale_fill_discrete(name = "Bki Grup", 
                        labels = c("Obez olan", "Obez olmayan"))
print(myplot)
 
myplot + geom_label(aes(label = paste0(round(Percentage, 2), "%"), colour = Bki_grup), size = 4, fontface = "bold", fill = "white", show.legend = FALSE, label.padding = unit(0.35, "lines"), position = position_stack(vjust = .50))


## ---- Ağırlığa ait çarpıklık ve basıklık ölçüleri, warning=FALSE, message=FALSE----------------------------------

# Ağırlığa ait çarpıklık ve basıklık ölçüleri

sekil_olcusu <- tmp %>%
  group_by(Grup) %>%
  summarise(N = n(), Çarpıklık = round(skewness(Ağırlık),2), 
                     Basıklık = round(kurtosis(Ağırlık),2))
print.data.frame(sekil_olcusu)



## ---- Ağırlığa ait histogram grafiği, warning=FALSE, message=FALSE-----------------------------------------------


# Ağırlığa ait histogram grafiği

tmp %>%
filter(Bki_grup==1)%>%     # 1: Obez olan
ggplot(aes(x = Ağırlık, y= ..density..))+
  geom_histogram(bins = 12, fill = "gray90", colour = "gray60")+
  geom_density(colour = "pink", linewidth = 2)+
  theme_bw(base_size = 14) + 
    labs(y ="Yoğunluk", x = expression("Ağırlık"))
        


## ---- Ağırlığa ait Q-Q grafiği, warning=FALSE, message=FALSE-----------------------------------------------------
# Ağırlığa ait Q-Q grafiği

qqnorm(tmp %$% Ağırlık, pch = 1, frame = T)
qqline(tmp %$% Ağırlık, col = "steelblue", lwd = 2)



## ----Ağırlığa ait Shapiro-Wilk hipotez testi---------------------------------------------------------------------
# Ağırlığa ait Shapiro-Wilk hipotez testi

# H0: Normal dağılıma uygunluk vardır. 
# (Serinin dağılımı ile normal dağılım arasında istatistiksel bakımdan anlamlı bir fark yoktur.)

# H1: Normal dağılıma uygunluk yoktur. 
# (Serinin dağılımı ile normal dağılım arasında istatistiksel bakımdan anlamlı bir fark vardır.)

tmp %>%
  filter(Bki_grup == 1) %$%    # 1: Obez olan
  shapiro.test(Ağırlık)



## ---- echo=FALSE, out.width = '50%', out.height='50%', warning=FALSE, message=FALSE------------------------------
knitr::include_graphics("figure/picture_type.png")



## ---- Tek örneklem t testi, warning=FALSE, message=FALSE---------------------------------------------------------
# Tek örneklem t testi

tmp %>%
  filter(Bki_grup == 1) %$%   # 1: Obez olan
  t.test(x = ALT, alternative = "two.sided", mu = 35, conf.level = .95)



## ---- İşaret testi, warning=FALSE, message=FALSE-----------------------------------------------------------------
# İşaret testi

tmp %>%
  filter( Bki_grup == 1) %$%   # 1: Obez olan
  wilcox.test(x = Tg1, alternative = "two.sided", mu = 150, conf.level = .95, 
              correct = FALSE, exact = FALSE)



## ---- Varyans homojenliği, warning=FALSE, message=FALSE----------------------------------------------------------
# Varyans homojenliği Levene testiyle değerlendirilir.

library(DescTools) # For activating LeveneTest

LeveneTest(Glukoz ~ factor(Sigara), data = tmp)
  


## ---- Bağımsız iki örneklem t testi, warning=FALSE, message=FALSE------------------------------------------------
# Bağımsız iki örneklem t testi

  t.test(Glukoz ~ factor(Sigara), var.equal = TRUE, data = tmp)



## ---- Mann-Whitney U testi, warning=FALSE, message=FALSE---------------------------------------------------------
# Mann-Whitney U testi

wilcox.test(Glukoz ~ factor(Sigara), correct = FALSE, data = tmp)



## ---- Tek yönlü varyans analizi, warning=FALSE, message=FALSE----------------------------------------------------
# Tek yönlü varyans analizi

tmp %>%
  filter(complete.cases(Glukoz, Grup2)) %>%
  aov(Glukoz ~ Grup2, data = .) %>%
  summary()



## ---- Çoklu karşılaştırma Sonuçları(Post-hoc test), warning=FALSE, message=FALSE---------------------------------
# Çoklu karşılaştırma (Tek yönlü varyans analizi)

tmp %>%
  filter(complete.cases(Glukoz, Grup2)) %>%
  aov(Glukoz ~ Grup2, data = .) %>%
  TukeyHSD()



## ---- Kruskal-Wallis, warning=FALSE, message=FALSE---------------------------------------------------------------
# Kruskal-Wallis 

tmp %>%
  filter(complete.cases(Grup2, Tg1)) %>%
  kruskal.test(Tg1 ~ Grup2, data = .)



## ---- Çoklu karşılaştırma (Kruskal-Wallis), warning=FALSE, message=FALSE-----------------------------------------

# Çoklu karşılaştırma (Kruskal-Wallis)

kwAllPairsConoverTest(Tg1 ~ Grup2, data = tmp)



## ---- Eşleştirilmiş t testi, warning=FALSE, message=FALSE--------------------------------------------------------
# Eşleştirilmiş t testi
# 
  t.test(tmp$Ağırlık3, tmp$Ağırlık1, paired = TRUE, alternative = "two.sided")



## ---- Wilcoxon testi, warning=FALSE, message=FALSE---------------------------------------------------------------
# Wilcoxon testi
  wilcox.test(x = tmp$Tg3, y = tmp$Tg1, mu = 0, alternative = "two.sided", 
              paired = TRUE, correct = FALSE, exact = FALSE)



## ---- Tekrarlı ölçümlerde tek yönlü varyans analizi, warning=FALSE, message=FALSE--------------------------------

# Tekrarlı ölçümlerde tek yönlü varyans analizi

library(rstatix)

df <- tmp %>%
  select(Gozlem_no, Ağırlık1, Ağırlık3, Ağırlık6) %>%
  gather(key = "time", value = "score", Ağırlık1, Ağırlık3, Ağırlık6) %>%
  convert_as_factor(Gozlem_no, time)
head(df, 3)
res.aov <- anova_test(data = df, dv = score, wid = Gozlem_no, within = time)
get_anova_table(res.aov)



## ---- Çoklu karşılaştırma (Tekrarlı ölçümlerde tek yönlü varyans analizi), warning=FALSE, message=FALSE----------

# Çoklu karşılaştırma (Tekrarlı ölçümlerde tek yönlü varyans analizi)

pwc <- df %>%
  pairwise_t_test(
    score ~ time, paired = TRUE,
    p.adjust.method = "bonferroni")
pwc



## ---- Friedman test, warning=FALSE, message=FALSE----------------------------------------------------------------

# Friedman test

Tg1 <- tmp$Tg1
Tg3 <- tmp$Tg3
Tg6 <- tmp$Tg6
TG_matrix <- cbind(Tg1, Tg3, Tg6)
friedman.test(TG_matrix)




## ---- Çoklu karşılaştırma (Friedman testi), warning=FALSE, message=FALSE-----------------------------------------

# Çoklu karşılaştırma (Friedman testi)

rownames(TG_matrix) <- 1:40
frdAllPairsNemenyiTest(y=TG_matrix)



## ---- McNemars testi, warning=FALSE, message=FALSE---------------------------------------------------------------

# McNemar's testi

mcnemar.test(tmp$Bki1, tmp$Bki3)



## ---- 2*2 kontenjans tablosu, warning=FALSE, message=FALSE-------------------------------------------------------

# 2*2 kontenjans tablosu 

ctab <- table(tmp$Sigara, tmp$Bki1)
print(ctab)
ctab %>%
  chisq.test(correct = T)



## ---- Fishers düzeltme testi, warning=FALSE, message=FALSE-------------------------------------------------------

#Fisher's düzeltme testi

fisher.test(ctab)



## ---- R*C kontenjans tablosu (Pearsons ki-kare analizi), warning=FALSE, message=FALSE----------------------------

# R*C kontenjans tablosu (Pearson's ki-kare analizi)

ctab <- table(tmp$Grup2, tmp$Bki1)
print(ctab)
ctab %>%
  chisq.test(correct = F)


