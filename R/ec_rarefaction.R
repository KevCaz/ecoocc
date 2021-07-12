#' @title Compute a rarefaction curve
#'
#' @description
#' Compute a rarefaction curve based on a presence-absence matrix.
#'
#' @param x presence absence matrix (sites as rows and species as columns).
#' @param nrep number of replicates.
#'
#' @return
#' A matrix with rarefaction replicates as rows.
#'
#' @references
#' Gotelli, N. J., and Robert K. C.. Quantifying Biodiversity: Procedures and Pitfalls in the Measurement and Comparison of Species Richness. Ecology Letters (2001).
#'
#' @export
#'
#' @examples
#' mat <- ec_generate(20, 10, .4)
#' res <- ec_rarefaction(mat, 1000)
#' plot(apply(res, 1, mean))

ec_rarefaction <- function(x, nrep = 100) {
    mat <- ec_as_pa(x)
    rarefaction_core(mat, nrep)
}
