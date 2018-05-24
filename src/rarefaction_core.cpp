#include <Rcpp.h>
using namespace Rcpp;

//' @name rarefaction_core
//'
//' @title Compute rarefaction
//'
//' @description
//' Compute the rarefaction curve for a given presence-absence matrix. 
//'
//' @author
//' Kevin Cazelles
//'
//' @param mat_pa presence absence matrix (sites as rows and species as columns).
//' @param nrep an integer specifying the number of repetition.
//'

// [[Rcpp::export]]
IntegerMatrix rarefaction_core(LogicalMatrix mat_pa, int nrep) {

        int i, j, k, sc, nr, nsp;
        nr = mat_pa.nrow();
        nsp = mat_pa.ncol();
        IntegerMatrix out(nr, nrep);
        IntegerVector vec_sampl(nr);
        LogicalVector vec_checked(nsp);
        //
        for (i = 0; i < nrep; i++) {
                vec_sampl = sample(nr, nr);
                // to record which species have been selected
                std::fill(vec_checked.begin(), vec_checked.end(), false);
                sc = 0;
                for (j = 0; j < nr; j++) {
                        // otherwise all species have been included!
                        if (nsp > sc) {
                                for (k = 0; k < nsp; k++) {
                                        if (!vec_checked[k]) {
                                                if (mat_pa(vec_sampl[j], k)) {
                                                        sc++;
                                                        vec_checked[k] = !vec_checked[k];
                                                }
                                        }
                                }
                                out(j, i) = sc;
                        } else out(j, i) = sc;
                }
        }
        return(out);
}
