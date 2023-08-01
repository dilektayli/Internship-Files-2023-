# continuous uniform distribution

# example 1
qunif(0.2, min = 0, max = 40)

# example 2
min <- 0
max <- 1
xpos <- seq(min, max , by = 0.02)                      
ypos <- qunif(xpos, min = 10, max = 100)       
plot(ypos) 



# probability density function 
min <- 0
max <- 100
xpos <- seq(min, max , by = 0.5)                      
ypos <- dunif(xpos, min = 10, max = 80)       
plot(ypos , type="o") 

# cumulative probability distribution
punif(15, min = 0, max = 60, lower.tail = F)



