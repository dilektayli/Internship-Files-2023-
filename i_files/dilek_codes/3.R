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

# Storing the data in the desired format
stored_data <- list()

for (increment in start:end) {
  best_interval_values <- best_intervals[[as.character(increment)]]
  interval_values <- sapply(strsplit(best_interval_values, "-"), function(x) as.numeric(x[1]))
  stored_data[[as.character(increment)]] <- interval_values
}

stored_data[1]


