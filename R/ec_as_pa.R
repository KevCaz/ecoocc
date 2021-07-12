#' Convert foreign object to a pa object
#'
#' Convert foreign object to a `pa` object.
#' 
#' @param x object to be converted into an object class `pa`.
#
#' @export

ec_as_pa <- function(x, ...) UseMethod("ec_as_pa")


#' @name ec_as_pa
#' @export

ec_as_pa.pa = function(x, ...) x

#' @name ec_as_pa
#' 
#' @param ... further arguments passed on to [ec_pa()].
#' @export

ec_as_pa.matrix <- function(x, ...) {
  
  ec_pa(x, ...)
  
}


