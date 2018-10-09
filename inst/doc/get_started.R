## ----setup, echo = FALSE-------------------------------------------------
NOT_CRAN <- TRUE
# NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
knitr::opts_chunk$set(
  purl = NOT_CRAN,
  eval = NOT_CRAN,
  fig.align = "center",
  comment = "#> "
)

## ------------------------------------------------------------------------
mat <- matrix(stats::runif(40)>.4, 10)
ec_rarefaction(mat, 10)

