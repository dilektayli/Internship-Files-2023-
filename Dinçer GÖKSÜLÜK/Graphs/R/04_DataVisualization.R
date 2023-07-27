## ----setup, include = FALSE-------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.width = 6, fig.height = 4, fig.align = 'center',
                      message = FALSE, warning = FALSE)


## ---------------------------------------------------------------------------------------------------------------------------------------
# Gerekli R kütüphanelerinin yüklenmesi
library(readr)
library(ggplot2)
library(dplyr)
library(magrittr)


## ----MPV verisi R ortamına okutma, echo = TRUE, eval = TRUE-----------------------------------------------------------------------------
## MPV verisinin yüklenmesi
# mpv <- read.csv(file = "data/MPV.csv", header = TRUE, sep = ",", dec = ".", stringsAsFactors = TRUE)

mpv <- mpv_yedek <- read_csv(file = "data/MPV.csv", col_names = TRUE)
#mpv <- read_csv(file = file.choose(), col_names = TRUE)


## ----MPV verisi veri düzenlemesi--------------------------------------------------------------------------------------------------------
# Değişken kodlamaları.
# cinsiyet -- 0: Kadın,  1: Erkek
# grup -- 1: Tedavi,  0: Kontrol
# Exitus: 1: Ex,  0: Sağ
# Nuks: 1: Evet,  0: Hayır

# Kategorik değişkenler için etiket tanımlamaları
mpv <- mpv %>% 
  mutate(
    cinsiyet = factor(cinsiyet, levels = c(0, 1), labels = c("Kadın", "Erkek")),
    grup = factor(grup, levels = c(0, 1), labels = c("Kontrol", "Tedavi")),
    Exitus = factor(Exitus, levels = c(0, 1), labels = c("Sağ", "Ex")),
    Nuks = factor(Nuks, levels = c(0, 1), labels = c("Hayır", "Evet")),
  )


## ---------------------------------------------------------------------------------------------------------------------------------------
## Grafiklerde kullanılacak bir diğer veri seti: Diamond verisi.
data(diamonds)
?ggplot2:::diamonds      ## Diamonds  verisi hakkında detaylı bilgi için


## ---- eval = FALSE----------------------------------------------------------------------------------------------------------------------
## barplot(diamonds[ ,"color"])  ## Hata: 'height' must be a vector or a matrix
## 
## # Barplot çizilecek olan verinin her bir çubuğa karşılık gelen sayı veya yüzdeleri
## # verecek şekilde düzenlenmesi gerekmektedir.
## 
## barplot(c(5, 30, 35, 20, 10), xlab = "Eğitim Durumu", ylab = "Yüzde (%)")


## ---- echo = FALSE, fig.width = 6, fig.height = 4, fig.align = 'center'-----------------------------------------------------------------
# Barlara karşılık gelen kategori isimleri yer almıyor.
barplot(c(5, 30, 35, 20, 10), xlab = "Eğitim Durumu", ylab = "Yüzde (%)", ylim = c(0, 50), names.arg = NULL)

# "names.args" parametresi kulanarak her çubuk için kategoriler girilir. 


## ---------------------------------------------------------------------------------------------------------------------------------------
bardata <- diamonds %$%
  table(color)

print(bardata)

barplot(bardata, main = "Barplot of diamond colors", ylab = "Counts", xlab = "Diamond Colors", 
        col = rgb(0.1, 0.3, 0.6, alpha = 0.6))


## ---------------------------------------------------------------------------------------------------------------------------------------
tbl <- table(mpv$cinsiyet)

barplot(tbl, main = "Barplot of cinsiyet", ylab = "Counts", xlab = "Cinsiyet", 
        col = rgb(0.1, 0.3, 0.6, alpha = 0.6))

# Cinsiyet için çizilen grafiği y ekseninde yüzdeler olacak şekilde düzenleyiniz.


## ---------------------------------------------------------------------------------------------------------------------------------------
tbl <- with(mpv, table(cinsiyet, grup))
tbl

## Bindirmeli Çubuk Grafik (Stacked)
barplot(tbl, main = "Barplot of cinsiyet and grup", ylab = "Counts", 
        xlab = "Grup", col = c("orange", "gray80"))

# Gruplandırılmış Çubuk Grafik
barplot(tbl, main = "Barplot of cinsiyet and grup", ylab = "Counts", 
        xlab = "Grup", beside = TRUE, col = c("orange", "gray80"),
        ylim = c(0, 80))

