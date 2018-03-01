#include <Rcpp.h>
using namespace Rcpp;

//' @title Co-occurrence
//'
//' @description
//' Compute the co-occurrence of all pairs of species.
//'
//' @author
//' Kevin Cazelles
//'
//' @param mat_pa presence absence matrix (sites as rows and species as columns).
//'
//' @return
//' A dataframe with all the combinaison of sites and the counts associated.
//'
// [[Rcpp::export]]

DataFrame cooccurrence_core(LogicalMatrix mat_pa) {

  int i, j, k, l, sz;
  sz = .5*mat_pa.ncol()*(mat_pa.ncol()-1);
  IntegerVector species1(sz), species2(sz), a(sz), b(sz), c(sz), d(sz);

  k = 0;
  for (i=0; i<mat_pa.ncol()-1; i++) {
    for (j=i+1; j<mat_pa.ncol(); j++) {
      for (l=0; l<mat_pa.nrow(); l++) {
        if (mat_pa(l,i)) {
          if (mat_pa(l,j)) {
            a(k)++;
          } else {
            b(k)++;
          }
        } else{
          if (mat_pa(l,j)) {
            c(k)++;
          } else{
            d(k)++;
          }
        }
      }
      species1(k) = i+1;
      species2(k) = j+1;
      k++;
    }
  }

  return(DataFrame::create(
    Named("species1") = species1,
    Named("species2") = species2,
    Named("case01") = b,
    Named("case10") = c,
    Named("case11") = a,
    Named("case00") = d
  ));

}
