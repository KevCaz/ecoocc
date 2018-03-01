#' @title Compute the beta diversity between all sites
#'
#' @description
#' Compute the beta diversity between all sites for a specific
#' presence-absence matrix.
#'
#' @author
#' Kevin Cazelles
#'
#' @param mat_pa presence absence matrix (sites as rows and species as columns).
#' @param methods a vector of two-letters strings describing the methods te be used.
#' Values should be taken among \code{ra}, \code{bc}, \code{wi} (see details).
#' @param site_names string vector giving the names of the sites. If \code{NULL} a numerical sequence is used.
#'
#' @importFrom magrittr %>%
#'
#' @return
#' A matrix with all the combinaison of site and the associated betadiv.
#'
#' @details
#' Currently \code{ra} stands fpr raw and return the number of occurrence for
#' the for scenarion (A, B, C, D). \code{bc} Bray-Curtis and \code{wi}
#' Wishart.
#'
#' @encoding latin1
#'
#' @references
#' Legendre, Pierre, and Miquel De Cáceres. Beta Diversity as the Variance of Community Data: Dissimilarity Coefficients and Partitioning. Ecology Letters (2013)
#' Koleff, P., Gaston, K. J. & Lennon, J. J. Measuring beta diversity for presence-absence data. Journal of Animal Ecology (2003).
#'
#' @examples
#' mat <- matrix(stats::runif(20)>.5, 10)
#' ec_betadiversity(mat)
#'
#' @export

ec_betadiversity <- function(mat_pa, methods = "bc", site_names = NULL) {
    mat <- as.matrix(mat_pa) > 0
    raw <- betadiversity_core(mat)
    # 
    if ("ra" %in% methods) {
        out <- raw
    } else {
        out <- raw[, 1L:2L]
    }
    # 
    if (!is.null(site_names)) {
        stopifnot(length(site_names) == nrow(mat_pa))
        out[1L] <- site_names[out[, 1L]]
        out[2L] <- site_names[out[, 2L]]
    }
    # 
    tmp <- raw[, 3L:6L]
    if ("bc" %in% methods) {
        out$bc <- (tmp[, 1L] + tmp[, 2L])/(tmp[, 1L] + tmp[, 2L] + tmp[, 3L] + tmp[, 
            3L])
    }
    if ("wi" %in% methods) {
        out$wi <- (tmp[, 1L] + tmp[, 2L])/(tmp[, 1L] + tmp[, 2L] + tmp[, 3L])
    }
    
    out
}
