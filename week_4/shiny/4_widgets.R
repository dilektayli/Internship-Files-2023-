# Control Widgets

library(shiny)

# Define UI -----
ui <- fluidPage(
  titlePanel("Basic Widgets"),
  fluidRow(
    column(3,
           h3("Buttons"),
           actionButton("action","Action"),
           br(),
           br(),
           submitButton("Submit")),
    
    column(3,
           h3("Single checkbox"),
           checkboxInput("checkbox", "choice A", value = T)),
    
    column(3,
           checkboxGroupInput("checkGroup",
                              h3("Checkbox group"),
                              choices = list("Choice 1" = 1,
                                             "Choice 2" = 2,
                                             "Choice 3" = 3),
                              selected = 1)),
    column(3,
           dateInput("date", h3("Date Input"), value = "2001-07-22"))),
  
    fluidRow(
      column(3,
             dateRangeInput("dates", h3("Date range"))),
      
      column(3,
             fileInput("file", h3("File Input"))),
      
      
      column(3,
             h3("Help Text"),
             helpText("Note: help text is not a true widget, ",
                      "but it provides an easy way to add text to",
                      "accompany other widgets.")),
      
      column(3,
             numericInput("num",
                          h3("Numeric Input"),
                          value = 1))
    ),
  
  fluidRow(
    column(3, 
           radioButtons("radio", h3("Radio Buttons"),
                        choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), selected = 1)),
    column(3,
           selectInput("select", h3("Select Box"), 
                       choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), selected = 1)),
    column(3, 
           sliderInput("slider1", h3("Sliders"),
                       min = 0, max = 100, value = 50),
           sliderInput("slider2", "", min = 0, max = 100, value = c(25, 75))
           ),
    column(3,
           textInput("text", h3("Text input"), value = "Enter text..."))
  )
)


server <- function(input, output){
  
}

shinyApp(ui, server)






















