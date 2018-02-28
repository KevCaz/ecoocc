#include <Rcpp.h>
using namespace Rcpp;

//' @title Compute the beta diversity two set of sites
//'
//' @description
//' Compute the beta diversity between all sites for a specific presence-absence
//' matrix.
//'
//' @author
//' Kevin Cazelles
//'
//' @param mat_pa1 presence absence matrix (sites as rows and species as columns) for time 1.
//' @param mat_pa2 presence absence matrix for time 2.
//'
//' @importFrom magrittr %>%
//'
//' @return
//' A dataframe with all the combinaison of sites and the counts associated.
//'
// [[Rcpp::export]]

DataFrame temporal_beta_core(LogicalMatrix mat_pa1, LogicalMatrix mat_pa2) {

  int i, j, k, l, sz;
  sz = mat_pa1.nrow();
  IntegerVector site1(sz), a(sz), b(sz), c(sz), d(sz);

  k = 0;
  for (i=0; i<sz; i++) {
    site1(k) = i+1;
    for (j=0; j<mat_pa1.ncol(); j++) {
      if (mat_pa1(i,j)) {
        if (mat_pa2(i,j)) {
          a(k)++;
        } else {
          b(k)++;
        }
      } else{
        if (mat_pa2(i,j)) {
          c(k)++;
        } else{
          d(k)++;
        }
      }
    }
    k++;
  }

  return(DataFrame::create(
    Named("site") = site1,
    Named("site_t1_only") = b,
    Named("site_t2_only") = c,
    Named("both") = a,
    Named("none") = d
  ));

}
