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
    ##  [1,] FALSE  TRUE
    ##  [2,] FALSE FALSE
    ##  [3,]  TRUE  TRUE
    ##  [4,] FALSE FALSE
    ##  [5,] FALSE  TRUE
    ##  [6,] FALSE FALSE
    ##  [7,]  TRUE FALSE
    ##  [8,] FALSE  TRUE
    ##  [9,] FALSE  TRUE
    ## [10,]  TRUE  TRUE
    ##    site1 site2        bc
    ## 1      1     2 1.0000000
    ## 2      1     3 0.3333333
    ## 3      1     4 1.0000000
    ## 4      1     5 0.0000000
    ## 5      1     6 1.0000000
    ## 6      1     7 1.0000000
    ## 7      1     8 0.0000000
    ## 8      1     9 0.0000000
    ## 9      1    10 0.3333333
    ## 10     2     3 1.0000000
    ## 11     2     4       NaN
    ## 12     2     5 1.0000000
    ## 13     2     6       NaN
    ## 14     2     7 1.0000000
    ## 15     2     8 1.0000000
    ## 16     2     9 1.0000000
    ## 17     2    10 1.0000000
    ## 18     3     4 1.0000000
    ## 19     3     5 0.3333333
    ## 20     3     6 1.0000000
    ## 21     3     7 0.3333333
    ## 22     3     8 0.3333333
    ## 23     3     9 0.3333333
    ## 24     3    10 0.0000000
    ## 25     4     5 1.0000000
    ## 26     4     6       NaN
    ## 27     4     7 1.0000000
    ## 28     4     8 1.0000000
    ## 29     4     9 1.0000000
    ## 30     4    10 1.0000000
    ## 31     5     6 1.0000000
    ## 32     5     7 1.0000000
    ## 33     5     8 0.0000000
    ## 34     5     9 0.0000000
    ## 35     5    10 0.3333333
    ## 36     6     7 1.0000000
    ## 37     6     8 1.0000000
    ## 38     6     9 1.0000000
    ## 39     6    10 1.0000000
    ## 40     7     8 1.0000000
    ## 41     7     9 1.0000000
    ## 42     7    10 0.3333333
    ## 43     8     9 0.0000000
    ## 44     8    10 0.3333333
    ## 45     9    10 0.3333333

-   temporal betadiversity (Rcpp)
-   rarefaction (R)
-   occurrence (Rcpp)
