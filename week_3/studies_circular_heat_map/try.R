# Load the circlize package
library(circlize)

# Data for the circular heat map
main_groups <- c("Animals", "Fruits", "Colors", "Shapes", "Countries")
sub_groups <- list(
  Animals = c("Birds", "Cats", "Dogs"),
  Fruits = c("Apples", "Bananas", "Oranges"),
  Colors = c("Blue", "Green", "Red"),
  Shapes = c("Circles", "Squares", "Triangles"),
  Countries = c("Australia", "Brazil", "Canada")
)

# Define the colors for the heat map (you can modify this as needed)
colors <- c("#FFCC00", "#FF9900", "#FF6600", "#FF3300", "#FF0000")

# Set up the circular layout with sectors for main groups
circos.par(start.degree = 90)

# Create a circular heat map
par(mar = c(1, 1, 1, 1)) # Set margin to leave space for labels
circos.initialize(factors = main_groups, xlim = c(0, 1))

# Loop through main groups and set up the tracks
for (i in 1:length(main_groups)) {
  circos.track(ylim = c(0, 1), factors = sub_groups[[main_groups[i]]], 
               bg.col = colors[i])
  
  # Draw the heat map segments within each track
  circos.trackPlotRegion(factors = sub_groups[[main_groups[i]]], 
                         bg.col = colors[i])
}

# Draw sector labels
circos.text(1.15, seq_along(main_groups), main_groups, facing = "inside", 
            niceFacing = TRUE, adj = c(0, 0.5))

# Draw track labels
circos.text(1.3, seq_along(main_groups), main_groups, facing = "inside", 
            niceFacing = TRUE, adj = c(0, 0.5), col = "black")

# Draw the circular heat map
circos.clear()
