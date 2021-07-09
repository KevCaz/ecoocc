#' @title Compute a rarefaction curve
#'
#' @description
#' Compute a rarefaction curve based on a presence-absence matrix.
#'
#'
#' @param mat_pa presence absence matrix (sites as rows and species as columns).
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
#' res <- ec_rarefaction(mat, 100)
#' plot(apply(res, 1, mean))

ec_rarefaction <- function(mat_pa, nrep = 20) {
    mat <- as.matrix(mat_pa) > 0
    stopifnot(nrow(mat) > 1)
    #
    id <- which(!apply(mat, 2, sum))
    if (length(id))
        msgWarning(
          "Species never present in column(s)",
          paste0(id, collapse = ", ")
        )
    #
    rarefaction_core(mat, nrep)
}
