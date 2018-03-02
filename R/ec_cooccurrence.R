#' @title Co-occurrence
#'
#' @description
#' Compute the co-occurrence between all pairs of species.
#'
#' @author
#' Kevin Cazelles
#'
#' @param mat_pa presence absence matrix (sites as rows and species as columns).
#' @param species_names string vector giving the names of the sites. If
# , \code{NULL} a numerical sequence is used.
#' @param test test to be performed, takes one values among \code{ra} and \code{ve}.
#'
#' @export
#'
#' @return
#' A matrix with species combination and co-occurrence values associated.
#'
#' @examples
#' mat <- matrix(stats::runif(60000)>.4,  ncol = 6)
#' out <- ec_cooccurrence(mat, test = c('ra', 've'))

ec_cooccurrence <- function(mat_pa, species_names = NULL, test = NULL) {
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
    if ("ra" %in% test) 
        out$zs_raw <- test_cooccurrence_raw_core(out$case_sp1, out$case_sp2, out$case_11, 
            nrow(mat))
    if ("ve" %in% test) 
        out$zs_veech <- test_cooccurrence_veech_core(out$case_sp1, out$case_sp1, 
            out$case_11, nrow(mat))
    # 
    out
}
