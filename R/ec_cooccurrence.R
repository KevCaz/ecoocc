#' @title Co-occurrence network
#'
#' @description
#' Compute the co-occurrence between all pairs of species and descriptive metrics of the co-occurrence network.
#'
#' @param x a `pa` object or an R object to a coerced to one (see [ec_as_pa()]). 
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
#' * Veech, J. A. (2013). A probabilistic model for analysing species co-occurrence: Probabilistic model. Global Ecology and Biogeography, 22(2), 252–260. 
#' * Arita, H. T. (2016). Species co-occurrence analysis: Pairwise versus matrix-level approaches: Correspondence. Global Ecology and Biogeography, 25(11), 1397–1400.

#' @examples
#' mat <- ec_generate_pa(1000, 6, .2)
#' out <- ec_cooc_count_pair(mat)
#' #plot(out$zs_bi*sqrt(1/0.2), out$zs_hy)
#' #abline(0,1)
#' 
#' @describeIn ec_cooc_count_pair A matrix with all pairs of species and the corresponding co-occurrence counts. 
#' 
#' @export
ec_cooc_count_pair <- function(x) {
  
    mat <- ec_as_pa(x)
    out <- cooccurrence_core(x)
    # 
    out[1L] <- colnames(mat)[out[, 1L]]
    out[2L] <- colnames(mat)[out[, 2L]]
    #
    structure(data.frame(out), class = c("cooc_count", "data.frame"))
}


#' @describeIn ec_cooc_count_pair  A matrix with all triplets of species and the corresponding co-occurrence counts. 
#'
#' @export
ec_cooc_count_triplet <- function(x) {
  
    mat <- ec_as_pa(x)
    stopifnot(ncol(mat) > 2)
    cooccurrence_triplet_core(mat)
    
    out[1L] <- colnames(mat)[out[, 1L]]
    out[2L] <- colnames(mat)[out[, 2L]]
    out[3L] <- colnames(mat)[out[, 3L]]
    
    structure(data.frame(out), class = c("cooc_count_triplet", "data.frame"))

}




#' @describeIn ec_cooc_count_pair Compute the checkerboard score and return a list of three elements: 
#' * `units` which incudes checkerboard units and t
#' * `c_score` checkerboard scores.
#' * `c_score_s2` the S2 statistics in Roberts & Stone (1990).
#'
#' @references
#' * Stone, L., & Roberts, A. (1990). The checkerboard score and species distributions. Oecologia, 85(1), 74–79. https://doi.org/10.1007/BF00317345
#' * Roberts, A., & Stone, L. (1990). Island-sharing by archipelago species. Oecologia, 83(4), 560–567. https://doi.org/10.1007/BF00317210
#'
#' @export
#' @examples
#' # Classical example, in Stone & Roberts 1990
#' mat0 <- matrix(0, 10, 10)
#' mat1 <- matrix(1, 10, 10)
#' matU <- rbind(cbind(mat1, mat0), cbind(mat0, mat1))
#' ec_checkerboard(matU)

ec_checkerboard <- function(x) {
  mat <- ec_as_pa(x)
  coo <- cooccurrence_core(x)

  cun <- (coo[, 7] - coo[, 5]) * (coo[, 8] - coo[, 5])
  
  list(
    c_units = data.frame(coo[, 1:2], c_units = cun),
    c_score = sum(cun) / nrow(coo),
    c_score_s2 = sum(cun * cun) / nrow(coo)
  )
}




#' Co_cccurence analysis 
#'
#' Co_cccurence analysis 
#' 
#' @param x object to be converted into an object class `pa`.
#' @param ... ignored.
#' 
#' @export

ec_cooc <- function(x, ...) UseMethod("ec_cooc")


#' @name ec_cooc
#' @export

ec_cooc.pa <- function(x, ...) {
  coo <- ec_cooc_count_pair(x)
  ec_cooc(coo, nrow(x), ...)
} 


#' @name ec_cooc
#' @export

ec_cooc.cooc_count <- function(x, nsit, ...) {
  list(
    cooc_count = x,
    pairwise = ec_cooc_pairwise(x, nsit, ...),
    species = ec_cooc_species(x, nsit, ...),
    global = ec_cooc_global(x, nsit, ...)
  )
} 


#' @param x object to be converted into an object class `pa`.
#' @param ... ignored.
#' 
#' @describeIn ec_cooc Return a matrix of cooccurrence metrics for pair of species.
#' 
#' @export

ec_cooc_pairwise <- function(x, ...) UseMethod("ec_cooc_pairwise")


#' @name ec_cooc
#' @export

ec_cooc_pairwise.pa <- function(x, ...) {
  ec_cooc_pairwise(ec_cooc_count_pair(x), nsit = nrow(x), ...)
}


#' @name ec_cooc
#' @param nsit number of sites.
#' @export

ec_cooc_pairwise.cooc_count <- function(x, nsit, ...) {
  o12 <- x$case_11 / x$case_spc1
  o21 <- x$case_11 / x$case_spc2
  sim <- abs(o12 - o21) / max(o12, o21)
  
  ovl <- cbind(
    x[, 1:2],
    data.frame(
      zs_bi = cooc_zscore_binomial_core(x$case_spc1, x$case_spc2, x$case_11, nsit),
      zs_hy = cooc_zscore_hypergeom_core(x$case_spc1, x$case_spc2, x$case_11, nsit),
      c_score_unit = (x$case_spc1 - x$case_11) * (x$case_spc2 - x$case_11),
      bc = (x$case_11*x$case_00 - x$case_10*x$case_01) / (nsit*(nsit-1)),
      mpi = x$case_11/min(x$case_01, x$case_10),
      overlap_1_2 = o12,
      overlap_2_1 = o21,
      symmetry = sim
    )
  )
}



#' @describeIn ec_cooc Return a matrix of cooccurrence metrics for species.
#' 
#' @export

ec_cooc_species <- function(x, ...) UseMethod("ec_cooc_species")


#' @name ec_cooc
#' @export

ec_cooc_species.pa <- function(x, ...) {
  ec_cooc_species(ec_cooc_count_pair(x), nsit = nrow(x), ...)
}


#' @name ec_cooc
#' @export

ec_cooc_species.cooc_count <- function(x, nsit, ...) {
  # pw <- ec_cooc_pairwise(x, nsit = nsit, ...)
  unq <- unique(unlist(x[, 1:2]))
  ctb <- do.call(rbind, lapply(unq, sinsout, coo = x))
  
  data.frame(species = unq, ctb)
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



#' @describeIn ec_cooc Return a matrix of cooccurrence metrics for species.
#' @export

ec_cooc_global <- function(x, ...) UseMethod("ec_cooc_global")


#' @name ec_cooc
#' @export

ec_cooc_global.pa <- function(x, ...) {
  ec_cooc_global(ec_cooc_count_pair(x), nsit = nrow(x), ...)
}


#' @name ec_cooc
#' @export

ec_cooc_global.cooc_count <- function(x, nsit, ...) {
  pw <- ec_cooc_pairwise(x, nsit = nsit, ...)
  data.frame(
    c_score = sum(pw$c_score_unit) / nsit,
    c_score_S2 = sum(pw$c_score_unit*pw$c_score_unit) / nsit 
  )
}


# number of species given the number of row in cooc_count
# solve x^2-x-2nrow = 0 
# only positive solution
nspc_from_nrow_cooc <- function(nr) {
  (1 + sqrt(1 +8*nr))/2
}