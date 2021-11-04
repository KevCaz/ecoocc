# ecoocc

[![R CMD
Check](https://github.com/KevCaz/ecoocc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/KevCaz/ecoocc/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![codecov](https://codecov.io/gh/KevCaz/ecoocc/branch/master/graph/badge.svg?token=PahZ2gKXl2)](https://codecov.io/gh/KevCaz/ecoocc)

A Rcpp implementation of various computations done on presence/absence
matrices.

## Installation

The simplest way to install this packages is to use the
[`remotes`](https://CRAN.R-project.org/package=remotes) package

    install.package("remotes")
    remotes::install_github("KevCaz/ecoocc")

Once installed, load it and try it!

    library(ecoocc)

## What is implemented so far?

### Presence absence matrix

`ec_as_pa()` creates objects of class `pa`, there is a shortcut to
randomly generate object of class `pa` quickly, `ec_generate_pa()`.

    # a pa object of 10 and 5 species all species having a prensence probability of .4
    ec_generate_pa(10, 5, .4)

    ## ⚠ Empty site(s): 1, 2, 4

    ## ℹ Presence absence matrix: 10 sites, 5 species, 16 occurrences.

    ##        spc_1 spc_2 spc_3 spc_4 spc_5
    ## sit_01     0     0     0     0     0
    ## sit_02     0     0     0     0     0
    ## sit_03     1     0     0     0     0
    ## sit_04     0     0     0     0     0
    ## sit_05     1     0     1     1     0
    ## sit_06     0     0     1     0     0
    ## sit_07     1     1     0     1     0
    ## sit_08     0     1     1     0     0
    ## sit_09     0     0     1     0     0
    ## sit_10     1     1     1     1     1

### Beta diversity

    (mat <- ec_generate_pa(5, 3, .5))

    ## ⚠ Empty site(s): 1

    ## ℹ Presence absence matrix: 5 sites, 3 species, 9 occurrences.

    ec_betadiversity(mat)

    ##       spc_1 spc_2 spc_3
    ## sit_1     0     0     0
    ## sit_2     0     1     0
    ## sit_3     1     1     0
    ## sit_4     1     1     1
    ## sit_5     1     1     1
    ##    site1 site2        bc
    ## 1  sit_1 sit_2 1.0000000
    ## 2  sit_1 sit_3 1.0000000
    ## 3  sit_1 sit_4 1.0000000
    ## 4  sit_1 sit_5 1.0000000
    ## 5  sit_2 sit_3 0.3333333
    ## 6  sit_2 sit_4 0.5000000
    ## 7  sit_2 sit_5 0.5000000
    ## 8  sit_3 sit_4 0.2000000
    ## 9  sit_3 sit_5 0.2000000
    ## 10 sit_4 sit_5 0.0000000

### Rarefaction

    (mat <- ec_generate_pa(10, 4, .4))

    ## ⚠ Empty site(s): 6

    ## ℹ Presence absence matrix: 10 sites, 4 species, 12 occurrences.

    ec_rarefaction(mat, 6)

    ##        spc_1 spc_2 spc_3 spc_4
    ## sit_01     0     1     0     0
    ## sit_02     0     0     1     0
    ## sit_03     0     1     1     0
    ## sit_04     0     1     1     0
    ## sit_05     1     0     0     0
    ## sit_06     0     0     0     0
    ## sit_07     1     0     0     1
    ## sit_08     0     0     1     0
    ## sit_09     0     0     0     1
    ## sit_10     0     0     1     0
    ##       [,1] [,2] [,3] [,4] [,5] [,6]
    ##  [1,]    2    2    2    1    1    1
    ##  [2,]    2    3    2    2    1    3
    ##  [3,]    4    3    3    2    2    4
    ##  [4,]    4    4    4    3    3    4
    ##  [5,]    4    4    4    3    4    4
    ##  [6,]    4    4    4    4    4    4
    ##  [7,]    4    4    4    4    4    4
    ##  [8,]    4    4    4    4    4    4
    ##  [9,]    4    4    4    4    4    4
    ## [10,]    4    4    4    4    4    4

### Occurrence

    mat <- rbind(c(0,0,1), c(0,1,0))
    ec_cooc(ec_pa(mat))

    ## ⚠ No presence data for the following species: 1

    ## $cooc_count
    ##   species1 species2 case_10 case_01 case_11 case_00 case_spc1 case_spc2
    ## 1    spc_1    spc_2       0       1       0       1         0         1
    ## 2    spc_1    spc_3       0       1       0       1         0         1
    ## 3    spc_2    spc_3       1       1       0       0         1         1
    ## 
    ## $pairwise
    ##   species1 species2      zs_bi zs_hy binary_covariance mean_pairwise_index
    ## 1    spc_1    spc_2        NaN   NaN               0.0                 NaN
    ## 2    spc_1    spc_3        NaN   NaN               0.0                 NaN
    ## 3    spc_2    spc_3 -0.8164966    -1              -0.5                   0
    ##   mutual_information c_score_unit overlap_1_2 overlap_2_1 symmetry
    ## 1                Inf            0         NaN           0      NaN
    ## 2                Inf            0         NaN           0      NaN
    ## 3               0.25            1           0           0      NaN
    ## 
    ## $species
    ##   species presence entropy robustness sensitivity
    ## 1   spc_1      0.0     NaN          0         NaN
    ## 2   spc_2      0.5       1        NaN           0
    ## 3   spc_3      0.5       1        NaN           0
    ## 
    ## $global
    ##     c_score c_score_S2
    ## 1 0.3333333  0.3333333

## Related works

## R :package:

-   [`coocur`](https://CRAN.R-project.org/package=cooccur)
-   [`PresenceAbsence`](https://CRAN.R-project.org/package=PresenceAbsence)
-   [`EcoSimR`](https://CRAN.R-project.org/package=EcoSimR) (currently
    archived)

## Others

-   [PRESENCE](https://www.mbr-pwrc.usgs.gov/software/doc/presence/presence.html)
