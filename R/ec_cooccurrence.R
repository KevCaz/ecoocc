#' @title Compute the co-occurrence between all pairs of species
#'
#' @description
#' Compute the co-occurrence between all pair of species.
#'
#' @author
#' Kevin Cazelles
#'
#' @param mat_pa presence absence matrix (sites as rows and species as columns).
#' @param species_names string vector giving the names of the sites. If
# , \code{NULL} a numerical sequence is used.
#'
#' @importFrom magrittr %>%
#' @export
#'
#' @return
#' A matrix with species combination and co-occurrence values associated.
#'
#' @examples
#' mat <- matrix(stats::runif(30)>.5, 10)
#' ec_cooccurrence(mat)

ec_cooccurrence <- function(mat_pa, species_names = NULL) {
    mat <- as.matrix(mat_pa) > 0
    stopifnot(ncol(mat) > 1)
    out <- cooccurrence_core(mat)
    # 
    if (!is.null(species_names)) {
        stopifnot(length(species_names) == ncol(mat))
        out[1L] <- species_names[out[, 1L]]
        out[2L] <- species_names[out[, 2L]]
    }
    # 
    out
}