# 
legend(x = 2, y = 76, legend = c("Kadın", "Erkek"), fill = c("orange", "gray80"))

## Yukarıdaki iki grafiği yüzdeler ile çiziniz.


## ---------------------------------------------------------------------------------------------------------------------------------------
hist(diamonds$price, freq = FALSE, col = "lightblue",
     main = NULL, xlab = "Satış Fiyatları")
box()


## ---- fig.height=6----------------------------------------------------------------------------------------------------------------------
boxplot(price ~ color, data = diamonds, col = "lightgreen", 
        ylab = "Price ($)", outline = TRUE)    ## outline = FALSE ise outlier değerler grafikte gösterilmez.

## 7000$ noktasından yatay bir referans çizgisi ekleyelim:
abline(h = 7000, lty = 2, col = "red", lwd = 2)


## ---- fig.height=5----------------------------------------------------------------------------------------------------------------------
point.colors <- rainbow(7)

with(diamonds, {
  plot(carat, price, xlab = "Carat", ylab = "Price ($)", font.lab = 2,
       col = point.colors[as.numeric(diamonds$color)])
})
legend("bottomright", legend = levels(diamonds$color), col = point.colors, pch = 21, 
       cex = 0.7, title = "Color", ncol = 2)

## Sayısal değişkenler için matrix saçılım grafiği:
## İşlem süresinin fazla olmasından dolayı "diamonds" verisi yerine "MPV" verisi kullanılmıştır.

# pairs(mpv[ ,c("yas", "wbc", "PDW", "RDW")])
plot(mpv[ ,c("yas", "wbc", "PDW", "RDW")], pch = 21, cex = 1.3)



## ---- fig.height=6----------------------------------------------------------------------------------------------------------------------
data(iris)

# iris verisinin sayısal değişkenlerini 2x2'lik bir yapıda oluşturalım.
par(mfrow = c(2, 2))   # mfrow = c(nrow, ncol)

vNames <- colnames(iris)[-5]  # "Species"" değişkeni çıkartılıyor. 
                              # Kalan değişkenlerin isimleri vNames adı ile saklanıyor.

histColors <- c("lightgreen", "tomato3", "lightblue", "gray70")

for (i in 1:length(vNames)){
  hist(iris[ ,vNames[i]], col = histColors[i], main = NULL, xlab = vNames[i], freq = FALSE)
}


## ---------------------------------------------------------------------------------------------------------------------------------------
library(lattice)

histogram(mpv[["yas"]], xlab = "Yaş", col = "gray75", type = "density")


## ---- fig.height=6.5--------------------------------------------------------------------------------------------------------------------
# Formula yapısı kullanmak:
# formula: y ~ x | group
histogram(~ PDW + RDW | cinsiyet, data = mpv, type = "density", xlab = "", 
          scales = list(relation = "free"))


## ---- fig.height=6, fig.width=6---------------------------------------------------------------------------------------------------------
splom(~ mpv[ ,c("yas", "wbc", "PDW", "RDW")], groups = cinsiyet, data = mpv, 
      auto.key = TRUE)


## ---- fig.height=5----------------------------------------------------------------------------------------------------------------------
library(lattice)
p2 <- parallelplot(~ mpv[ ,c("MPV", "PDW", "RDW")] | cinsiyet, data = mpv, 
                   horizontal.axis = FALSE, layout = c(1,2,1), col = "tomato3")
plot(p2)


## ---- fig.height=8, fig.width=8, warning=FALSE, message=FALSE---------------------------------------------------------------------------
library(lattice)
library(latticeExtra)
library(hexbin)
library(RColorBrewer)

## Kaynak: http://wresch.github.io/2012/11/30/modified-splom.html
compRepl <- function(df){
# function to compare replicates (each variable of df)
# as hexbin plot matrix
# Args:
#   df      data frame
# Results:
#   lattice plot
  ct <- custom.theme(
            symbol = c("black", brewer.pal(n = 8, name = "Dark2")),
            fill = brewer.pal(n = 12, name = "Set3"),
            region = brewer.pal(n = 11, name = "Spectral"),
            reference = "#e8e8e8",
            bg = "transparent", fg = "black",
            lwd=2, pch=16)
  ct$axis.text$cex = 1
  ct$par.xlab.text$cex = 1
  ct$par.ylab.text$cex = 1
 
  splom(~df,
        #pscales = 0, #don't show axes,
        par.settings = ct,
        upper.panel = panel.hexbinplot,  # use hexbinplot
        xbins = 100,                     # number of bins
        trans = log10, inv=function(x) 10^x, # density color scale transformation
        colramp = magent,                   # with this color scheme
        #colramp = LinGray,
        
        # show correlation coefficient in lower panel
        lower.panel = function(x,  y, ...) {
          panel.fill(col = brewer.pal(9, "RdBu")[round(cor(x, y) *  4 + 5)])
          panel.text(sum(range(x))/2, sum(range(y))/2, round(cor(x, y), 2), font = 2)
        },
        varname.cex = 1, #smaller name in diagonal
        varname.font = 2,
        varname.col = "tomato3"
  )
}

