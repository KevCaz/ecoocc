#' Generate random presence/absence matrix
#' 
#' @param nst site number (determine the number of rows).
#' @param nsp number of species (determine the number of columns). 
#' @param probs numeric vector of probabilities presence of species. If there are less elements than species, then the vector is recycled and if there are more, the vector is truncated (see [rep_len()])
#' @param ... further arguments passed on to [ec_pa()].
#'
#' @export
#'
#' @examples
#' ec_generate(20, 10, .1)

ec_generate <- function(nst, nsp, probs, ...) {
  
  # quicker than a for loop 
  ec_as_pa(
    do.call(
      cbind, lapply(rep_len(probs, nsp), rbinom, n = nst, size = 1)
    ),
    ...
  )
  
} 


# ec_shuffle <- function(nrep)