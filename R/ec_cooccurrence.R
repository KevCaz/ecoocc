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
#' @param test test to be performed. Currenlty \code{bi} and \code{hy}
#' are available (see details). Default is set to \code{NULL}, meaning
#' no test is performed.
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
#' Veech, J. A.. A Probabilistic Model for Analysing Species Co-Occurrence:
#' Probabilistic Model. Global Ecology and Biogeography (2013).

#' @examples
#' mat <- matrix(stats::runif(60000)>.2,  ncol = 6)
#' out <- ec_cooccurrence(mat, test = c('bi', 'hy'))
#' plot(out$zs_bi*sqrt(1/0.2), out$zs_hy)
#' abline(0,1)

ec_cooccurrence <- function(mat_pa, test = NULL, species_names = NULL) {
    mat <- as.matrix(mat_pa) > 0
    stopifnot(ncol(mat) > 1)
    out <- cooccurrence_core(mat)
    # 
    if ("bi" %in% test) 
        out$zs_bi <- test_cooccurrence_binomial_core(out$case_sp1, out$case_sp2, 
            out$case_11, nrow(mat))
    if ("hy" %in% test) 
        out$zs_hy <- test_cooccurrence_hypergeometric_core(out$case_sp1, out$case_sp2, 
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
