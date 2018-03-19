ecoocc
======

Status
------

[![Build
Status](https://travis-ci.org/KevCaz/ecoocc.svg?branch=master)](https://travis-ci.org/KevCaz/ecoocc)
[![Build
status](https://ci.appveyor.com/api/projects/status/qeywntin8yma0jb0?svg=true)](https://ci.appveyor.com/project/KevCaz/ecoocc)

Installation
------------

    devtools::install_github("KevCaz/ecoocc")

What is implemented so far?
---------------------------

### betadiversity (Rcpp)

     (mat <- matrix(stats::runif(20)>.5, 10))
     ec_betadiversity(mat)

    ##        [,1]  [,2]
    ##  [1,] FALSE FALSE
    ##  [2,] FALSE FALSE
    ##  [3,] FALSE  TRUE
    ##  [4,] FALSE  TRUE
    ##  [5,]  TRUE FALSE
    ##  [6,] FALSE  TRUE
    ##  [7,]  TRUE  TRUE
    ##  [8,] FALSE  TRUE
    ##  [9,] FALSE FALSE
    ## [10,]  TRUE FALSE
    ##    site1 site2        bc
    ## 1      1     2       NaN
    ## 2      1     3 1.0000000
    ## 3      1     4 1.0000000
    ## 4      1     5 1.0000000
    ## 5      1     6 1.0000000
    ## 6      1     7 1.0000000
    ## 7      1     8 1.0000000
    ## 8      1     9       NaN
    ## 9      1    10 1.0000000
    ## 10     2     3 1.0000000
    ## 11     2     4 1.0000000
    ## 12     2     5 1.0000000
    ## 13     2     6 1.0000000
    ## 14     2     7 1.0000000
    ## 15     2     8 1.0000000
    ## 16     2     9       NaN
    ## 17     2    10 1.0000000
    ## 18     3     4 0.0000000
    ## 19     3     5 1.0000000
    ## 20     3     6 0.0000000
    ## 21     3     7 0.3333333
    ## 22     3     8 0.0000000
    ## 23     3     9 1.0000000
    ## 24     3    10 1.0000000
    ## 25     4     5 1.0000000
    ## 26     4     6 0.0000000
    ## 27     4     7 0.3333333
    ## 28     4     8 0.0000000
    ## 29     4     9 1.0000000
    ## 30     4    10 1.0000000
    ## 31     5     6 1.0000000
    ## 32     5     7 0.3333333
    ## 33     5     8 1.0000000
    ## 34     5     9 1.0000000
    ## 35     5    10 0.0000000
    ## 36     6     7 0.3333333
    ## 37     6     8 0.0000000
    ## 38     6     9 1.0000000
    ## 39     6    10 1.0000000
    ## 40     7     8 0.3333333
    ## 41     7     9 1.0000000
    ## 42     7    10 0.3333333
    ## 43     8     9 1.0000000
    ## 44     8    10 1.0000000
    ## 45     9    10 1.0000000

### rarefaction (Rcpp)

    (mat <- matrix(stats::runif(20)>.5, 5))
    ec_rarefaction(mat, 6)

    ##       [,1]  [,2]  [,3]  [,4]
    ## [1,]  TRUE  TRUE FALSE  TRUE
    ## [2,]  TRUE  TRUE FALSE  TRUE
    ## [3,]  TRUE FALSE  TRUE FALSE
    ## [4,] FALSE  TRUE FALSE FALSE
    ## [5,] FALSE FALSE  TRUE FALSE
    ##      [,1] [,2] [,3] [,4] [,5] [,6]
    ## [1,]    1    1    1    1    1    1
    ## [2,]    4    4    2    4    4    4
    ## [3,]    4    4    3    4    4    4
    ## [4,]    4    4    4    4    4    4
    ## [5,]    4    4    4    4    4    4

-   temporal betadiversity (Rcpp)

-   occurrence (Rcpp)
