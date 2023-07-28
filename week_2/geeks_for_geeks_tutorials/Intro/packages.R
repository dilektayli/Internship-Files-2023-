# DPLYR PACKAGE -> data manipulation
# First, install and load the dplyr package
install.packages("dplyr")
library(dplyr)

# Create a data frame with missing data
d <- data.frame(name = c("Abhi", "Bhavesh", "Chaman", "Dimri"),
                age = c(7, 5, 9, 16),
                ht = c(46, NA, NA, 69),
                school = c("yes", "yes", "no", "no"))

# Finding rows with NA value
d %>% filter(is.na(ht))

d.name<- arrange(d, age) # Arranging name according to the age
select(d, starts_with("ht"))
select(d, contains("a"))
select(d, -starts_with("ht"))
select(d, matches("na"))


# mutate() and transmute()
mutate(d, x3 = ht + age)
transmute(d, x3 = ht + age)

summarise(d, mean = mean(age))


# sample_n() and sample_frac()
sample_n(d, 3)
sample_frac(d, 0.50)


# GRID & LATTICE PACKAGES
# grid package
library(grid)
png(file = "grid.png")

cir <- circleGrob(name = "cir", x = 0.3,y = 0.3, r = 0.2, gp = gpar(col = "pink", lty = 3))
gp <- gpar(col = "yellow", lty = 5)
grid.draw(cir)

rect <- rectGrob(name = "rect", x = 0.5, y = 0.5, width = 0.3, height = 0.4)
grid.draw(rect)

dev.off() # to see the result you have to run this line

# lattice package
install.packages("lattice")
library(lattice)

attach(mtcars)
png("density_plot_lattice.png")
densityplot(~hp, main = "densitiy plot", xlab = "hp")
dev.off()


# SHINY PACKAGE
install.packages("shiny")
library(shiny)


# APP 1
ui <- fluidPage(h1("Some text is here"), p(style = "font-family:Impact", "My first shiny app"))
server <- function(input, output){}
shinyApp(ui = ui, server = server)

# APP 2
ui <- fluidPage(
  sliderInput(inputId = "num",
              label = "choose a number",
              value = 10, 
              min = 1,
              max = 29
              ),
  plotOutput("hist")
)
server <- function(input, output){
  output$hist <- renderPlot({
    hist(rnorm(input$num))
  })
}
shinyApp(ui = ui, server = server)

# APP 3
ui <- fluidPage(
  textInput(inputId = "num", label = "choose a number", value = "", width = 100, placeholder = NULL),
  plotOutput("hist"),
  verbatimTextOutput("stats")
)
server <- function(input, output){
  data <- reactive({rnorm(input$num)})
  
  output$hist <- renderPlot({hist(data())})
  output$stats <- renderPrint({summary(data())})
}
shinyApp(ui = ui, server = server)


# APP 4
# Load necessary library
library(shiny)

# Define fluid page layout
ui <- fluidPage(
  textInput(inputId = "num",
            label = "Enter a numeric value", value = "10"),
  actionButton("button", "Calculate"),
  column(8, tableOutput("table"))
)
server <- function(input, output) {
# Take an action every time button is pressed
  observeEvent(input$button, {
    num_rows <- as.numeric(input$num) # Convert input$num to numeric
    if (!is.na(num_rows) && is.numeric(num_rows) && num_rows > 0) {
      cat("Showing", num_rows, "rows\n")
    } else {
      cat("Invalid input for 'num'. Please enter a valid positive numeric value.\n")
    }
  })
  
# Take a reactive dependency
  df <- eventReactive(input$button, {
    num_rows <- as.numeric(input$num) # Convert input$num to numeric
    if (!is.na(num_rows) && is.numeric(num_rows) && num_rows > 0) {
      head(cars, num_rows)
    } else {
      NULL
    }
  })
  
  output$table <- renderTable({
    df()
  })
}
shinyApp(ui, server)


# APP 5
ui <- fluidPage(sliderInput(
  inputId = "num",
  label = "choose a number",
  value = 25, 
  min = 1,
  max = 100),
actionButton(
  inputId = "go",
  label = "update"),
plotOutput("hist")
)

