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

ec_as_pa.pa <- function(x, ...) x

#' @name ec_as_pa
#'
#' @param ... further arguments passed on to [ec_pa()].
#' @export

ec_as_pa.matrix <- function(x, ...) {
  ec_pa(x, ...)
}


#' Print method for pa object
#'
#' Print method for pa object.
#'
#' @param x object of `pa`.
#' @param max_sit maximum number of sites to be printed.
#' @param max_spc maximum number of species to be printed.
#' @param ... ignored.
#'
#' @method print pa
#' @export

print.pa <- function(x, ..., max_sit = 10, max_spc = max_sit) {
  cli::cli_alert_info(c(
    "Presence absence matrix: {nrow(x)} site{?s}, ",
    "{ncol(x)} specie{?s}, {sum(x)} occurrence{?s}."
  ))
  print(
    x[seq_len(min(max_sit, nrow(x))), seq_len(min(max_spc, ncol(x)))],
    ...
  )
  if (max_sit < nrow(x)) {
    cli::cli_alert_info("Only the first {max_sit} site{?s} are displayed.")
  }
  if (max_spc < ncol(x)) {
    cli::cli_alert_info("Only the first {max_sit} specie{?s} are displayed.")
  }
}