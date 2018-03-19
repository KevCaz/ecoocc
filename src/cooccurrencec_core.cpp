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
                       _["species1"] = species1,
                       _["species2"] = species2,
                       _["case_10"] = b,
                       _["case_01"] = c,
                       _["case_11"] = a,
                       _["case_00"] = d,
                       _["case_sp1"] = a + b,
                       _["case_sp2"] = a + c
                       ));

}


// [[Rcpp::export]]

NumericVector test_cooccurrence_raw_core(IntegerVector ab, IntegerVector ac,
                                         IntegerVector a, int nsite) {

        int k, sz;
        double inv_nsite, tmp;
        sz = a.size();
        NumericVector zscore(sz);
        inv_nsite = 1/(1.0*nsite);

        for (k=0; k<sz; k++) {
                tmp = ab(k)*ac(k)*inv_nsite;
                zscore(k) = (a(k) - tmp)/sqrt(tmp*(1-tmp*inv_nsite));
        }

        return(zscore);
}



// [[Rcpp::export]]

NumericVector test_cooccurrence_veech_core(IntegerVector ab, IntegerVector ac,
                                           IntegerVector a, int nsite) {

        int k, sz, mn, mx, tmp;
        double tmp1, tmp2;
        sz = a.size();
        NumericVector zscore(sz);
        tmp1 = sqrt(nsite*(nsite-1));

        for (k=0; k<sz; k++) {
                mn = ab(k);
                mx = ab(k);
                if (ac(k)>ab(k)) {
                        mx = ac(k);
                } else mn = ac(k);
                tmp2 = mx*mn/(1.0*nsite);
                zscore(k) = tmp1*(a(k) - tmp2)/sqrt(tmp2*(nsite-mn)*(nsite-mx));
        }

        return(zscore);
}
