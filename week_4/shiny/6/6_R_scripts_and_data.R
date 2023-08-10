install.packages(c("maps","mapproj"))
library(maps)
library(mapproj)

source("helpers.R")
counties <- readRDS("counties.rds")
percent_map(counties$white, "darkgreen", "%white")
