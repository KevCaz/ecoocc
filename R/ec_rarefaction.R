#' @title Compute a rarefaction curve
#'
#' @description
#' Compute a rarefaction curve based on a presence-basence matrix.
#'
#' @author
#' Kevin Cazelles
#'
#' @param mat_pa presence absence matrix (sites as rows and species as columns).
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
#' @importFrom crayon blue
#'
#' @examples
#' mat <- matrix(stats::runif(40)>.4, 10)
#' ec_rarefaction(mat, 10)

ec_rarefaction <- function(mat_pa, nrep = 20) {
    mat <- as.matrix(mat_pa) > 0
    stopifnot(nrow(mat) > 1)
    # 
    id <- which(!apply(mat, 2, sum))
    if (length(id)) 
        warning(blue(paste0("In column ", paste0(id, collapse = ", "), " => 0 presence detected!")))
    # 
    rarefaction_core(mat, nrep)
}
