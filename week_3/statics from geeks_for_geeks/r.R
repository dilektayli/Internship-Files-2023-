# R statistics


# bar plot
feeds <- table(chickwts$feed)
par(oma = c(1,1,1,1))
par(mar = c(4,5,2,1))
barplot(feeds[order(feeds, decreasing = T)])
barplot(feeds[order(feeds)], horiz = T, xlab = "Number of Chicks", las = 1, col = "pink")


# pie chart
d <- table(chickwts$feed)
pie(d[order(d, decreasing = T)], clockwise = T, main = "Pie Chart")


# histogram
hist(lynx)
hist(lynx, breaks = 7, col = "purple", main = "histogram")
curve(dnorm(x, mean = mean(lynx), sd = sd(lynx)), col = "orange", lwd = 2, add = T)


# box plot
boxplot(USJudgeRatings$RTEN, horizontal=TRUE,
        xlab="Lawyers Rating", notch=TRUE,
        ylim=c(0, 10), col="pink")





