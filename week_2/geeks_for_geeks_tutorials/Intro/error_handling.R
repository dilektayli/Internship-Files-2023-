# Error handling

# tryCatch()
tryCatch(
  # specify expression
  expr = {
    1 + 1
    print("Everything is under control")
  },
  error = function(e){
    print("There was an error")
  },
  warning = function(w){
    print("There was a warning")
  },
  finally = {
    print("finally done with it")
  }
)

# withCallingHandlers()
check <- function(expression){
  withCallingHandlers(expression,
                      warning = function(w){
                        message("warning: \n",w)
                      },
                      error = function(e){
                        message("error: \n",e)
                      },
                      finally = {
                        message("completed")
                      }
                      )
}

check({19/2})
check({2/0})
check({10/'noe'})


# Condition Handling 
success <- try(100 + 200) 
failure <- try("100" + "200")
class(success)
class(failure)


# Using tryCatch()
message_handler <- function(c) cat("Important message is caught!\n") 
tryCatch(message = message_handler,
         { 
           message("1st value printed?") 
           message("Second value too printed!") 
         })


# Using withCallingHandlers()
message_handler <- function(c) cat("Important message is caught!\n") 
withCallingHandlers(message = message_handler,
                    { 
                      message("1st value printed?") 
                      message("Second value too printed!") 
                    })












