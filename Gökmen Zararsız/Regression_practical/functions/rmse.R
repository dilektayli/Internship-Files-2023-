rmse <- function(x, y = NULL){
  n <- length(x)
  if (!is.null(y)){
    x <- y - x
  }
  sqrt((1 / (n - 1)) * sum(x^2))
}