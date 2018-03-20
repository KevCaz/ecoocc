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
#' @param test test to be performed, takes one values among \code{bi} and \code{hy} (see details).
#'
#' @details
#' Currently \code{bi} tests the presence of a significant value of occurrence
#' assuming species occurrence are independant binomial distribution. \code{by}
#' takes the limited number of sites into account by using an hypergeometric
#' distribution (see Veech 2013). Note that if the number of sites is large and
#' the occurrence of bith species relatively low, then \code{bi} and \code{hy}
#' give very similar results.
#'
#' @export
#'
#' @return
#' A matrix with species combination and co-occurrence values associated.
#'
#' @encoding latin1
#'
#' @references
#' Veech, Joseph A. “A Probabilistic Model for Analysing Species Co-Occurrence:
#' Probabilistic Model.” Edited by Pedro Peres-Neto. Global Ecology and
#' Biogeography 22, no. 2 (February 2013): 252–60. https://doi.org/10.1111/j.1466-8238.2012.00789.x.

#' @examples
#' mat <- matrix(stats::runif(60000)>.8,  ncol = 6)
#' out <- ec_cooccurrence(mat, test = c('ra', 've'))
#' plot(out$zs_raw*sqrt(0.8), out$zs_veech)
#' abline(0,1)

ec_cooccurrence <- function(mat_pa, test = NULL, species_names = NULL) {
    mat <- as.matrix(mat_pa) > 0
    stopifnot(ncol(mat) > 1)
    out <- cooccurrence_core(mat)
    # 
    if ("bi" %in% test) 
        out$zs_raw <- test_cooccurrence_binomial_core(out$case_sp1, out$case_sp2, 
            out$case_11, nrow(mat))
    if ("hy" %in% test) 
        out$zs_veech <- test_cooccurrence_hypergeometric_core(out$case_sp1, out$case_sp2, 
            out$case_11, nrow(mat))
    # 
    if (!is.null(species_names)) {
        stopifnot(length(species_names) == ncol(mat))
        out[1L] <- species_names[out[, 1L]]
        out[2L] <- species_names[out[, 2L]]
    }
    # 
    out
}
