# call the find_interval function during training. You need to do it in a for loop to find the best incrementing value.
start <- 2
end <- 10
best_intervals <- list()


for (i in start:end) {
  intervals <- find_interval(start, end, i)
  best_intervals[[as.character(i)]] <- intervals
  i <- i + 1
}



find_interval <- function(start, end, increment){
  intervals <- c()
  iteration <- start
  
  while (iteration <= end) {
    sub_interval <- paste(iteration, iteration + increment, sep = "-")
    intervals <- c(intervals, sub_interval)
    iteration <- iteration + increment
  }
  return (intervals)
}




# find the best interval
print(best_intervals)














