a <- function(x) 10 * x
b <- function(){
  a <- function(x) x + 10
  a(12)
}
b() 


# getting input from keyboard
var = readline("Enter any number");
var = as.integer(var);
print(var)

# getting multiple inputs
{
  var1 <- readline("Enter 1st number: ")
  var2 <- readline("Enter 2nd number: ")
  var3 <-  readline("Enter 3rd number: ")
}
var1 <- as.integer(var1)
var2 <- as.integer(var2)
var3 <- as.integer(var3)

print(var1 + var2 + var3)

# get string from keyboard
var1 <- readline("Enter your name: ")
var2 <- readline("Enter a character: F/M: ")
var2 <- as.character(var2)


# Getting input from keyboard with scan() method
x <- scan()
print(x)


double_x <- scan(what = double()) # for double 
string_x <- scan(what = "") # for string 
char_x <- scan(what = character())# for character 


# reading file data using scan()
# be careful there is no file in the directory !!
file_string <- scan("file_string.txt", what = "")
file_double <- scan("file_double.txt", what = double())
file_char <- scan("file_char.txt", what = character())


# printing output of an R Program
print("xx")

# paste() method to print output with string and variable together. 
x <- "waooowww" 
print(paste(x, "is the best reaction"))


# sprintf() method
x <- "trying"
sprintf("%s is the best", x)
x <- 1
sprintf("%d is integer", x)
x <- 2.3
sprintf("%.3f is a float", x)


# cat() method
x <- "some text"
cat(x, " aaaaaa")

# message() method
message(x, " bbbbbbbbb")


# Write output to a file
write.table(x, file = "new.txt")


# print() method
x <- cars[1:5, ]
print(x)

x <- 9/4 
print(x, digits = 2)
print(x = 7/3, digits = 4)

x <- matrix(c(2, NA, 5, 9, NA, 32, 43), nrow = 2, byrow = TRUE)
print(x, na.print = "")



# for loop
x <- letters[4:10]
for(i in x){
  print(i)
} 

m <- matrix(2: 15, 2)
for (x in seq(nrow(m))) {
  for(y in seq(ncol(m))){
    print(m[x,y])
  }
}


# while loop
x <- 1
while(x <= 5){
  print(x)
  x <- x + 1
}

# repeat loop
x <- 1
repeat{
  print(x)
  x <- x + 1
  if(x > 4)
    break
}

# return() expression
func <- function(x){
  if(x>0)
    return("positive")
  if(x<0)
    return("negative")
  else
    return("zero")
}

func(0)
func(1)


# next statement
x <- 1:10
for(i in x){
  if( i %% 2 != 0)
    next
  print(paste(i, " is even number"))
}

# R if-else-if ladder Example
a <- 67
b <- 76
c <- 99


if(a > b && b > c)
{
  print("condition a > b > c is TRUE")
} else if(a < b && b > c)
{
  print("condition a < b > c is TRUE")
} else if(a < b && b < c)
{
  print("condition a < b < c  is TRUE")
}



# SWITCH
x <- switch(
  2,           # Expression
  "Geeks1",    # case 1
  "for",       # case 2
  "Geeks2"     # case 3
)
print(x)


# Expression in terms of the string value
y <- switch(
  "GfG3",              # Expression
  "GfG0"="Geeks1",     # case 1
  "GfG1"="for",        # case 2
  "GfG3"="Geeks2"      # case 3
)
print(y)

z <- switch(
  "GfG",               # Expression
  "GfG0"="Geeks1",     # case 1
  "GfG1"="for",        # case 2
  "GfG3"="Geeks2"      # case 3
)
print(z)


# SWITCH CASE
val <- switch(
  4,
  "Geeks1",
  "Geeks2",
  "Geeks3",
  "Geeks4",
  "Geeks5",
  "Geeks6"
)
print(val)


val1 = 6  
val2 = 7
val3 = "s"  
result = switch(  
  val3,  
  "a"= cat("Addition =", val1 + val2),  
  "d"= cat("Subtraction =", val1 - val2),  
  "r"= cat("Division = ", val1 / val2),  
  "s"= cat("Multiplication =", val1 * val2),
  "m"= cat("Modulus =", val1 %% val2),
  "p"= cat("Power =", val1 ^ val2)
)  

print(result)  

# FOR LOOP
for (i in c(-8, 9, 11, 45))
{
  print(i)
}

# break statement
for (i in c(3, 6, 23, 19, 0, 21))
{
  if (i == 0)
  {
    break
  }
  print(i)
}
print("Outside Loop")

# next statement
for (i in c(3, 6, 23, 19, 0, 21))
{
  if (i == 0)
  {
    next
  }
  print(i)
}
print('Outside Loop')

# creating multiple plots within for loop
mat <- matrix(rnorm(100), ncol = 5) # data matrix
par(nfrow = c(2, 3)) # set up the plot layout

for(i in 1:5){
  hist(mat[ ,i], main = paste("Column", i), xlab = "Values", col = "lightblue")
}



# FUNCTIONS (built-in & user-defined)

even_odd <- function(x){
  if(x %% 2 == 0)
    return("even")
  else
    return("odd")
}
print(even_odd(5))


rectangle <- function(length, width){
  area <- length * width
  perimeter <- 2 * (length + width) 
  result <- list("Area" = area, "Perimeter" = perimeter)
}

want <- rectangle(2,3)
print(want)
print(want["Area"])

# %%	Remainder operator
# %/%	Integer Division
# %*%	Matrix multiplication
# %o%	Outer Product
# %x%	Kronecker product
# %in%	Matching Operator



'%Greater%' <- function(a, b)
{
  if(a > b) print(a)
  else if(b > a) print(b)
  else print("equal")
}
5 %Greater% 7
2300 %Greater% 67


"replace<-" <- function(x, value)
{
  x[1] = value
  x
}
x = rep.int(5, 7)
replace(x) = 0L
print(x)










