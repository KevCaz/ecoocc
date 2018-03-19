#include <Rcpp.h>
using namespace Rcpp;

//' @title Compute the beta diversity between all sites
//'
//' @description
//' Compute the beta diversity between all sites for a specific presence-absence
//' matrix.
//'
//' @author
//' Kevin Cazelles
//'
//' @param mat_pa presence absence matrix (sites as rows and species as columns).
//'
//' @return
//' A dataframe with all the combinaison of site and the counts.
//'
// [[Rcpp::export]]

DataFrame betadiversity_core(LogicalMatrix mat_pa) {

        int i, j, k, l, sz;
        sz = .5*mat_pa.nrow()*(mat_pa.nrow()-1);
        IntegerVector site1(sz), site2(sz), a(sz), b(sz), c(sz), d(sz);

        k = 0;
        for (i=0; i<mat_pa.nrow()-1; i++) {
                for (j=i+1; j<mat_pa.nrow(); j++) {
                        for (l=0; l<mat_pa.ncol(); l++) {
                                if (mat_pa(i,l)) {
                                        if (mat_pa(j,l)) {
                                                a(k)++;
                                        } else {
                                                b(k)++;
                                        }
                                } else{
                                        if (mat_pa(j,l)) {
                                                c(k)++;
                                        } else{
                                                d(k)++;
                                        }
                                }
                        }
                        site1(k) = i+1;
                        site2(k) = j+1;
                        k++;
                }
        }

        return(DataFrame::create(
                       Named("site1") = site1,
                       Named("site2") = site2,
                       Named("site1_only") = b,
                       Named("site2_only") = c,
                       Named("both") = a,
                       Named("none") = d
                       ));

}
