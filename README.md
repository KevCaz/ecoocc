ecoocc
======

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/KevCaz/ecoocc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/KevCaz/ecoocc/actions/workflows/R-CMD-check.yaml)

A Rcpp implementation of various computations done on presence/absence
matrices.

Installation
------------

The simplest way to install this packages is to use the
[`remotes`](https://CRAN.R-project.org/package=remotes) package

    install.package("remotes")
    remotes::install_github("KevCaz/ecoocc")

Once installed, load it and try it!

    library(ecoocc)

What is implemented so far?
---------------------------

### Beta diversity

     (mat <- matrix(stats::runif(15)>.5, 5))
     ec_betadiversity(mat)

    ##       [,1]  [,2]  [,3]
    ## [1,] FALSE FALSE FALSE
    ## [2,]  TRUE FALSE  TRUE
    ## [3,]  TRUE FALSE FALSE
    ## [4,]  TRUE  TRUE  TRUE
    ## [5,] FALSE FALSE  TRUE
    ##    site1 site2        bc
    ## 1      1     2 1.0000000
    ## 2      1     3 1.0000000
    ## 3      1     4 1.0000000
    ## 4      1     5 1.0000000
    ## 5      2     3 0.3333333
    ## 6      2     4 0.2000000
    ## 7      2     5 0.3333333
    ## 8      3     4 0.5000000
    ## 9      3     5 1.0000000
    ## 10     4     5 0.5000000

### Rarefaction

    (mat <- matrix(stats::runif(40)>.2, 10))
    ec_rarefaction(mat, 6)

    ##        [,1]  [,2]  [,3] [,4]
    ##  [1,]  TRUE  TRUE  TRUE TRUE
    ##  [2,] FALSE  TRUE  TRUE TRUE
    ##  [3,] FALSE FALSE FALSE TRUE
    ##  [4,]  TRUE  TRUE  TRUE TRUE
    ##  [5,]  TRUE  TRUE  TRUE TRUE
    ##  [6,]  TRUE  TRUE FALSE TRUE
    ##  [7,]  TRUE  TRUE  TRUE TRUE
    ##  [8,]  TRUE FALSE  TRUE TRUE
    ##  [9,] FALSE  TRUE  TRUE TRUE
    ## [10,] FALSE  TRUE FALSE TRUE
    ##       [,1] [,2] [,3] [,4] [,5] [,6]
    ##  [1,]    4    4    3    4    3    3
    ##  [2,]    4    4    4    4    3    4
    ##  [3,]    4    4    4    4    4    4
    ##  [4,]    4    4    4    4    4    4
    ##  [5,]    4    4    4    4    4    4
    ##  [6,]    4    4    4    4    4    4
    ##  [7,]    4    4    4    4    4    4
    ##  [8,]    4    4    4    4    4    4
    ##  [9,]    4    4    4    4    4    4
    ## [10,]    4    4    4    4    4    4

### Temporal beta diversity

    (mat <- rbind(c(0,0,1), c(0,1,0)))
    ec_cooccurrence(mat, species_names = LETTERS[1:3])

    ##      [,1] [,2] [,3]
    ## [1,]    0    0    1
    ## [2,]    0    1    0
    ##   species1 species2 case_10 case_01 case_11 case_00 case_sp1 case_sp2
    ## 1        A        B       0       1       0       1        0        1
    ## 2        A        C       0       1       0       1        0        1
    ## 3        B        C       1       1       0       0        1        1

### Occurrence

    mat <- rbind(c(0,0,1), c(0,1,0))
    ec_cooccurrence(mat, species_names = LETTERS[1:3])

    ##   species1 species2 case_10 case_01 case_11 case_00 case_sp1 case_sp2
    ## 1        A        B       0       1       0       1        0        1
    ## 2        A        C       0       1       0       1        0        1
    ## 3        B        C       1       1       0       0        1        1
