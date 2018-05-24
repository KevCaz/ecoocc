ecoocc
======

A Rcpp implementation of various computations done on presence/absence
matrices.

Status
------

[![Build
Status](https://travis-ci.org/KevCaz/ecoocc.svg?branch=master)](https://travis-ci.org/KevCaz/ecoocc)
[![Build
status](https://ci.appveyor.com/api/projects/status/qeywntin8yma0jb0?svg=true)](https://ci.appveyor.com/project/KevCaz/ecoocc)
[![codecov](https://codecov.io/gh/KevCaz/ecoocc/branch/master/graph/badge.svg)](https://codecov.io/gh/KevCaz/ecoocc)

Installation
------------

    devtools::install_github("KevCaz/ecoocc")

What is implemented so far?
---------------------------

### Beta diversity

     (mat <- matrix(stats::runif(15)>.5, 5))
     ec_betadiversity(mat)

    ##       [,1]  [,2]  [,3]
    ## [1,] FALSE FALSE FALSE
    ## [2,]  TRUE FALSE  TRUE
    ## [3,] FALSE FALSE FALSE
    ## [4,]  TRUE  TRUE FALSE
    ## [5,] FALSE FALSE FALSE
    ##    site1 site2  bc
    ## 1      1     2 1.0
    ## 2      1     3 NaN
    ## 3      1     4 1.0
    ## 4      1     5 NaN
    ## 5      2     3 1.0
    ## 6      2     4 0.5
    ## 7      2     5 1.0
    ## 8      3     4 1.0
    ## 9      3     5 NaN
    ## 10     4     5 1.0

### Rarefaction

    (mat <- matrix(stats::runif(40)>.2, 10))
    ec_rarefaction(mat, 6)

    ##       [,1]  [,2]  [,3]  [,4]
    ##  [1,] TRUE  TRUE  TRUE FALSE
    ##  [2,] TRUE  TRUE  TRUE  TRUE
    ##  [3,] TRUE FALSE  TRUE FALSE
    ##  [4,] TRUE FALSE  TRUE  TRUE
    ##  [5,] TRUE  TRUE  TRUE FALSE
    ##  [6,] TRUE  TRUE  TRUE  TRUE
    ##  [7,] TRUE  TRUE  TRUE FALSE
    ##  [8,] TRUE  TRUE  TRUE  TRUE
    ##  [9,] TRUE  TRUE  TRUE  TRUE
    ## [10,] TRUE  TRUE FALSE  TRUE
    ##       [,1] [,2] [,3] [,4] [,5] [,6]
    ##  [1,]    4    3    3    3    4    4
    ##  [2,]    4    4    4    3    4    4
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
