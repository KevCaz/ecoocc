#' Compute beta diversity
#'
#' @description
#' Compute the beta diversity between all pairs of sites for a specific
#' presence-absence matrix.
#'
#' @param x a `pa` object or an R object to a coerced to one (see [ec_as_pa()]). 
#' @param methods a vector of two-letters strings describing the methods te be used.
#' Values should be taken among `ra`, `bc`, `wi` and `ja` (see details).
#'
#' @details
#' Currently `ra` stands for raw and returns the number of occurrence. 
#' Additional values are
#' - `bc`: Bray-Curtis index,
#' - `wi`: Wishart index,
#' - `ja`: Jaccard index.
#'
#' @return
#' A matrix with all the combinaisons of sites and the corresponding betadiversity.
#'
#' @references
#' * Legendre, P., and De Caceres M.. Beta Diversity as the Variance of Community
#'      Data: Dissimilarity Coefficients and Partitioning. Ecology Letters (2013).
#' * Koleff, P., Gaston, K. J. & Lennon, J. J. Measuring beta diversity for presence-absence data. Journal of Animal Ecology (2003).
#' 
#'
#' @examples
#' mat <- ec_generate_pa(20, 10, .4)
#' ec_betadiversity(mat)
#'
#' @export

ec_betadiversity <- function(x, methods = "bc") {
  
    mat <- ec_as_pa(x)
    stopifnot(any(methods %in% c("ra", "bc", "wi", "ja")))
    raw <- betadiversity_core(mat)
    # 
    if ("ra" %in% methods) out <- raw else out <- raw[, 1L:2L]
    # 
    out[1L] <- rownames(mat)[out[, 1L]]
    out[2L] <- rownames(mat)[out[, 2L]]
    # 
    tmp <- raw[, 3L:6L]
    tmp_ab <- tmp[, 1L] + tmp[, 2L]
    # 
    if ("bc" %in% methods) {
        out$bc <- tmp_ab/(tmp_ab + tmp[, 3L] + tmp[, 3L])
    }
    if ("wi" %in% methods) {
        out$wi <- tmp_ab/(tmp_ab + tmp[, 3L])
    }
    if ("ja" %in% methods) {
        out$ja <- tmp[, 3L]/(tmp_ab + tmp[, 3L])
    }
    
    out
}
