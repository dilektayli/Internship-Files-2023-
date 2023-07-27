diagnosticPlots <- function(data){
  qqLineData <- summarise(data, q25 = quantile(Residuals, 0.25),
                          q75 = quantile(Residuals, 0.75),
                          qn25 = qnorm(0.25),
                          qn75 = qnorm(0.75),
                          slope = (q25 - q75) / (qn25 - qn75),
                          int = q25 - slope * qn25)
  
  gg_theme <- theme(panel.grid = element_blank(),
                    plot.margin = ggplot2:::margin(0.5, 0.5, 0.7, 0.7, unit = "cm"),
                    plot.title = element_text(hjust = 0.5, face = "bold"),
                    axis.text.x = element_text(margin = ggplot2:::margin(5, 0, 0, 0)),
                    axis.title.x = element_text(margin = ggplot2:::margin(10, 0, 0, 0)),
                    axis.text.y = element_text(margin = ggplot2:::margin(0, 5, 0, 0)),
                    axis.title.y = element_text(margin = ggplot2:::margin(0, 10, 0, 0)))
  
  ## Q-Q Plot (Raw residuals)
  QQPlot <- ggplot(data, aes(sample = Residuals)) +
    stat_qq(distribution = qnorm, cex = 4) +
    geom_abline(intercept = qqLineData$int, slope = qqLineData$slope) +
    xlab(label = "Theoretical") +
    ylab(label = "Observed") + 
    theme_bw(base_size = 14) + ggtitle("Q-Q plot of raw residuals") +
    gg_theme
  
  ## Histogram
  histogramPlot <- ggplot(data, aes(x = Residuals, y = ..density..)) +
    geom_histogram(fill = "gray60", colour = "black", bins = 15) + 
    xlab(label = "Raw residuals") +
    ylab(label = "Density") + 
    theme_bw(base_size = 14) + ggtitle("Histogram of raw residuals") +
    gg_theme
  
  ## Fitted vs. Raw Residuals
  fitted.vs.resid <- ggplot(data, aes(x = Predicted, y = Residuals)) +
    geom_point(size = 2) + 
    geom_hline(yintercept = 0, lty = 2) + 
    xlab(label = "Fitted values") +
    ylab(label = "Raw residuals") + 
    theme_bw(base_size = 14) + ggtitle("Fitted vs. Residuals") +
    gg_theme
  
  ## Independence of Residual
  independencePlot <- ggplot(data, aes(x = ResidID, y = Residuals)) +
    geom_line(colour = rgb(1, 0, 0, 0.7)) + 
    geom_hline(yintercept = 0, lty = 2) +
    geom_point(size = 2) +
    xlab(label = "Order") +
    ylab(label = "Raw residuals") + ggtitle("Independence of residuals") +
    theme_bw(base_size = 14) +
    gg_theme
  
  return(list(QQPlot, histogramPlot, fitted.vs.resid, independencePlot))
}