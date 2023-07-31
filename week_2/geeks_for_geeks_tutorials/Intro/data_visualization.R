# Types of data visualization

# bar plot
barplot(airquality$Ozone, main = "Ozone Concenteration in air", xlab = "Ozone levels", horiz = T)

# why bar plot?
# 1. generally used for continuous and categorical variable plotting

# vertical bar plot
barplot(airquality$Ozone, main = "Ozone Concenteration in air", xlab = "Ozone levels", col = "blue", horiz = F)

# histogram
data("airquality")
hist(airquality$Temp, main = "La Guardia Airport's\ Maximum Temperature(Daily)", xlab = "Temperature(Fahrenheit)", xlim = c(50, 125), col = "pink", freq = T)
# xlim -> to specify the interval within which all values are to be displayed

# why histogram?
# 1. to verify an equal and symmetric distribution of the data
# 2. to identify deviations from expected values


# bar plot
boxplot(airquality$Wind, main = "Average wind speed at La Guardia Airport's", xlab = "Miles per hour", ylab = "Wind", col = "pink", border = "blue", horizontal = T, notch = T)


# box plot
boxplot(airquality[, 0:4], main = "Box Plots for Air Quality Parameters")

# why box plot?
# 1. to give a comprehensive statistical description of the data through a visual cue
# 2. to identify the outlier points that do not lie in the interquartile range of data


# scatter plot
# it is composed of many points on Cartesian plane. Each point denotes the value taken by two parameters and helps us easily identify the relationship between them

plot(airquality$Ozone, airquality$Month, main = "Scatter Plot", xlab = "Ozone Concentration in parts per billion", ylab = "Month of observation", pch = 18)

# Why scatter plot?
# 1. to show whether an association exists between bivariate data (iki değişkenli data)
# 2. to measure the strength and direction of such a relationship


# heat map
set.seed(110)
data <- matrix(rnorm(50, 0, 5), nrow = 5, ncol = 5)

rownames(data) <- paste0("row", 1:5)
colnames(data) <- paste0("col", 1:5)

heatmap(data)

# map visualization 
# geographical maps

install.packages("maps")
library(maps)

data <- read.csv("worldcities.csv")
df <- data.frame(data)

map(database = "world")
# marking points on map
points(x = df$lat[1:500], y = df$lng[1:500], col = "yellow")


# 3D graphs 
cone <- function(x, y){
  sqrt(x^2 + y^2 )
}
x <- y <- seq(-1, 1, length = 30) 
z <- outer(x, y, cone)

persp(x, y, z, main = "Perspective Plot of Cone", zlab = "Height", theta = 30, phi = 15, col = "orange", shade = 0.3 )


# Line Graphs
some_values <- c(13, 25, 2, 41, 43)
other_values <- c(14, 53, 50, 66, 2)
values <- c(1,3,24,3,5)

plot(some_values, type = "o", col = "purple", xlab = "Month", ylab = "Value", main = "Values in Months")

lines(other_values, type = "o", col = "orange")
lines(values, type = "o", col = "blue")


# Bar Charts
A <- c(17, 32, 8, 53, 1, 13)
barplot(A, xlab = "X-axis", ylab = "Y-axis", main = "Bart")

barplot(A, horiz = T, xlab = "X-axis", ylab = "Y-axis", main = "Bart")

B <- c("Jan", "feb", "Mar", "Apr", "May", "Jun")

# Plot the bar chart 
barplot(A, names.arg = B, xlab ="Month", 
        ylab ="Articles", col ="pink", 
        main ="Bar Chart -> Bart")


# example 1
colors = c("green", "orange", "brown")
months <- c("Mar", "Apr", "May", "Jun", "Jul")
regions <- c("East", "West", "North")

Values <- matrix(c(2, 9, 3, 11, 9, 4, 8, 7, 3, 12, 5, 2, 8, 10, 11), 
                 nrow = 3, ncol = 5, byrow = TRUE)

barplot(Values, main = "Total Revenue", names.arg = months, 
        xlab = "Month", ylab = "Revenue", 
        col = colors, beside = TRUE)

# Add the legend to the chart
legend("topleft", regions, cex = 0.7, fill = colors)




# example 2
barplot(Values, main = "Total Revenue", names.arg = months, 
        xlab = "Month", ylab = "Revenue", 
        col = colors)

# Add the legend to the chart
legend("topleft", regions, cex = 0.7, fill = colors)



# Histograms
v <- c(19, 23, 11, 5, 16, 21, 32, 14, 19, 27, 39)

hist(v, xlab = "Articles", col = "pink", border = "blue", xlim = c(0, 50), ylim = c(0, 5), breaks = 10)