compRepl(diamonds[ ,c("price", "carat", "depth", "x", "y")])


## ---- eval = FALSE----------------------------------------------------------------------------------------------------------------------
## ggplot(data, mapping = aes(...), ...) +
##   katman1 +
##   katman2 +
##   ...
## 
## ggplot()


## ---- eval = FALSE----------------------------------------------------------------------------------------------------------------------
## ggplot(data = mpv, mapping = aes(x = yas, y = notrofil)) +
##   geom_point() +     ## Scatter Plot
##   xlab(...) +    ## x-axis label
##   geom_smooth(...) +    ## Smooth curve
##   theme(...)       ## Tema özellikleri


## ---- eval = FALSE----------------------------------------------------------------------------------------------------------------------
## qplot(x, y = NULL, ..., data, facets = NULL, margins = FALSE,
##   geom = "auto", xlim = c(NA, NA), ylim = c(NA, NA), log = "",
##   main = NULL, xlab = deparse(substitute(x)),
##   ylab = deparse(substitute(y)), asp = NA, stat = NULL, position = NULL)
## 
## quickplot(x, y = NULL, ..., data, facets = NULL, margins = FALSE,
##   geom = "auto", xlim = c(NA, NA), ylim = c(NA, NA), log = "",
##   main = NULL, xlab = deparse(substitute(x)),
##   ylab = deparse(substitute(y)), asp = NA, stat = NULL, position = NULL)


## ---- eval=FALSE------------------------------------------------------------------------------------------------------------------------
## # Scatter plot
## # Grouped by Species (different colors for each)
## # Loess curve without confidence interval around.
## qplot(x = carat, y = price, geom = "point", data = diamonds, colour = color,
##       main = "Scatter plot of diamond prices and carats") +
##   geom_smooth(method = "loess", se = FALSE, lty = 1, lwd = 1)  ## add regression line.
## 
## # "geom" içerisinde birden fazla geometrik obje tanımlanabilir.
## # Bu durumda bazı objeleri "+" kullanarak eklemeye gerek kalmaz.
## qplot(x = carat, y = price, geom = c("point", "smooth"), data = diamonds,
##       colour = color, main = "Scatter plot of diamond prices and carats")
## 
## # İkiden fazla "geom" tanımlandığı durumda objelerden herhangi birisine ait
## # parametre qplot(...) içerisinde tanımlanamaz. Örneğin; "smooth" objesine
## # ait "se" değeri FALSE yapılır ise fonksiyon uyarı verecektir. Burada haricen
## # girilen parametreler 'geom' içerisinde tanımlanan bütün katmanlara aktarılır.
## # Herhangi bir katmanda bu parametre kullanılmıyor ise o katman için uyarı
## # verir.
## qplot(x = carat, y = price, geom = c("point", "smooth"), data = diamonds,
##       colour = color, main = "Scatter plot of diamond prices and carats",
##       se = TRUE)   # 'Ignoring unknown parameters: se'


## ---------------------------------------------------------------------------------------------------------------------------------------
myplot <- qplot(x = notrofil, y = lenfosit, geom = c("point"), 
                main = "Nötrofil ve Lenfosit Değerlerinin Saçılım Grafiği", data = mpv, colour = cinsiyet)

print(myplot)

# Güven aralığını kaldıralım.
# Tema olarak siyah - beyaz tema kullanalım.
myplot <- myplot + geom_smooth(se = FALSE, method = "lm")
print(myplot)


## ---------------------------------------------------------------------------------------------------------------------------------------
library(dplyr)
library(ggplot2)

## notrofil değerleri 25bin altında, lenfosit değerleri 10bin altında olan
## gözlemler seçilir.
mpv2 <- filter(.data = mpv, notrofil < 25000 & lenfosit < 10000)


