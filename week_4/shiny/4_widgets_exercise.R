library(shiny)

ui <- fluidPage(
  titlePanel("censusVis"),
  br(),
  sidebarLayout(
    sidebarPanel(
      helpText("Create demograhic maps with information from 2010 US Census"),
      selectInput("var", label = "Choose a variable to display", choices = list("Percent White", "Percent Black", "Percent Hispanic", "Percent Asian"), selected = "Percent White"),
      sliderInput("range",label = "Range of interest", min = 0, max = 100, value = c(0, 100))
    ),
  mainPanel()
)
)
  
  
server <- function(input, output){
  
}

shinyApp(ui, server)




























