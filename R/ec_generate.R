#' Generate random presence/absence matrix
#' 
#' @param nsit number of site (determine the number of rows).
#' @param nspc number of species (determine the number of columns). 
#' @param probs numeric vector of probabilities presence of species. If there 
#' are less elements than species, then the vector is recycled and if 
#' there are more, the vector is truncated (see [rep_len()])
#' @param ... further arguments passed on to [ec_pa()].
#'
#' @export
#'
#' @examples
#' ec_generate_pa(20, 10, .1)

ec_generate_pa <- function(nsit, nspc, probs, ...) {
  
  # quicker than a for loop 
  ec_as_pa(
    do.call(
      cbind, lapply(rep_len(probs, nspc), rbinom, n = nsit, size = 1)
    ),
    ...
  )
  
} 

#' @describeIn ec_generate_pa Returns 

#' @param x a `pa` object or an R object to a coerced to one (see [ec_as_pa()]). 
#' @param by dimension along which the `pa` object should be ordered, default is set to "both".
#' @param decreasing Should the sort order be increasing or decreasing? see [order()].
#'
#' @export
#'
#' @examples
#' ec_order_pa(ec_generate_pa(20, 10, .1))

ec_order_pa <- function(x, by = c("both", "site", "species"), 
  decreasing = TRUE) {
  
  x <- ec_as_pa(x)
  by <- match.arg(by)
  ec_as_pa(switch(
    by, 
    site = x[order_sum_pa(x, decreasing), ],
    species = x[, order_sum_pa(x, decreasing, 2)], 
    both = x[order_sum_pa(x, decreasing), order_sum_pa(x, decreasing, 2)] 
  ))
}

order_sum_pa <- function(x, decreasing, which = 1) {
  order(apply(x, which, sum), decreasing = decreasing)
}