myplot <- qplot(x = notrofil, y = lenfosit, geom = c("point"), 
                main = "Nötrofil ve Lenfosit Değerlerinin Saçılım Grafiği", data = mpv2, colour = cinsiyet)

myplot <- myplot + geom_smooth(method = "loess", se = TRUE)
print(myplot)


## ---------------------------------------------------------------------------------------------------------------------------------------
# geom_* objeleri kendi içinde qplot(..)'dan bağımsız olarak oluşturulabilir.
# Oluşturulan nesne bir katman olarak kullanılacağı için qplot() fonksiyonuna '+' ile eklenebilir.
overallLoessCurve <- geom_smooth(data = mpv2, mapping = aes(x = notrofil, y = lenfosit), 
                                 se = TRUE, col = "black", span = 0.5)
myplot <- myplot + 
  overallLoessCurve

print(myplot)


## ---- eval = FALSE----------------------------------------------------------------------------------------------------------------------
## ggplot(data = NULL, mapping = aes(), ..., environment = parent.frame())


## ---------------------------------------------------------------------------------------------------------------------------------------
data(diamonds)

## use "..count.." or "..density" to switch between counts and densities on y-axis
myPlot <- ggplot(data = diamonds, mapping = aes(x = price, y = ..count..)) +
  geom_histogram(bins = 20, fill = "lightgreen", color = "gray70") + 
  geom_freqpoly(bins = 20, color = "black", lty = 2)

print(myPlot)


## ---------------------------------------------------------------------------------------------------------------------------------------
## y-ekseninde density olacak şekilde "gruplandırılmış frekans poligonu"
myPlot <- ggplot(data = diamonds, mapping = aes(x = price, y = ..density.., colour = cut)) +
  geom_freqpoly(bins = 20) + 
  theme(legend.position = "bottom") +     ## legends at the bottom
  ylab("Sayı") +
  xlab("Fiyat ($)")

print(myPlot)


## ---------------------------------------------------------------------------------------------------------------------------------------
library(dplyr)
data(mtcars)

## Araçların vites bilgisini gösteren "am" değişkenini "Otomatik", "Düz Vites" isimleri ile
## yeniden kodlayıp vites türüne göre araçların yakıt tüketimlerinin kutu çizgi grafiğini oluşturalım.

mtcars <- mtcars %>%
  mutate(Transmission = recode_factor(am, '0' = "Otomatik", '1' = "Düz Vites"))

ggplot(data = mtcars, mapping = aes(x = Transmission, y = mpg)) +
  geom_boxplot(fill = rgb(0.3, 0.4, 0.5, 0.6), width = 0.3, lwd = 1) + 
  ylab("Miles per galon")
  # geom_point(colour = "gray40")
  # geom_jitter(width = 0.25, color = "tomato3")   # jittering


## ---- eval = FALSE----------------------------------------------------------------------------------------------------------------------
## data(diamonds)
## 
## # Stacked
## ggplot(diamonds, aes(x = color, fill = cut)) +
##   geom_bar(position = "stack")
## 
## # Unstacked
## ggplot(diamonds, aes(x = color, fill = cut)) +
##   geom_bar(position = "dodge")
## 
## # Stacked, percentage on the y-axis
## # Yüzdeler genel toplama bölünerek elde edilir.
## ggplot(diamonds, aes(x = color, y = 100 * (..count..) / sum(..count..), fill = cut)) +
##   geom_bar(position = "stack") +
##   ylab("Percentage (%)")
## 
## # Stacked, percentage on the y-axis
## # Her x kategorisi kendi içinde değerlendirilir.
## ggplot(diamonds, aes(x = color, y = 100 * (..count..) / sum(..count..), fill = cut)) +
##   geom_bar(position = "fill") +
##   ylab("Percentage") +
##   xlab("Color") +
##   scale_y_continuous(labels = scales:::percent_format())


## ---- eval = TRUE, echo = FALSE---------------------------------------------------------------------------------------------------------
data(diamonds)

# Unstacked bar
ggplot(diamonds, aes(x = color, y = (..count..) / sum(..count..), fill = cut)) + 
  geom_bar(position = "dodge", width = 0.8) + 
  ylab("Percentage") +
  xlab("Color") +
  ggtitle("Barplot of dimond colors within cutting quality") + 
  scale_y_continuous(labels = scales:::percent_format())


## ---------------------------------------------------------------------------------------------------------------------------------------
library(dplyr)
data(diamonds)

