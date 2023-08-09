library(shiny)


############# 
ui <- fluidPage(
  # app title ------
  titlePanel("Hello Shiny"),
  
  # sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # sidebar panel for inputs
    sidebarPanel(
      
      # input
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # main panel for displaying outputs ----
    mainPanel(
      
      # output: histogram
      plotOutput(outputId = "distPlot")
    )
  )
)



############# server
server <- function(input, output){
  
  # it will be reactive and therefore should be automatically re-executed when inputs change
  output$distPlot <- renderPlot({

    x <- faithful$waiting
    
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "pink", border = "white", xlab = "Waiting time to next eruption (in mins)", main = "Histogram of waiting times")
  })
}


######
shinyApp(ui, server)

# another way to run the app & show the codes with the display
# runApp("second.R", display.mode = "showcase")
