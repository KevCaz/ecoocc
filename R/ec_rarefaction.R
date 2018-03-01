#' @title Compute a rarefaction curve
#'
#' @description
#' Compute a rarefaction curve based on a presence-basence matrix.
#'
#' @author
#' Kevin Cazelles
#'
#' @param matpa presence absence matrix (sites as rows and species as columns).
#' @param nrep number of replicates.
#'
#' @importFrom magrittr %>%
#'
#' @return
#' A matrix with rarefaction replicates as rows.
#'
#' @references
#' Gotelli, Nicholas J., and Robert K. Colwell. Quantifying Biodiversity: Procedures and Pitfalls in the Measurement and Comparison of Species Richness. Ecology Letters (2001).
#'
#' @export

ec_rarefaction <- function(matpa, nrep = 100) {
    nr <- nrow(matpa)
    out <- matrix(0, nrep, nr)
    # cumsum on a matrix of 0 and 1 is a bunch of 0 until the first 1 which is
    # followed by a bunch of 1, quite helpful.
    for (i in 1:nrep) {
        out[i, ] <- matpa[sample(1:nr), -1L] %>% apply(2L, cumsum) %>% apply(1L, 
            function(x) sum(x > 0))
    }
    # 
    out
}