diamonds_grp <- group_by(diamonds, color)    # data is grouped by "color"
pieData <- summarise(diamonds_grp, Count = n())
pieData <- mutate(pieData, Percentage = Count / sum(Count),
                  end = 100*cumsum(Percentage), 
                  start = c(0, end[-length(end)]))    ## Start and End points are calculated for each slice.

ggplot(pieData, aes(fill = color, ymax = start, ymin = end, xmax = 6, xmin = 0)) + 
  theme(panel.background = element_rect(fill = "white", linetype = "solid", colour = "white"), 
                           panel.grid.minor = element_line(color = "gray95"), 
                           panel.grid.major = element_line(color = "gray90"),
                           axis.ticks=element_blank(),
                           axis.title.x = element_text(),
                           axis.text.x = element_text(family = "Times", size = 18, 
                                                      colour = "gray35", face = "bold"),
                           axis.title.y = element_text(),
                           axis.text.y = element_text(colour = "white"),
                           axis.line = element_line(colour = "gray90")) +
  geom_rect(stat = "identity", color = "black", lwd = 0.3) + 
  xlim(c(0, 6)) + 
  coord_polar(theta = "y")


## ---------------------------------------------------------------------------------------------------------------------------------------
ggplot(diamonds, aes(x = price, y = ..density.., fill = cut)) +
  geom_histogram(bins = 20) + 
  facet_wrap(~ cut, nrow = 2) + 
  xlab("Price ($)") + 
  ylab("Density")


## ---------------------------------------------------------------------------------------------------------------------------------------
n <- nrow(diamonds)
sampleData <- diamonds[sample(n, 0.05*n, FALSE), ]

# Diamonds verisinin %5'i rasgele olarak seçilmiştir.
# Grafik çizimini hızlandırmak için.
ggplot(sampleData, aes(x = carat, y = price)) +
  geom_point() + 
  geom_smooth(method = "loess") + 
  facet_wrap(~ cut, nrow = 2)


## ---- fig.height=5, fig.width=8---------------------------------------------------------------------------------------------------------
library(gridExtra)
library(grid)
data(iris)

plotScatter <- ggplot2:::ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, colour = Species)) +
  theme(panel.background = element_rect(fill = rgb(0.1, 0.3, 0.2, 0.15))) +
  geom_point(size = 2) + 
  theme(legend.position = "top")

bwTheme <- theme_bw()   ## Black and White theme.
bwTheme$legend.position <- "top"

plotBox <- ggplot(iris, aes(x = Species, y = Sepal.Width, fill = Species)) +
  bwTheme + 
  geom_boxplot(outlier.colour = "red", outlier.shape = "*", outlier.size = 8) +
  geom_smooth(aes(group = 1), method = "loess") + 
  scale_fill_discrete(guide = guide_legend(title.theme = element_text(face = "bold", angle = 0), 
                                           title.position = "top"))

plotHistogram <- ggplot(iris, aes(x = Sepal.Width, y = ..density.., fill = Species)) + 
  geom_histogram(bins = 15) + 
  facet_grid(~ Species)

grid.arrange(plotScatter, plotBox, plotHistogram, nrow = 2, ncol = 2)


## ---- eval = TRUE-----------------------------------------------------------------------------------------------------------------------
# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
# Source: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
# 

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


## ---- fig.height=8, fig.width=8---------------------------------------------------------------------------------------------------------
# Histogram grafikleri 2. satırın tamamını kaplayacaktır.
multiplot(plotScatter, plotBox, plotHistogram, layout = matrix(c(1,2,3,3), ncol = 2, byrow = TRUE))


## ---- eval = FALSE----------------------------------------------------------------------------------------------------------------------
## # Grafik alanının kroki görünümü için aşağıdaki kodu çalıştırabilirsiniz.
## plotarea <- layout(matrix(c(1,2,3,3), ncol = 2 byrow = TRUE))
## layout.show(plotarea)


## ---- eval = FALSE----------------------------------------------------------------------------------------------------------------------
## 
## plotData <- mpv %>%
##   mutate(NLR = 100 * notrofil / lenfosit)
## 
## ## Scatter plot
## ggplot(plotData, aes(x = RDW, y = NLR, colour = yas)) +
##   geom_point(size = 3) +
##   theme_bw() +
##   theme(legend.title = element_text(face = "bold"), legend.margin = margin(0,10,0,20)) +
##   guides(colour = guide_colourbar(title = "Yaş"))
## 
## # Önceden tanımlı temalar
## theme_bw()
## theme_classic()
## ...


