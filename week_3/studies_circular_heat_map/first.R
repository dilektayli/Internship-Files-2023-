# CHAPTER 2 - CIRCULAR LAYOUT
install.packages("circlize")
library(circlize)

# 2.2 -> Rules for making the circular plot
# initialize layout -> create track -> add graphics -> create track -> add graphics -> .... -> clear


# 2.3 Sectors and tracks
sectors = c("d", "f", "e", "c", "g", "b", "a")
s1 = factor(sectors)
circos.initialize(s1, xlim = c(0, 1))

s2 = factor(sectors, levels = sectors)
circos.initialize(s2, xlim = c(0, 1))

# 2.8 other utilities
# 2.8.1 -> circlize() and reverse.circlize()
library(yaml)
data = yaml.load_file("https://raw.githubusercontent.com/Templarian/slack-emoji-pokemon/master/pokemon.yaml")
pokemon_list = data$emojis[1:40]
pokemon_name = sapply(pokemon_list, function(x) x$name)
pokemon_src = sapply(pokemon_list, function(x) x$src)


if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("EBImage")

circos.par("points.overflow.warning" = FALSE)
circos.initialize(pokemon_name, xlim = c(0, 1))
circos.track(ylim = c(0, 1), panel.fun = function(x, y) {
  pos = circlize:::polar2Cartesian(circlize(CELL_META$xcenter, CELL_META$ycenter))
  image = EBImage::readImage(pokemon_src[CELL_META$sector.numeric.index])
  circos.text(CELL_META$xcenter, CELL_META$cell.ylim[1] - mm_y(2),
              CELL_META$sector.index, facing = "clockwise", niceFacing = TRUE,
              adj = c(1, 0.5), cex = 0.6)
  rasterImage(image, 
              xleft = pos[1, 1] - 0.05, ybottom = pos[1, 2] - 0.05,
              xright = pos[1, 1] + 0.05, ytop = pos[1, 2]+ 0.05)
}, bg.border = 1, track.height = 0.15)




# Load the required libraries
library(yaml)
library(circlize)
library(EBImage)

# Load Pokémon data from the provided URL
data <- yaml.load_file("https://raw.githubusercontent.com/Templarian/slack-emoji-pokemon/master/pokemon.yaml")
pokemon_list <- data$emojis[1:40]
pokemon_name <- sapply(pokemon_list, function(x) x$name)
pokemon_src <- sapply(pokemon_list, function(x) x$src)

# Install and load the EBImage package
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("EBImage")
library(EBImage)

# Set circos parameters
circos.par("points.overflow.warning" = FALSE)

# Initialize the circular plot with Pokémon names sorted alphabetically
circos.initialize(sort(pokemon_name), xlim = c(0, 1))

# Define the function for displaying Pokémon images and names
circos.track(ylim = c(0, 1), panel.fun = function(x, y) {
  pos <- circlize:::polar2Cartesian(circlize(CELL_META$xcenter, CELL_META$ycenter))
  image <- EBImage::readImage(pokemon_src[CELL_META$sector.numeric.index])
  circos.text(CELL_META$xcenter, CELL_META$cell.ylim[1] - mm_y(2),
              CELL_META$sector.index, facing = "clockwise", niceFacing = TRUE,
              adj = c(1, 0.5), cex = 0.6)
  rasterImage(image, 
              xleft = pos[1, 1] - 0.05, ybottom = pos[1, 2] - 0.05,
              xright = pos[1, 1] + 0.05, ytop = pos[1, 2] + 0.05)
}, bg.border = 1, track.height = 0.15)



















