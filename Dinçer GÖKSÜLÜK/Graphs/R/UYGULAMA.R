install.packages(c("dplyr", "readr", "magrittr", "ggplot2", "tidyr"))

library(dplyr)
library(readr)
library(magrittr)
library(ggplot2)
library(tidyr)

# mpv <- read_delim(
#   file = "data/MPV.csv", 
#   delim = ",", 
#   col_names = TRUE, 
#   locale = locale(decimal_mark = ".")
# )

mpv <- mpv_yedek <- read_csv("data/MPV.csv")

head(mpv)

# Değişken kodlamaları.
# cinsiyet -- 0: Kadın,  1: Erkek
# grup -- 1: Tedavi,  0: Kontrol
# Exitus: 1: Ex,  0: Sağ
# Nuks: 1: Evet,  0: Hayır

# Kategorik değişkenler için etiket tanımlamaları
# %>%  => forward piping
mpv <- mpv %>% 
  mutate(
    cinsiyet = factor(cinsiyet, levels = c(0, 1), labels = c("Kadın", "Erkek")),
    grup = factor(grup, levels = c(0, 1), labels = c("Kontrol", "Tedavi")),
    Exitus = factor(Exitus, levels = c(0, 1), labels = c("Sağ", "Ex")),
    Nuks = factor(Nuks, levels = c(0, 1), labels = c("Hayır", "Evet")),
  )

with(mpv, plot(notrofil, wbc))
with(mpv, plot(log(notrofil), log(wbc)))


# ggplot ----

# Grafik çizim alanı.
# Boş bir sayfa açılıyor.
ggplot()
ggplot(data = mpv)

# Grafik için veri seti ve ilgili değişkenler tanımlanır ancak grafik geometrisi eklenmemiştir.
ggplot(data = mpv, mapping = aes(x = notrofil, y = wbc))

# Saçılım grafiği eklenir.
ggplot(data = mpv, mapping = aes(x = notrofil, y = wbc)) + 
  geom_point()


# Noktaların büyüklüğğü, rengi, şekli
ggplot(data = mpv, mapping = aes(x = notrofil, y = wbc)) + 
  geom_point(size = 3, colour = "red")


ggplot(data = mpv, mapping = aes(x = notrofil, y = wbc)) + 
  geom_point(size = 3, colour = "red") +
  labs(x = "Nötrofil değerleri", y = "Beyaz küre sayısı")


ggplot(data = mpv, mapping = aes(x = notrofil, y = wbc)) + 
  geom_point(size = 3, colour = "red") +
  labs(x = "Nötrofil değerleri", y = "Beyaz küre sayısı") + 
  theme_classic(base_size = 14) +
  scale_x_continuous(trans = "log") + 
  scale_y_continuous(trans = "log") + 
  facet_wrap(~ cinsiyet, ncol = 2)


# RainCloud Plot ----
source("R/geom_flat_violin.R")

n <- 1000
set.seed(2128)
happiness <- tibble(
  Personal = rnorm(n, mean = 60, sd = 10),
  Social = rnorm(n, mean = 55, sd = 5), 
  Work = 20 + 3 * rpois(n, lambda = 5) + rnorm(n)
) %>%
  as.data.frame(.)

plotData <- happiness %>%
  reshape(
    varying = list(1:ncol(.)), 
    v.names = "Response", 
    direction = "long", 
    timevar = "Happiness",
    times = colnames(.)
  )

rownames(plotData) <- NULL
head(plotData)

## Production ----
# Step-by-Step



## Final Version ----
ggplot(data = plotData, mapping = aes(x = Happiness,y = Response, fill = Happiness)) + 
  geom_point(
    position = position_jitter(width  = .15),
    mapping = aes(colour = Happiness),
    size = .5,
    alpha = .8
  ) +
  geom_boxplot(
    width = .1,
    outlier.shape = NA,
    alpha = .5
  ) +
  geom_flat_violin(
    position = position_nudge(x = .2)
  ) +
  theme_classic(base_size = 12, base_family = "Consolas") + 
  guides(fill = "none", colour = "none") +
  coord_flip() + 
  ggtitle(label = "Grafik Ana Başlık", subtitle = "Grafik Alt Başlık") +
  theme(
    plot.title = element_text(face = "bold", colour = "gray30", size = 18),
    plot.subtitle = element_text(color = "gray50", margin = margin(b = 18), family = "Consolas"),
    axis.title = element_text(face = "bold"),
    axis.text.x = element_text(margin(t = 5, b = 10)),
    axis.text.y = element_text(margin(r = 5, l = 10)),
    )




