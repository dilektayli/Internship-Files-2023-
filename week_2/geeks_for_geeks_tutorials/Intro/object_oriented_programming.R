# Creating a list with its attributes name and roll no
a <- list(name = "Adam", roll_no = 13)
class(a)
# defining a class "Student"
class(a) <- "Student"
class(a)

# creation of object
print(a)
a
a$name


print_student <- function(obj){
  cat("name: ", obj$name, "\n")
  cat("Roll no: ", obj$roll_no, "\n")
}
print(a)

attributes(a)

# adding attributes to an object by using attr
attr(a, "age") <- c(22)
attributes(a)


s <- list(name = "eminem", roll = 22, country = "space")
class(s) <- c("Student", "student")
s

print_student <- function(obj){
  cat(obj$name, "is from",obj$country,"\n" )
}
print_student(s)


# setClass() to create class containing list 
setClass("Student", slots = list(name = "character", roll_no = "numeric"))

# new keyword
a <- new("Student", name = "Eminem", roll_no = 12)
a

# generator function to help in creating objects and it acts as a constructor
stud <- setClass("Student", slots = list(name = "character", roll_no = "numeric"))
stud

stud(name = "adam", roll_no = 23)



# define a class
setClass("student",
         slots = list(name = "character", age = "numeric", rno = "numeric")
)

# define a function to display object details
setMethod("show", "student", function(obj){
  cat(obj@name, "\n")
  cat(obj@age, "\n")
  cat(obj@rno, "\n")
})

# Inherit from student
setClass("InternationalStudent", 
         slots = list(country = "character"),
         contains = "student"
         )

# rest of the attributes will be inherited from student
s <- new("InternationalStudent", name = "Eve", age = 22, rno = 23, country = "spain")

show(s)



# CLASSES IN R PROGRAMMING 
# R has 3 class systems. S3, S4, and Reference Classes

# 1. S3 Class
movieList <- list(name = "Iron Man", lead_actor = "Robert Downey Jr")
class(movieList) <- "movie"
movieList

# 2. S4 Class
setClass("movies", slots = list(name = "character", lead_actor = "character"))
movieList <- new("movies", name = "Iron Man", lead_actor = "Robert Downey Jr")
movieList

# setMethod()
setMethod("show", "movies", function(object){
  cat("The name of the movie is ", object@name, ".\n")
  cat(object@lead_actor, "is the lead actor.\n")
})
movieList

# Reference Class -> gives an error could not find why
movies <- setRefClass("movies", fields = list(movie_name = "character", lead_actor = "character", rating = "numeric")) # returns generator
movieList <- movies(movie_name = "Iron Man", lead_actor = "Robert Downey Jr", rating = 8)
movieList

# R OBJECTS

# 1. vectors
x <- c(1,2,"1",4,5)
z <- 4

# 2. lists
ls <- list(c(1,2,3), list("a","c","f"))


# 3. matrices -> 2-dimensional array
mat <- matrix(x,nrow = 2)


# 4. factors
s <- c("spring", "autumn", "winter", "summer", "spring", "autumn")
factor(s)

# 5. arrays
arr <- array(c(1,2,3), dim = c(2,1,4))

# 6. data frames -> 2-dimensional tabular data
x <- 1:5
y <- LETTERS[1:5]
z <- c("Albert", "Bob", "Charlie", "Denver", "Elie")

df <- data.frame(x, y, z)


# ENCAPSULATION
# Encapsulation ensures that the outside view of the object is clearly separated from the inside view of the object by hiding the implementation of operation and state from the interface which is available to all other objects. 

# POLYMORPHISM  
# lets you define a generic method or function for types of objects you haven’t yet defined and may never do -> summary, plot, display


# R INHERITANCE


# S3 class
# Create a function to create an object of class
student <- function(n, a, r){
  value <- list(name = n, age = a, rno = r)
  attr(value, "class") <- student
  value
}

# Method for generic function print()
print.student <- function(obj){
  cat(obj$name, "\n")
  cat(obj$age, "\n")
  cat(obj$rno, "\n")
}

# Create an object which inherits class student
s <- list(name = "Utkarsh", age = 21, rno = 96,
          country = "India")

# Derive from class student
class(s) <- c("InternationalStudent", "student")

cat("The method print.student() is inherited:\n")
print(s)

# Overwriting the print method
print.InternationalStudent <- function(obj){
  cat(obj$name, "is from", obj$country, "\n")
}

cat("After overwriting method print.student():\n")
print(s)

# Check imheritance
cat("Does object 's' is inherited by class 'student' ?\n")
inherits(s, "student")


# Looping with different functions since for is costly
# apply() -> applies over the margins of an array of matrix
A = matrix(1:9, 3, 3)
print(A)
r = apply(A, 1, sum)


# lapply() -> apply a function over a list or a vector
A = matrix(1:9, 3, 3)
B = matrix(10:18, 3, 3) 
myList = list(A, B)
determinant = lapply(myList, det)


# sapply() -> same as lapply() but simplified results
A = list(a = 1:5, b = 6:10)
means = sapply(A, mean)


# tapply() -> apply a function over a ragged array
Id = c(1, 1, 1, 1, 2, 2, 2, 3, 3)
val = c(1, 2, 3, 4, 5, 6, 7, 8, 9)
result = tapply(val, Id, sum)


# mapply() -> multivariate version of lapply()
A = list(c(1, 2, 3, 4))
B = list(c(2, 5, 1, 6))
result = mapply(sum, A, B)


# Explicit Coercion
# as.numeric, as.list etc
















