# G. ZARARSIZ
# Packages to be installed.
pkgs.to.install <- c("ggplot2", "lattice", "caret", "randomForest", "base64enc",
                     "htmltools", "jsonlite", "markdown", "mime", "rmarkdown",
                     "bslib", "jquerylib", "ROSE", "ellipse", "kernlab", "pROC")


# Install CRAN packages
install.packages(pkgs.to.install)
