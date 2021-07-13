#' @title Co-occurrence network
#'
#' @description
#' Compute the co-occurrence between all pairs of species and descriptive metrics of the co-occurrence network.
#'
#' @param x a `pa` object or an R object to a coerced to one (see [ec_as_pa()]). 
#' @param test test to be performed. Currently `bi` and `hy`
#' are available (see details). Default is set to `NULL`, meaning that
#' no test is performed.
#'
#' @details
#' Currently `bi` tests the presence of a significant value of occurrence
#' assuming species occurrence are independent binomial distribution. `by`
#' takes the limited number of sites into account by using an hypergeometric
#' distribution (see Veech 2013). Note that if the number of sites is large and
#' the occurrence of both species relatively low, then `bi` and `hy`
#' give very similar results.
#'
#' @references
#' * Veech, J. A.. A Probabilistic Model for Analysing Species Co-Occurrence:
#' Probabilistic Model. Global Ecology and Biogeography (2013).

#' @examples
#' mat <- ec_generate(1000, 6, .2)
#' out <- ec_cooccurrence(mat, test = c('bi', 'hy'))
#' plot(out$zs_bi*sqrt(1/0.2), out$zs_hy)
#' abline(0,1)

#' @describeIn ec_cooccurrence A matrix with species combination and co-occurrence values associated.

#' @export
ec_cooccurrence <- function(x, test = NULL) {
  
    mat <- ec_as_pa(x)
    out <- cooccurrence_core(mat)
    # 
    if ("bi" %in% test) 
        out$zs_bi <- test_cooc_binomial_core(out$case_sp1, out$case_sp2, out$case_11, 
            nrow(mat))
    if ("hy" %in% test) 
        out$zs_hy <- test_cooc_hypergeom_core(out$case_sp1, out$case_sp2, out$case_11, 
            nrow(mat))
    # 
    out[1L] <- colnames(mat)[out[, 1L]]
    out[2L] <- colnames(mat)[out[, 2L]]
    # 
    out
}


#' @describeIn ec_cooccurrence Return a list of two elements: 
#' * `overlap` which incudes overlaps for all pairs of species and the degree of symmetry (as described in Araujo 2011)
#' * `network_contribution` that includes the species contributions to network robustness, `robustness`, and the species sensitivity to the loss of links in the network, `sensitivity` (see Araujo 2011).
#'
#' @references
#' * Araujo, M. B., Rozenfeld, A., Rahbek, C., & Marquet, P. A. (2011). Using species co-occurrence networks to assess the impacts of climate change. Ecography, 34(6), 897–908. https://doi.org/10.1111/j.1600-0587.2011.06919.x
#' * Griffith, G. P., Strutton, P. G., & Semmens, J. M. (2018). Climate change alters stability and species potential interactions in a large marine ecosystem. Global Change Biology, 24(1), e90–e100. https://doi.org/10.1111/gcb.13891
#'
#' @export
#' @examples
#' mat <- ec_overlap(ec_generate(100, 10, .2))

ec_overlap <- function(x) {
  coo <- ec_cooccurrence(x)
  o12 <- coo[, 5] / coo[, 7]
  o21 <- coo[, 5] / coo[, 8]
  sim <- abs(o12 - o21) / max(o12, o21)
  
  ovl <- cbind(
    coo[, 1:2],
    data.frame(
      overlap_1_2 = o12,
      overlap_2_1 = o21,
      symmetry = sim 
    )
  )
  
  unq <- unique(unlist(coo[, 1:2]))
  ctb <- do.call(rbind, lapply(unq, sinsout, coo = coo))
  
  list(
    overlap = ovl,
    network_contribution = data.frame(species = unq, ctb)  
  )
}


# Compute Robustness (sin) and sensitivity (sout)
sinsout <- function(id, coo) {
  tmp1 <- coo[coo[1] == id, ]
  tmp2 <- coo[coo[2] == id, ]
  c(
    robustness = sum(tmp1[, 5] / tmp1[, 7]) + sum(tmp2[, 5] / tmp2[, 6]),
    sensitivity = sum(tmp1[, 5] / tmp1[, 6]) + sum(tmp2[, 5] / tmp2[, 7])
  )
}



#' @describeIn ec_cooccurrence Return a list of two elements: 
#' * `units` which incudes checkerboard units. 
#' * `c_score` checkerboard scores.
#'
#' @references
#' * Stone, L., & Roberts, A. (1990). The checkerboard score and species distributions. Oecologia, 85(1), 74–79. https://doi.org/10.1007/BF00317345
#'
#' @export
#' @examples
#' mat <- ec_checkerboard(ec_generate(100, 10, .2))

ec_checkerboard <- function(x) {
  coo <- ec_cooccurrence(x)

  cun <- (coo[, 7] - coo[, 5]) * (coo[, 8] - coo[, 5])
  
  list(
    units = data.frame(coo[, 1:2], c_units = cun),
    c_score = sum(cun) / nrow(coo)
  )
}
