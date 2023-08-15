# Load packages 

library(shiny)
library(ggplot2)

# Get the data

file <- "https://github.com/rstudio-education/shiny-course/raw/main/movies.RData"
destfile <- "movies.RData"

download.file(file, destfile)

# Load data 

load("movies.RData")

# Define UI 
ui <- fluidPage(
  
  sidebarLayout(
    
    # Inputs: Select variables to plot
    sidebarPanel(
      
      # Select variable for y-axis
      selectInput(
        inputId = "y",
        label = "Y-axis:",
        choices = c(
          "IMDB rating" = "imdb_rating", 
          "IMDB number of votes" = "imdb_num_votes",
          "Critics score" = "critics_score", 
          "Audience score" = "audience_score", 
          "Runtime" = "runtime"),
        selected = "critics_score"
      ),
      # Select variable for x-axis
      selectInput(
        inputId = "x",
        label = "X-axis:",
        choices = c(
          "IMDB rating" = "imdb_rating", 
          "IMDB number of votes" = "imdb_num_votes",
          "Critics score" = "critics_score", 
          "Audience score" = "audience_score", 
          "Runtime" = "runtime"),
        selected = "critics_score"
      ),
      # new selectInput
      selectInput(
        inputId = "z",
        label = "color",
        choices = c(
          "IMDB rating" = "imdb_rating", 
          "IMDB number of votes" = "imdb_num_votes",
          "Critics score" = "critics_score", 
          "Audience score" = "audience_score", 
          "Runtime" = "runtime"),
        selected = "critics_score"
      ),
      
      
    ),
    
    # Output: Show scatterplot
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
  )
)

# Define server 

server <- function(input, output, session) {
  output$scatterplot <- renderPlot({
    ggplot(data = movies, aes_string(x = input$x, y = input$y, color = input$z)) +
      geom_point()
  })
}

# Create a Shiny app object 

shinyApp(ui = ui, server = server)