# using histogram return values for labels using text()
m <- hist(v, xlab = "Articles", col = "pink", border = "blue", xlim = c(0, 50), ylim = c(0, 5), breaks = 10)
text(m$mids, m$counts, labels = m$counts, adj = c(0.5, -.5))

# histogram using non-uniform width
v <- c(19, 23, 11, 5, 16, 21, 32, 14, 19, 27, 39, 120, 40, 70, 90)
hist(v, xlab = "Weight", ylab ="Frequency",
     xlim = c(50, 100),
     col = "darkmagenta", border = "pink",
     breaks = c(5, 55, 60, 70, 75,
                80, 100, 140)) 
# xlim -> x eksen sınırları/aralıkları
# breaks -> sütun genişliklerini belirler. sütunlar arasındaki sınırları belirler


# Scatter Plots
input <- mtcars[, c("wt", "mpg")]
print(head(input))

plot(x = input$wt, y = input$mpg, xlab = "weight", ylab = "milage", xlim = c(1.5, 4), ylim = c(10, 25), main = "Weight vs Milage" )


# example 1 - scatter plot matrices
pairs(~wt + mpg + disp + cyl, data = mtcars, main = "Scatterplot Matrix")

# example 2 - scatter plot with fitted values
install.packages("ggplot2")
library(ggplot2)

ggplot(mtcars, aes(x = log(mpg), y = log(drat))) + 
  geom_point(aes(color = factor(gear))) + 
  stat_smooth(method = "lm", 
  col = "darkgreen", se = F, size = 1)

# example 3 - adding title with dynamic name
new_graph <- ggplot(mtcars, aes(x = log(mpg), y = log(drat))) + 
  geom_point(aes(color = factor(gear))) + 
  stat_smooth(method = "lm", 
              col = "darkgreen", se = F, size = 1)

new_graph + labs(
  title = "Relation btw Mile per hours and drat",
  subtitle = "Relationship break down by gear class",
  caption = "some caption"
)

# example 4 - 3D scatterplots
install.packages("plotly")
library(plotly)
attach(mtcars)
plot_ly(data = mtcars, x = ~mpg, y = ~hp, z = ~cyl, color = ~gear)


# Pie chart
values <- c(34,54, 22, 25)
labels <- c("A", "B", "C", "D")
pie(values, labels, main = "Letter pie chart", col = rainbow(length(values)))


# example 1
pie_percent <- round(100*values / sum(values), digits = 1)
pie(values, labels, main = "Letter pie chart", col = rainbow(length(values)))

legend("topleft", c("A","B","C","D"), cex = 0.5, fill = rainbow(length(values)))


# example 2 - add pie chart color palettes
install.packages("RColorBrewer")
library(RColorBrewer)

labels_2 <- c("A", "B", "C", "D")
# Set2 is color palette
labels <- brewer.pal(length(values),"Set2")
pie(values, labels = labels_2)

# example 3 - modify the line type of the borders of the plot with lty argument
pie(values, labels = labels_2, lty = 2)


# example 4 - add shading lines with the density argument
pie(values, labels = labels_2, col = rainbow(length(values)), density = 60, angle = 45)
  

# example 5 - 3D pie chart
install.packages("plotrix")
library(plotrix)

pie3D(values, labels = pie_percent, col = rainbow(length(values)))
legend("topright", c("A","B","C","D"), cex = 0.5, fill = rainbow(length(values)))



# Box plots
input <- mtcars[, c("mpg","cyl")]
data(mtcars)

boxplot(disp ~gear, data= mtcars, main = "displacement by gear", xlab = "gear", ylab = "displacement")

# example 1 - boxplot using notch
my_colors <- c("#FFA500", "#008000", "#1E90FF", "#FF1493")

boxplot(disp ~ gear, data = mtcars,
        main = "Displacement by Gear", xlab = "Gear", ylab = "Displacement",
        col = my_colors, border = "black", notch = TRUE, notchwidth = 0.5,
        medcol = "white", whiskcol = "black", boxwex = 0.5, outpch = 19,
        outcol = "black")

legend("topright", legend = unique(mtcars$gear),
       fill = my_colors, border = "black", title = "Gear")


# example 2 - multiple boxplot 
variables <- c("mpg", "disp", "hp", "wt")
par(mfrow = c(1, length(variables)))
for (var in variables) {
  boxplot(get(var) ~ gear, data = mtcars,
          main = paste("Box Plot of", var),
          xlab = "Gear",
          ylab = var,
          col = "skyblue",
          border = "black",
          notch = TRUE,
          notchwidth = 0.5,
          medcol = "white",
          whiskcol = "black",
          boxwex = 0.5,
          outpch = 19,
          outcol = "black")
}

# Reset the plotting layout
par(mfrow = c(1, 1))