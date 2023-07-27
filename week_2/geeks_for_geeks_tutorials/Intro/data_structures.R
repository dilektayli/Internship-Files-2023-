# vectors, lists, data frames, matrices, arrays, factors


# Vectors (ordered collection of same data type)
X <- c(1, 3, 5, 7, 8)
empId <- c(1, 2, 3, 4)

X<- c(2, 5, 18, 1, 12)
cat('Using Subscript operator', X[2], '\n')
cat('Using Subscript operator', X[c(3,2)], '\n')

# Lists (consisting of an ordered collection of objects)
emp_list <- list(empId, X)

empId = c(1, 2, 3, 4)
empName = c("Debi", "Sandeep", "Subham", "Shiba")
numberOfEmp = 4
empList = list(
  "ID" = empId,
  "Names" = empName,
  "Total Staff" = numberOfEmp
)
print(empList[[2]])
print(empList[[2]][2])

# Convert the lists to vectors.
lst <- list(1:5)
print(lst)
vec <- unlist(lst)

# Convert the lists to matrices.
mat <- matrix(unlist(lst), nrow = 2, byrow = TRUE)



#Data frames (heterogeneous generic data objects of R which are used to store the tabular data)
Name = c("Amiya", "Raj", "Asish")
Language = c("R", "Python", "Java")
Age = c(22, 25, 45)
df = data.frame(Name, Language, Age)

summary(df)
df$Name

# remove values 
df <- subset(df, df$Name != "Raj")



# Matrices ( two-dimensional, homogeneous data structures)
A <-  matrix(
  c(1, 2, 3, 4, 5, 6, 7, 8, 9),
  nrow = 3, ncol = 3, 
  byrow = TRUE                            
)
print(diag(c(5, 3, 3), 3, 3))
print(diag(1, 3, 3)) # identity matrix

A = matrix(
  c(1, 2, 3, 4, 5, 6, 7, 8, 9),
  nrow = 3,            
  ncol = 3,            
  byrow = TRUE         
)
B = matrix(
  c(10, 11, 12),
  nrow = 1,
  ncol = 3
)

C = rbind(A, B) # row-based
C = cbind(A, B) # column-based # This will give an error because of dimension inconsistency


# Arrays (data objects which store the data in more than two dimensions. Arrays are n-dimensional homogeneous data structures)
A = array(
  c(1, 2, 3, 4, 5, 6, 7, 8),
  dim = c(2, 2, 2)                       
)

row_names <- c("row1", "row2")
col_names <- c("col1", "col2", "col3")
mat_names <- c("Mat1", "Mat2")

arr = array(2:14, dim = c(2, 3, 2), 
            dimnames = list(row_names, 
                            col_names, mat_names))
print (arr[,,1])
print(arr[,,"Mat2"])
print (arr[, c(2, 3), 1])


# Factors (data objects which are used to categorize the data and store it as levels. They are useful for storing categorical data)
fac = factor(c("Male", "Female", "Male", "Male", "Female", "Male", "Female"))

gender <- factor(c("female", "male", "male", "female"), levels = c("female", "transgender", "male"))
gender[1]

# add new level
levels(gender) <- c(levels(gender), "other")   








