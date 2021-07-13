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

### Presence absence matrix

`ec_as_pa()` creates objects of class `pa`, there is a shortcut to
randomly generate object of class `pa` quickly, `ec_generate_pa()`.

    # a pa object of 10 and 5 species all species having a prensence probability of .4
    ec_generate_pa(10, 5, .4)

    ## ℹ Presence absence matrix: 10 sites, 5 species, 17 occurrences.

    ##        spc_1 spc_2 spc_3 spc_4 spc_5
    ## sit_01     1     0     0     0     0
    ## sit_02     0     0     1     0     0
    ## sit_03     0     0     0     0     1
    ## sit_04     1     0     0     0     1
    ## sit_05     0     0     0     1     1
    ## sit_06     0     0     1     0     0
    ## sit_07     0     1     0     1     1
    ## sit_08     1     1     0     0     0
    ## sit_09     0     0     0     1     0
    ## sit_10     0     1     1     0     1

### Beta diversity

    (mat <- ec_generate_pa(5, 3, .5))

    ## ℹ Presence absence matrix: 5 sites, 3 species, 8 occurrences.

    ec_betadiversity(mat)

    ##       spc_1 spc_2 spc_3
    ## sit_1     1     0     0
    ## sit_2     1     0     1
    ## sit_3     0     1     1
    ## sit_4     1     1     0
    ## sit_5     1     0     0
    ##    site1 site2        bc
    ## 1  sit_1 sit_2 0.3333333
    ## 2  sit_1 sit_3 1.0000000
    ## 3  sit_1 sit_4 0.3333333
    ## 4  sit_1 sit_5 0.0000000
    ## 5  sit_2 sit_3 0.5000000
    ## 6  sit_2 sit_4 0.5000000
    ## 7  sit_2 sit_5 0.3333333
    ## 8  sit_3 sit_4 0.5000000
    ## 9  sit_3 sit_5 1.0000000
    ## 10 sit_4 sit_5 0.3333333

### Rarefaction

    (mat <- ec_generate_pa(10, 4, .4))

    ## ⚠ Empty site(s): 4, 9

    ## ℹ Presence absence matrix: 10 sites, 4 species, 20 occurrences.

    ec_rarefaction(mat, 6)

    ##        spc_1 spc_2 spc_3 spc_4
    ## sit_01     1     0     0     0
    ## sit_02     1     1     0     1
    ## sit_03     1     0     1     1
    ## sit_04     0     0     0     0
    ## sit_05     1     1     0     0
    ## sit_06     1     0     0     0
    ## sit_07     1     1     1     1
    ## sit_08     1     0     1     0
    ## sit_09     0     0     0     0
    ## sit_10     1     1     1     1
    ##       [,1] [,2] [,3] [,4] [,5] [,6]
    ##  [1,]    2    2    3    4    2    0
    ##  [2,]    2    2    3    4    4    0
    ##  [3,]    2    2    3    4    4    1
    ##  [4,]    4    2    4    4    4    4
    ##  [5,]    4    4    4    4    4    4
    ##  [6,]    4    4    4    4    4    4
    ##  [7,]    4    4    4    4    4    4
    ##  [8,]    4    4    4    4    4    4
    ##  [9,]    4    4    4    4    4    4
    ## [10,]    4    4    4    4    4    4

### Temporal beta diversity

    (mat <- rbind(c(0,0,1), c(0,1,0)))
    ec_cooccurrence(mat)

    ## ⚠ No presence data for the following species: 1

    ##      [,1] [,2] [,3]
    ## [1,]    0    0    1
    ## [2,]    0    1    0
    ##   species1 species2 case_10 case_01 case_11 case_00 case_spc1 case_spc2
    ## 1    spc_1    spc_2       0       1       0       1         0         1
    ## 2    spc_1    spc_3       0       1       0       1         0         1
    ## 3    spc_2    spc_3       1       1       0       0         1         1

### Occurrence

    mat <- rbind(c(0,0,1), c(0,1,0))
    ec_cooccurrence(mat)

    ## ⚠ No presence data for the following species: 1

    ##   species1 species2 case_10 case_01 case_11 case_00 case_spc1 case_spc2
    ## 1    spc_1    spc_2       0       1       0       1         0         1
    ## 2    spc_1    spc_3       0       1       0       1         0         1
    ## 3    spc_2    spc_3       1       1       0       0         1         1
