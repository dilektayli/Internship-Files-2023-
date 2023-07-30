# data handling
# DATA INTERFACES
# note : the files are not included in the directory. 
# Data Handling

# get content into a data frame
data <- read.table("file.txt", header = FALSE,sep = " ")
data <- read.csv("file.txt", header = FALSE,sep = "\t")

# exporting files
# cat() function
str <- "world"
cat("Hello ", str, file = "file.txt" )

# sink() function -> redirect all outputs to file
sink("file.txt") # start redirecting outputs
x <- c(1,3,2,5,2)
print(mean(x))
print(sum(x))
sink()

# writing to csv files
x <- c(1, 3, 4, 5, 10)
y <- c(2, 4, 6, 8, 10)
data <- cbind(x, y)
write.csv(data, file = "CSVWrite.csv", row.names = FALSE)


# IMPORTING DATA 
# read.csv() -> reading comma-separated value(csv) files 
data <- read.csv(file.choose(), header = T)

#read.table()
data <- read.table(file.choose(), header = T, sep = ", ")

# reading tab-delimited(txt) file
# read.delim()
data <- read.delim(file.choose(), header = T)

# read.table()
data <- read.table(file.choose(), header = T, sep = "\t")

# reading json files
install.packages(rjson)
library("rjson")
result <- fromJSON(file = "file.json")


# EXPORTING DATA FROM SCRIPTS
df = data.frame(
  "Name" = c("Amiya", "Raj", "Asish"),
  "Language" = c("R", "Python", "Java"),
  "Age" = c(22, 25, 45)
)
#  write.table() -> export a data frame to a text file using
write.table(df,
        file = "file.txt",
        sep = "\t",
        row.names = TRUE,
        col.names = NA)

# write_tsv() -> tab-separated 
library(readr)
write_tsv(df, path = "file.txt")

# write.table() -> csv file
write.table(df, file = "file.csv", sep = "\t", row.names = FALSE)

# write.csv() -> use this function where . is used for decimal point
write.csv(df, file = "file.csv")

# write.csv2() -> where , is used for decimal point like Turkey
write.csv2(df, file = "file.csv")

# WORKING WITH CSV FILES
# read csv file
csv_data <- read.csv(file = "file.csv")
ncol(csv_data) 
crow(csv_data)
min_project <- min(csv_data$projects)
new_csv <- subset(csv_data, department == "HR" && projects < 12)
write.csv(new_csv, "new_sample.csv", row.names = FALSE)


# WORKING WITH XML FILES
# xml -> stands for Extensible Markup Language is made up for markup tags, wherein each tag illustrates the information carried by the particular attribute in the XML file. 
install.packages("XML")
library(XML)
library(methods)

# read xml file
data <- xmlParse(file = "file.xml")

# extract the root node
rootnode <- xmlRoot(data)

#number of nodes in the root
nodes <- xmlSize(rootnode)

# get entire contents of a record
second_node <- rootnode[2]

#get 3rd attribute of 4th record
attri <- rootnode[[4]][[3]]

cat('number of nodes: ', nodes)
print ('details of 2 record: ')
print (second_node)
 
# prints the marks of the fourth record
print ('3rd attribute of 4th record: ', attr)


# conversion of XML to dataframe
df <- xmlToDataFrame("file.xml")


# Working with Excel Files
# Excel files are of extension .xls, .xlsx and .csv(comma-separated values).

# Reading Files
install.packages("readxl")
library(readxl)

data_frame <- read_excel("file.xlsx")
data_frame2 <- read_excel("file.xlsx")

# modifying files
data_frame$Pclass <- 0
# deleting from files
data_frame <- data_frame[-2]

# merging files
data <- merge(data_frame, data_frame2, all.x = TRUE, all.y = TRUE)

# creating feature in data_frame -> creating new columns 
data_frame$Num <- 0

# writing files 
install.packages("writexl")
library(writexl)
write_xlsx(data_frame, "file.xlsx")


# Working with JSON files 
# json -> stands for JavaScript Object Notation. These files contain the data in human readable format such as text. 

install.packages("rjson")
library(rjson)
result <- fromJSON(file = "file.json")

# writing into a JSON file
# creating the list
list1 <- vector(mode="list", length=2)
list1[[1]] <- c("sunflower", "guava", "hibiscus")
list1[[2]] <- c("flower", "fruit", "flower")

# creating the data for JSON file
jsonData <- toJSON(list1)
  
# writing into JSON file
write(jsonData, "result.json") 
  
# Give the created file name to the function
result <- fromJSON(file = "result.json")

# Converting the JSON data into Dataframes
result <- fromJSON(file = "file.json")
json_data_frame <- as.data.frame(result)


# Working with URLs -> RJSONIO or jsonlite
install.packages("RJSONIO")
library(RJSONIO)

# extracting data from the website
Raw <- fromJSON("https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD")

# extract the data node
food_market <- Raw[["data"]]

# assembling the data into data frames
Names <- sapply(food_market, function(x) x[[14]])



# Working with Databases 
# connection with MySQL
install.packages("RMySQL")
library(RMySQL)

# create connection
mysql_conn <- dbConnect(MySQL(),user = "root", password = "welcome", dbname "Database test", host = "localhost")

# show tables in database
dbListTables(mysql_conn)

# creating new table mtcars
dbWriteTable(mysql_conn, "mtcars", mtcars[1:10, ], overwrite = TRUE)

# drop tables mtcars from database
dbSendQuery(mysql_conn, "DROP TABLE mtcars")

# insert into table
dbSendQuery(mysql_conn, "insert into articles(sno, type) values(1, 'JAVA')") 

# updating a table
dbSendQuery(mysql_conn, "update articles SET sno = 10 where type = 'JAVA'")
 
# querying a table
# select all rows from articles table
res <- dbSendQuery(mysql_conn, "Select * From articles")

# fetch first 3 rows in data frame
df <- fetch(res, n = 3)