## ---- eval = TRUE, results='hide', fig.show='hide'--------------------------------------------------------------------------------------
mtcars <- mtcars %>%
  mutate(Transmission = dplyr:::recode_factor(am, '0' = "Otomatik", '1' = "Düz Vites"))

myPlot <- ggplot(data = mtcars, mapping = aes(x = Transmission, y = mpg)) +
  geom_boxplot(fill = rgb(0.3, 0.4, 0.5, 0.6)) + 
  ylab("Miles per galon") +
  theme_light() 

plotInfo <- ggplot_build(myPlot)
str(myPlot)    ## Grafiğe ait bütün bilgiler.


## ---- eval = TRUE, results='hide'-------------------------------------------------------------------------------------------------------
# Grafik x-eksen etiketini değiştirip yeniden çizelim:
plotInfo$plot$labels$x <- "Add x-title here"

plotInfo$plot$theme$axis.text.x$face <- "italic"
plotInfo$plot$theme$axis.text.x$colour <- "red"

## Değiştirilmiş halleri ile grafik tekrar çizilir ve grafiğe ait tüm bilgiler ekrana basılır.
print(plotInfo)   


## ---- eval = FALSE----------------------------------------------------------------------------------------------------------------------
## pdf(file = "myplot.pdf", width = 10, height = 8)   ## Çalışma dizinine "myplot.pdf" adı ile kaydeder.
## plot(iris[ ,-5])
## dev.off()


## ---- eval = FALSE----------------------------------------------------------------------------------------------------------------------
## plot_ly(data = data.frame(), ..., type = NULL, color, colors = NULL,
##   alpha = 1, symbol, symbols = NULL, size, sizes = c(10, 100), linetype,
##   linetypes = NULL, split, width = NULL, height = NULL, source = "A")
## 
## # ...: plotly kütüphanesi için girlebilecek diğer opsiyonlar
## #      Detaylı bilgi için: "https://plot.ly/r/reference/"


## ---- fig.align="center"----------------------------------------------------------------------------------------------------------------
library(plotly)
library(ggplot2)

data("diamonds")
set.seed(100)
d <- diamonds[sample(nrow(diamonds), 1000), ]

plot_ly(data = d, x = ~carat, y = ~price, mode = "markers", color = ~carat, size = ~carat, text = "Point Value")


## ---- fig.align="center"----------------------------------------------------------------------------------------------------------------
data("mtcars")

plot_ly(data = mtcars, x = ~vs, y = ~mpg, type = "box")


## ---- fig.align="center"----------------------------------------------------------------------------------------------------------------
set.seed(123)

n <- dim(diamonds)[1]   ## number of rows.
sampleIdx <- sample(n, 0.03*n, FALSE)
sampleData <- diamonds[sampleIdx, ] 

myPlot <- ggplot(sampleData, aes(x = color, y = price, colour = cut)) + 
  geom_jitter(width = 0.5)

ggplotly(myPlot)


## ---- fig.align="center", eval = FALSE--------------------------------------------------------------------------------------------------
## diamonds_grp <- group_by(diamonds, color)    # data is grouped by "color"
## pieData <- summarise(diamonds_grp, Count = n())
## pieData <- mutate(pieData, Percentage = Count / sum(Count),
##                   end = 100*cumsum(Percentage),
##                   start = c(0, head(end, n = -1)))    ## Start and End points are calculated for each slice.
## 
## myPlot <- ggplot(pieData, aes(fill = color, ymax = start, ymin = end, xmax = 6, xmin = 2)) +
##   theme(panel.background = element_rect(fill = "white", linetype = "solid", colour = "white"),
##                            panel.grid.minor = element_line(color = "gray95"),
##                            panel.grid.major = element_line(color = "gray90"),
##                            axis.ticks=element_blank(),
##                            axis.title.x = element_text(),
##                            axis.text.x = element_text(family = "Times New Roman", size = 18,
##                                                       colour = "gray35", face = "bold"),
##                            axis.title.y = element_text(),
##                            axis.text.y = element_text(colour = "white"),
##                            axis.line = element_line(colour = "gray90")) +
##   geom_rect(stat = "identity") +
##   xlim(c(0, 6)) +
##   coord_polar(theta = "y")
## 
## ggplotly(myPlot)    ## Gives an error: "Error in zero_range(to) : x must be length 1 or 2"

