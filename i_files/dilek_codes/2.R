find_best_intervals <- function(start, end) {
  best_intervals <- list()
  
  for (increment in start:end) {
    intervals <- c()
    iteration <- start
    
    while (iteration <= end) {
      sub_interval <- paste(iteration, iteration + increment - 1, sep = "-")
      intervals <- c(intervals, sub_interval)
      iteration <- iteration + increment
    }
    
    best_intervals[[as.character(increment)]] <- intervals
  }
  
  return(best_intervals)
}

start <- 2
end <- 10
best_intervals <- find_best_intervals(start, end)
print(best_intervals)
