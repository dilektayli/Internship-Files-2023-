find_and_store_intervals <- function(start, end) {
  stored_data <- list()
  
  for (increment in start:end) {
    intervals <- c()
    interval_values <- c()
    iteration <- start
    
    while (iteration <= end) {
      sub_interval <- paste(iteration, iteration + increment - 1, sep = "-")
      intervals <- c(intervals, sub_interval)
      interval_values <- c(interval_values, iteration)
      iteration <- iteration + increment
    }
    
    # intervals stored as a list
    stored_data[[as.character(increment)]] <- interval_values
  }
  
  return(stored_data)
}



start <- 2
end <- 10
stored_data <- find_and_store_intervals(start, end)

# Accessing the stored_data for the increment 2 i.e. values are increasing by 2
stored_data[["2"]]

# when you are going to use the intervals unlist the stored_data list in order to make it integer
as.integer(unlist(stored_data[["2"]]))

#typeof(as.integer(unlist(stored_data[["2"]])))
