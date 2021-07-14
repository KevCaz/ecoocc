#include <Rcpp.h>
using namespace Rcpp;


//' @name cooccurrence_core
//'
//' @title Co-occurrence analysis.
//'
//' @description
//' Compute the co-occurrence of all pairs of species.
//'
//' @param mat_pa presence absence matrix (sites as rows and species as columns).
//'
//' @return
//' A dataframe with all the combinaisons of species and the counts associated.
//'
// [[Rcpp::export]]

DataFrame cooccurrence_core(LogicalMatrix mat_pa) {

        int i, j, k, l, sz;
        // number of unique pairs
        sz = (mat_pa.ncol()*(mat_pa.ncol()-1))/2;
        IntegerVector spc1(sz), spc2(sz), a(sz), b(sz), c(sz), d(sz);

        k = 0;
        for (i=0; i<mat_pa.ncol()-1; i++) {
                for (j=i+1; j<mat_pa.ncol(); j++) {
                        for (l=0; l<mat_pa.nrow(); l++) {
                                if (mat_pa(l, i)) {
                                        if (mat_pa(l, j)) {
                                                a(k)++;
                                        } else {
                                                b(k)++;
                                        }
                                } else {
                                        if (mat_pa(l, j)) {
                                                c(k)++;
                                        } else{
                                                d(k)++;
                                        }
                                }
                        }
                        spc1(k) = i+1;
                        spc2(k) = j+1;
                        k++;
                }
        }

        return(DataFrame::create(
                       _["species1"] = spc1,
                       _["species2"] = spc2,
                       _["case_10"] = b,
                       _["case_01"] = c,
                       _["case_11"] = a,
                       _["case_00"] = d,
                       _["case_spc1"] = a + b,
                       _["case_spc2"] = a + c
                       ));

}


// [[Rcpp::export]]

NumericVector cooc_zscore_binomial_core(IntegerVector ab, IntegerVector ac,
                                              IntegerVector a, int nsite) {

        int k, sz;
        double inv_nsite, tmp;
        sz = a.size();
        NumericVector zscore(sz);
        inv_nsite = 1/((double)nsite);
        tmp = 0;
        for (k=0; k<sz; k++) {
                tmp = inv_nsite*ab(k)*ac(k);
                zscore(k) = (a(k) - tmp)/sqrt(tmp*(1-tmp*inv_nsite));
        }

        return(zscore);
}


// [[Rcpp::export]]

NumericVector cooc_zscore_hypergeom_core(IntegerVector ab, IntegerVector ac,
                                                    IntegerVector a, int nsite) {

        int k, sz, mn, mx;
        double tmp1, tmp2;
        sz = a.size();
        NumericVector zscore(sz);
        tmp1 = (double)nsite*sqrt(1 - 1/(double)nsite);

        for (k=0; k<sz; k++) {
                mn = ab(k);
                mx = ab(k);
                if (ac(k)>ab(k)) {
                        mx = ac(k);
                } else mn = ac(k);
                tmp2 = (double)mx*mn/((double)nsite);
                zscore(k) = tmp1*(a(k) - tmp2)/sqrt(tmp2*(nsite-mn)*(nsite-mx));
        }

        return(zscore);
}






//' @name cooccurrence_core
//'
//' @title Co-occurrence analysis for triplets. 
//' 
//' @return
//' A dataframe with all triplets of species and the counts associated.
//'
// [[Rcpp::export]]

DataFrame cooccurrence_triplet_core(LogicalMatrix mat_pa) {

		int i, j, k, l, s, sz;
		// number of unique triads
		sz = (mat_pa.ncol()*(mat_pa.ncol()-1)*(mat_pa.ncol()-2))/6;
		IntegerVector spc1(sz), spc2(sz), spc3(sz);
		IntegerMatrix coo(sz, 8);


		s=0;
		for (i=0; i<mat_pa.ncol()-2; i++) {
				for (j=i+1; j<mat_pa.ncol()-1; j++) {
						for (k=j+1; k<mat_pa.ncol(); k++) {
								for (l=0; l<mat_pa.nrow(); l++) {
										if (mat_pa(l, i)) {
												if (mat_pa(l, j)) {
														if (mat_pa(l, k)) {
																// ijk
																// 111
																coo(s, 7)++;
														} else {
																/// 110
																coo(s, 6)++;
														}
												} else {
														if (mat_pa(l, k)) {
																// 101
																coo(s, 5)++;
														} else {
																/// 100
																coo(s, 4)++;
														}
												}
										} else {
												if (mat_pa(l,j)) {
														if (mat_pa(l, k)) {
																// 011
																coo(s, 3)++;
														} else {
																/// 010
																coo(s, 2)++;
														}
												} else{
														if (mat_pa(l, k)) {
																// 001
																coo(s, 1)++;
														} else {
																/// 000
																coo(s, 1)++;
														}
												}
										}
								}
                spc1(s) = i+1;
                spc2(s) = j+1;
                spc3(s) = k+1;
                s++;
						}
				}
		}

		return(DataFrame::create(
					   _["species1"] = spc1,
					   _["species2"] = spc2,
					   _["species3"] = spc3,
					   _["case_000"] = coo(_, 0),
					   _["case_001"] = coo(_, 1),
					   _["case_010"] = coo(_, 2),
					   _["case_011"] = coo(_, 3),
					   _["case_100"] = coo(_, 4),
					   _["case_101"] = coo(_, 5),
					   _["case_110"] = coo(_, 6),
					   _["case_111"] = coo(_, 7),
					   _["case_spc1"] = coo(_, 7) + coo(_, 6) + coo(_, 5) + coo(_, 4),
					   _["case_spc2"] = coo(_, 7) + coo(_, 6) + coo(_, 3) + coo(_, 2),
					   _["case_spc3"] = coo(_, 7) + coo(_, 5) + coo(_, 3) + coo(_, 1)
					   ));

}