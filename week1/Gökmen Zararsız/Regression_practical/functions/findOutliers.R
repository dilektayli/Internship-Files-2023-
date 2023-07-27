findOutliers <- function(data, abs.cutoff.z = 3){
  # Args:
  #   data: a numeric vector.
  #   abs.cutoff.z: absolute cutoff value for z-score.
  
  data <- as.numeric(data)
  abs.cutoff.z <- abs(abs.cutoff.z)
  z.scores <- scale(data)
  
  outliers <- which(z.scores <= -1*abs.cutoff.z | z.scores >= abs.cutoff.z)
  if (length(outliers) == 0){
    outliers <- NULL
  }
  return(outliers)
}