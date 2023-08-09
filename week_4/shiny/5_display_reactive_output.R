# 2 Steps
# 1. add an R object to your user interface
# 2. tell Shiny how to build the object in the server function. The object will be reactive if the code that builds it calls a widget value.



ui <- fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText(
        "Create demograhic maps with information from the 2010 US Census"
      ),
      
      selectInput(
        "var", label = "Choose a variable to display", choices = c("White", "Black", "Hispanic", "Asian"), selected = "White"
      ),
      
      sliderInput(
        "range", label = "Range of interest:",
        min = 0, max = 100, value = c(0, 100)
      )
    ),
    mainPanel(
      textOutput("selected_var"),
      textOutput("range")
    )
  )
)


server <- function(input, output){
  output$selected_var <- renderText({
    paste("You have selected this: ", input$var)
  })
  
  output$range <- renderText({
    paste("You have chosen a range that goes from ",input$range[1], "to", input$range[2])
  })
}

shinyApp(ui, server)

























