file.create("GFG.txt")

write.table(x = iris[1:10, ], file = "CFG.txt")
file.rename("CFG.txt","newCFG.txt")

file.exists("CFG.txt")

new.iris <- read.table(file = "newCFG.txt")

list.files()
# file.copy("a","b")

dir.create("CFG")



# Reading files 

# read.delim() tab-separated value -> . is the decimal point
data <- read.delim("new.txt",header = FALSE)

# read.delim2() tab-separated value -> , is the decimal point
data <- read.delim2("new.txt",header = FALSE) 


# when you do not know where the file is
data <- read.delim(file.choose(), header = FALSE)

# read_tsv() tab-separated(\t) values
install.packages("readr")
library(readr)
data <- read_tsv("new.txt",col_names = FALSE)

# read_lines() -> reading one line at a time
install.packages("readr")
library(readr)
data <- read_lines("new.txt", n_max = 1)

# read_file() -> reading the whole file
read_file("new.txt")

# read.table() -> reading a file in a table format
read.table("new.txt")

# read.csv() -> comma seperated value files -> imported as data frame
read.csv("new.csv")

# read.csv2() -> . is decimal point & ; is field seperators
read.csv2("new.csv")

# read.delim() read.csv() read.table() for reading file from internet
read.delim("link")




# WRITING TO FILES 
data <- "text to be added"
write.csv(data, file = "new.csv")
write.table(data, file="new.txt", sep = "")

# writing to excel files 
install.packages("xlsx")
library("xlsx")
write.xlsx(data, file = "new.xlsx", sheetName = "new_data", append = FALSE)


# Working with binary files

# Creating a data frame
df = data.frame(
  "ID" = c(1, 2, 3, 4),
  "Name" = c("Tony", "Thor", "Loki", "Hulk"),
  "Age" = c(20, 34, 24, 40),
  "Pin" = c(756083, 756001, 751003, 110011)
)















