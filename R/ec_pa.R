#' Create a presence/absence object

#' Create a presence/absence (`pa`) object from a matrix.

#' @param x a R object to be coerced as a matrix. 
#' @param threshold threshold value. Above (strictly) this value, a species is considered present. 
#' @param spc_name vector of species names. 
#' @param sit_name vector of site names.
#' 
#' @details 
#' If there are less names than species (or sites), or no names at all, then names will be automatically added. These names are created using column or row numbers (zero-padded to the number of digits of total the number of column or row), preceded by `spc_` for column and `sit_` for sites.
#'
#' @export
#' @examples 
#' ec_pa(matrix(c(0,0,2,1,1,0), 3, 2), spc_name = "Lynx", sit_name = "GHQ") 

ec_pa <- function(x, threshold = 0, spc_name = NULL, sit_name = NULL) {
  
  pa <- (as.matrix(x) > threshold) * 1 
  rownames(pa) <- name_it(sit_name, NROW(x), "sit")
  colnames(pa) <- name_it(spc_name, NCOL(x), "spc")
  
  structure(
    pa,
    nspecies = NCOL(pa),
    nsite = NROW(pa),
    noccur = sum(pa),
    class = "pa"
  )
}



# 
name_it <- function(val, len, what) {
  if (is.null(val)) {
    seq_string_zero(what, len, seq_len(len))
  } else {
    l_val <- length(val)
    if (l_val == len) {
      return(val)
    } else {
      dif <- len - l_val
      if (dif > 0) {
        msgWarning("Less names than", what, msg_plur(dif), "been added.")
        return(
          c(val, seq_string_zero(what, len, seq(l_val + 1, len)))
        )
        # 
      } else {
        msgWarning("More names than", what, 
          "only the first", msg_plur(len), "been used.")
        return(val[seq_len(len)])
      }
      
    }
      
  }
}

# Aim at adding names with as less ambiguity as possible
seq_string_zero <- function(what, len, id) {
  sprintf(paste0(what, "_%0", floor(log10(len)) + 1, "d"), id)
}

msg_plur <- function(len) {
  tmp <- ifelse(len > 1, "s have", " has")  
  paste0(len, " value", tmp)
}
