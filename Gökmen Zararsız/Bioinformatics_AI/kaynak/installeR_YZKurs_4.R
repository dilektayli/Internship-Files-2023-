# G. ZARARSIZ
# Packages to be installed.
## MLSeq
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MLSeq")

## DESeq2
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2")

## edgeR
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("edgeR")

## CRAN packages
# Packages to be installed.
pkgs.to.install <- c("VennDiagram", "pamr", "caret", "xtable")

# Install CRAN packages
install.packages(pkgs.to.install)