server <- function(input, output)
{
  data <- eventReactive(input$go, {
    rnorm(input$num)
  })
  
  output$hist <- renderPlot({
    hist(data())
  })
}
shinyApp(ui, server)

# APP 6
ui <- fluidPage(
  sliderInput("obs", "Number of observations", 0, 1000, 500),
  actionButton("goButton", "Go!", class = "btn-success"),
  plotOutput("distPlot")
)

server <- function(input, output)
{
  output$distPlot <- renderPlot({
    input$goButton
    dist <- isolate(rnorm(input$obs))
    hist(dist)
  })
}

shinyApp(ui, server)


# APP 7
ui <- fluidPage(
  checkboxGroupInput(
    "icons","choose icons: ",
    choiceNames = list(icon("dog"), icon("cat"), icon("fish"),icon("bug")),
    choiceValues = list("dog", "cat","fish","bug")),
  textOutput("txt")
)
server <- function(input, output, session){
  output$txt <- renderText({
    icons <- paste(input$icons, collapse = ", ")
    paste("you choose",icons)
  })
}
shinyApp(ui, server)


# APP 8
ui <- fluidPage(
  textInput("txt","Enter your text","Empty"),
  verbatimTextOutput("value")
)
print(verbatimTextOutput)

server <- function(input, output){
  output$value <- renderText({ input$text })
}
shinyApp(ui, server)


# APP 9
ui <- fluidPage(
  textInput(inputId = "name",label = "enter your name"),
  textOutput("txt")
)
server <- function(input, output, session){
  output$txt <- renderText({
    name <- paste(input$name, collapse = ", ")
    paste("Welcome ", name)
  })
}
shinyApp(ui, server)


# APP 10
ui <- fluidPage(
  sliderInput(
    inputId = "num",
    label = "choose a number",
    value = 10,
    min = 1,
    max = 22),
  wellPanel(plotOutput("hist"))
)
server <- function(input, output){
  output$hist <- renderPlot({
    hist(rnorm(input$num), main = input$title)
    })
}
shinyApp(ui, server)



# TIDYR PACKAGE -> creating tidy data
install.packages("tidyverse")
# devtools::install_github("tidyverse/tidyr") # github's version
library(tidyverse)

n <- 10
tidy_dataframe = data.frame(
  S.No = c(1:n), 
  Group.1 = c(23, 345, 76, 212, 88, 
              199, 72, 35, 90, 265),
  Group.2 = c(117, 89, 66, 334, 90, 
              101, 178, 233, 45, 200),
  Group.3 = c(29, 101, 239, 289, 176,
              320, 89, 109, 199, 56))


long <- tidy_dataframe %>% 
  gather(Group, Frequency, Group.1:Group.3)


separate_data <- long %>% 
  separate(Group, c("Allotment","Number"))


united_data <- separate_data %>% 
  unite(Group, Allotment, Number, sep = ".")

back_to_wide <- unite_data %>% 
  spread(Group, Frequency)


df <- iris
names(iris)

# nest() function ->  It creates a list of data frames containing all the nested variables. Nesting is implicitly a summarizing operation. 
head(df %>% nest(data = c(Species)))

#unnest() funciton
head(df %>% unnest(Species))

# fill() function
df <- data.frame(Month <- 1:6, Year = c(2000, rep(NA,5)))
df %>% fill(Year)


# full_seq -> fill the missing values
num_vec <- c(1,3,5,6,3,22)
full_seq(num_vec,1)

# drop NA values
df <- tibble(S.No = 1:10, Name = c("john", "sunny", "luke", "king", "tay", rep(NA, 5)))
df %>% drop_na(Name)

# replace_na()
df %>% replace_na(list(Name = "Ali Cabbar"))



# Data Visualization and Exploration -> ggplot2
# Data Wrangling and Transformation -> dplyr, tidyr, stringr, forcats
# Data Import and Management -> tibble, readr
# Functional Programming -> purrr



# load the library
library("ggplot2")

# create the dataframe with letters and numbers
gfg <- data.frame(
  x = c('A', 'B', 'C', 'D', 'E', 'F'),
  y = c(4, 6, 2, 9, 7, 3)
)

# display the bar
ggplot(gfg, aes(x, y, fill=x)) + geom_bar(stat="identity")






