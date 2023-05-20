#' Create a presence/absence object

#' Create a presence/absence (`pa`) object from a matrix.

#' @param x a R object to be coerced as a matrix.
#' @param threshold threshold value. Above (strictly) this value, a species is considered present.
#' @param spc_name vector of species names.
#' @param sit_name vector of site names.
#'
#' @details
#' The input `x` should be a presence absence matrix (sites as rows and species as columns), it could be either a logical one or a numeric one. In the latter case, presence and absence will be determined based on `threshold`.
#' If there are less names than species (or sites), or no names at all, then names will be automatically added. These names are created using column or row numbers (zero-padded to the number of digits of total the number of column or row), preceded by `spc_` for column and `sit_` for sites.
#'
#' @return
#' An object of class `pa` which basically is a matrix of `0` (absence) and `1` (presence).
#'
#' @export
#' @examples
#' ec_pa(matrix(c(0, 0, 0, 1, 1, 0, 1, 0, 0), 3, 3), spc_name = "Lynx", sit_name = "ON_001")
ec_pa <- function(x, threshold = 0, spc_name = NULL, sit_name = NULL) {
  pa <- (as.matrix(x) > threshold) * 1
  stopifnot(NROW(x) > 0 & NCOL(x) > 0)

  rownames(pa) <- name_it(sit_name, NROW(x), "sit", "sites")
  colnames(pa) <- name_it(spc_name, NCOL(x), "spc", "species")

  id <- which(!apply(pa, 2, sum))
  if (length(id)) {
    cli::cli_alert_warning(
      c("No presence data for the following species: ",
      paste0(id, collapse = ", "))
    )
  }
  id <- which(!apply(pa, 1, sum))
  if (length(id)) {
    cli::cli_alert_warning(c("Empty site(s): ", paste0(id, collapse = ", ")))
  }

  structure(
    pa,
    noccur = sum(pa),
    type = "logical",
    class = c("pa", "matrix", "array")
  )
}


#
name_it <- function(val, len, what, w_name) {
  if (is.null(val)) {
    seq_string_zero(what, len, seq_len(len))
  } else {
    l_val <- length(val)
    if (l_val == len) {
      return(val)
    } else {
      dif <- len - l_val
      if (dif) {
        cli::cli_alert_info("Less names than {w_name}, names have been generated.")
        return(
          c(val, seq_string_zero(what, len, seq(l_val + 1, len)))
        )
        #
      } else {
        cli::cli_alert_info(c(
          "More names than {w_name} ",
          "only the first {len} names have been used.c()"
        ))
        return(val[seq_len(len)])
      }
    }
  }
}

# Aim at adding names with as less ambiguity as possible
seq_string_zero <- function(what, len, id) {
  sprintf(paste0(what, "_%0", floor(log10(len)) + 1, "d"), id)
}
