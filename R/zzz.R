#' ecoocc
#'
#' Ecological occurrence and more.
#'
#' @docType package
#' @description Occurrence, coccurrence and more.
#'
#' @importFrom crayon blue red green yellow
#' @importFrom cli style_bold style_underline cat_rule cat_line cat_bullet
#' @importFrom Rcpp evalCpp
#' @importFrom stats rbinom
#' 
#' @useDynLib ecoocc
#' @name ecoocc

NULL



# messages functions

msgInfo <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$info, ...)
  message(blue(txt), appendLF = appendLF)
  invisible(txt)
}

msgError <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$cross, ...)
  message(red(txt), appendLF = appendLF)
  invisible(txt)
}

msgSuccess <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$tick, ...)
  message(green(txt), appendLF = appendLF)
  invisible(txt)
}

msgWarning <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$warning, ...)
  message(yellow(txt), appendLF = appendLF)
  # warning(yellow(txt), appendLF = appendLF, call. = FALSE)
  invisible(txt)
}