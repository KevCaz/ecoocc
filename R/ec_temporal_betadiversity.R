#' @title Compute temporal betadiversity
#'
#' @description
#' Compute temporal betadiversity.
#'
#' @param x1 a `pa` object representing a presence-absence matrix at time 1.
#' @param x2 a `pa` object representing a presence-absence matrix at time 2.
#' @param methods a vector of two-letters strings describing the methods te be used.
#' Vaues should be taken among `ra`, `bc`, `ja`, `wi` (see details).
#' @param site_names string vector giving the names of the sites.
#'
#' @details
#' Currently `ra` stands for raw and returns the number of occurrence.
#' Additionnalnnal values are
#' - `bc`: Bray-Curtis index,
#' - `wi`: Wishart index,
#' - `ja`: Jaccard index.
#'
#' @return
#' A data frame with desired output as columns.
#'
#' @examples
#' ec_temporal_betadiversity(rbind(c(1, 0), c(1, 1)), rbind(c(0, 1), c(1, 1)))
#'
#' @export

ec_temporal_betadiversity <- function(x1, x2, methods = "bc", site_names = NULL) {
    mat1 <- ec_as_pa(x1)
    mat2 <- ec_as_pa(x2)
    stopifnot(all(dim(mat1) == dim(mat2)))
    stopifnot(any(methods %in% c("ra", "bc", "wi", "ja")))
    # 
    raw <- temporal_beta_core(mat1, mat2)
    # 
    if ("ra" %in% methods) 
        out <- raw else out <- raw[1L]
    # 
    if (!is.null(site_names)) {
        stopifnot(length(site_names) == nrow(mat1))
        out[1L] <- site_names[out[, 1L]]
    }
    # 
    tmp <- raw[, 2L:5L]
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
