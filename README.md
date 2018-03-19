ecoocc
======

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

### betadiversity (Rcpp)

     (mat <- matrix(stats::runif(20)>.5, 10))
     ec_betadiversity(mat)

    ##        [,1]  [,2]
    ##  [1,]  TRUE FALSE
    ##  [2,]  TRUE FALSE
    ##  [3,] FALSE FALSE
    ##  [4,]  TRUE  TRUE
    ##  [5,]  TRUE  TRUE
    ##  [6,]  TRUE FALSE
    ##  [7,] FALSE  TRUE
    ##  [8,] FALSE FALSE
    ##  [9,]  TRUE  TRUE
    ## [10,] FALSE FALSE
    ##    site1 site2        bc
    ## 1      1     2 0.0000000
    ## 2      1     3 1.0000000
    ## 3      1     4 0.3333333
    ## 4      1     5 0.3333333
    ## 5      1     6 0.0000000
    ## 6      1     7 1.0000000
    ## 7      1     8 1.0000000
    ## 8      1     9 0.3333333
    ## 9      1    10 1.0000000
    ## 10     2     3 1.0000000
    ## 11     2     4 0.3333333
    ## 12     2     5 0.3333333
    ## 13     2     6 0.0000000
    ## 14     2     7 1.0000000
    ## 15     2     8 1.0000000
    ## 16     2     9 0.3333333
    ## 17     2    10 1.0000000
    ## 18     3     4 1.0000000
    ## 19     3     5 1.0000000
    ## 20     3     6 1.0000000
    ## 21     3     7 1.0000000
    ## 22     3     8       NaN
    ## 23     3     9 1.0000000
    ## 24     3    10       NaN
    ## 25     4     5 0.0000000
    ## 26     4     6 0.3333333
    ## 27     4     7 0.3333333
    ## 28     4     8 1.0000000
    ## 29     4     9 0.0000000
    ## 30     4    10 1.0000000
    ## 31     5     6 0.3333333
    ## 32     5     7 0.3333333
    ## 33     5     8 1.0000000
    ## 34     5     9 0.0000000
    ## 35     5    10 1.0000000
    ## 36     6     7 1.0000000
    ## 37     6     8 1.0000000
    ## 38     6     9 0.3333333
    ## 39     6    10 1.0000000
    ## 40     7     8 1.0000000
    ## 41     7     9 0.3333333
    ## 42     7    10 1.0000000
    ## 43     8     9 1.0000000
    ## 44     8    10       NaN
    ## 45     9    10 1.0000000

### rarefaction (Rcpp)

    (mat <- matrix(stats::runif(40)>.4, 10))
    ec_rarefaction(mat, 6)

    ##        [,1]  [,2]  [,3]  [,4]
    ##  [1,]  TRUE FALSE FALSE  TRUE
    ##  [2,]  TRUE FALSE  TRUE  TRUE
    ##  [3,] FALSE  TRUE  TRUE FALSE
    ##  [4,]  TRUE  TRUE  TRUE  TRUE
    ##  [5,]  TRUE  TRUE  TRUE  TRUE
    ##  [6,]  TRUE  TRUE  TRUE FALSE
    ##  [7,]  TRUE FALSE FALSE  TRUE
    ##  [8,]  TRUE  TRUE  TRUE FALSE
    ##  [9,]  TRUE  TRUE  TRUE  TRUE
    ## [10,] FALSE  TRUE  TRUE  TRUE
    ##       [,1] [,2] [,3] [,4] [,5] [,6]
    ##  [1,]    3    2    3    2    3    4
    ##  [2,]    3    4    4    4    4    4
    ##  [3,]    4    4    4    4    4    4
    ##  [4,]    4    4    4    4    4    4
    ##  [5,]    4    4    4    4    4    4
    ##  [6,]    4    4    4    4    4    4
    ##  [7,]    4    4    4    4    4    4
    ##  [8,]    4    4    4    4    4    4
    ##  [9,]    4    4    4    4    4    4
    ## [10,]    4    4    4    4    4    4

-   temporal betadiversity (Rcpp)

-   occurrence (Rcpp)
