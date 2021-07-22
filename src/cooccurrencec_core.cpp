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

DataFrame cooccurrence_core(LogicalMatrix mat_pa)
{

        int i, j, k, l, sz;
        // number of unique pairs
        sz = (mat_pa.ncol() * (mat_pa.ncol() - 1)) / 2;
        IntegerVector spc1(sz), spc2(sz), a(sz), b(sz), c(sz), d(sz);

        k = 0;
        for (i = 0; i < mat_pa.ncol() - 1; i++)
        {
                for (j = i + 1; j < mat_pa.ncol(); j++)
                {
                        for (l = 0; l < mat_pa.nrow(); l++)
                        {
                                if (mat_pa(l, i))
                                {
                                        if (mat_pa(l, j))
                                        {
                                                a(k)++;
                                        }
                                        else
                                        {
                                                b(k)++;
                                        }
                                }
                                else
                                {
                                        if (mat_pa(l, j))
                                        {
                                                c(k)++;
                                        }
                                        else
                                        {
                                                d(k)++;
                                        }
                                }
                        }
                        spc1(k) = i + 1;
                        spc2(k) = j + 1;
                        k++;
                }
        }

        return (DataFrame::create(
            _["species1"] = spc1,
            _["species2"] = spc2,
            _["case_10"] = b,
            _["case_01"] = c,
            _["case_11"] = a,
            _["case_00"] = d,
            _["case_spc1"] = a + b,
            _["case_spc2"] = a + c));
}

// [[Rcpp::export]]

NumericVector cooc_zscore_binomial_core(IntegerVector ab, IntegerVector ac,
                                        IntegerVector a, int nsite)
{

        int k, sz;
        double inv_nsite, tmp;
        sz = a.size();
        NumericVector zscore(sz);
        inv_nsite = 1 / (1.0 * nsite);
        tmp = 0.0;
        for (k = 0; k < sz; k++)
        {
                // number of coocurrence events under null hypothesis
                tmp = inv_nsite * ab(k) * ac(k);
                zscore(k) = (a(k) - tmp) / sqrt(tmp * (1 - tmp * inv_nsite));
        }

        return (zscore);
}

// [[Rcpp::export]]

NumericVector cooc_zscore_hypergeom_core(IntegerVector ab, IntegerVector ac,
                                         IntegerVector a, int nsite)
{

        int k, sz;
        double tmp, tmp1;
        sz = a.size();
        NumericVector zscore(sz);
        
        tmp1 = 1.0 * nsite * (nsite - 1);

        for (k = 0; k < sz; k++)
        {
                tmp = 1.0 * ab(k) * ac(k) / nsite;
                // after simplification
                zscore(k) = (a(k) - tmp) / sqrt(tmp * (nsite - ac(k)) *
                        (nsite - ab(k)) / tmp1);
        }

        return (zscore);
}


double mutual_info_unit(int n12, int n1, int n2, int n) {
        double out;
        if (!n12) {
                out = 0;
        } else if (!n1 | !n2) {
                out = R_NaN; 
        } else {
                out = n12 * log2(1.0*n12*n/(1.0*n1*n2));
        }
        return (out);
}


// [[Rcpp::export]]

DataFrame cooc_mututal_information_core(IntegerVector n1, IntegerVector n2, IntegerVector n11, IntegerVector n10,
        IntegerVector n01, IntegerVector n00, int nsite)
{

        int i, sz;
        sz = n1.size();
        NumericVector mi(sz), bc(sz), mpi(sz);

        for (i = 0; i < sz; i++)
        {
             mi(i) = 1 / (1.0 * nsite * (
                     mutual_info_unit(n11(i), n1(i), n2(i), nsite) + 
                     mutual_info_unit(n10(i), n1(i), nsite - n2(i), nsite) +
                     mutual_info_unit(n01(i), nsite - n1(i), n2(i), nsite) +
                     mutual_info_unit(n00(i), nsite - n1(i), nsite - n2(i), nsite)
             ));
             bc(i) = 1.0 * (n11(i) * n00(i) - n01(i) * n10(i)) / (1.0 * nsite * (nsite - 1));
             if (n01(i) < n10(i)) {
                mpi(i) = 1.0 * n11(i) / (1.0 * n01(i));
             } else {
                mpi(i) = 1.0 * n11(i) / (1.0 * n10(i));
             } 
            
        }

        return (DataFrame::create(
            _["binary_covariance"] = bc,
            _["mean_pairwise_index"] = mpi,
            _["mutual_information"] = mi));
}


// [[Rcpp::export]]

DataFrame cooc_overlap_core(IntegerVector n1, IntegerVector n2, IntegerVector n11)
{

        int i, sz;
        double tmp1, tmp2;
        sz = n1.size();
        NumericVector o12(sz), o21(sz), sim(sz), cun(sz);

        for (i = 0; i < sz; i++)
        {
                o12(i) = 1.0 * n11(i) / n1(i);
                o21(i) = 1.0 * n11(i) / n2(i);
                if (o12(i) > o21(i))
                {
                        tmp1 = o12(i);
                        tmp2 = o12(i) - o21(i);
                }
                else
                {
                        tmp1 = o21(i);
                        tmp2 = o21(i) - o12(i);
                }
                sim(i) = tmp2 / tmp1;
                cun(i) = 1.0 * (n1(i) - n11(i)) * (n2(i) - n11(i));
        }

        return (DataFrame::create(
            _["c_score_unit"] = cun,
            _["overlap_1_2"] = o12,
            _["overlap_2_1"] = o21,
            _["symmetry"] = sim));
}





//' @name cooccurrence_core
//'
//' @title Co-occurrence analysis for triplets.
//'
//' @return
//' A dataframe with all triplets of species and the counts associated.
//'
// [[Rcpp::export]]

DataFrame cooccurrence_triplet_core(LogicalMatrix mat_pa)
{

        int i, j, k, l, s, sz;
        // number of unique triads
        sz = (mat_pa.ncol() * (mat_pa.ncol() - 1) * (mat_pa.ncol() - 2)) / 6;
        IntegerVector spc1(sz), spc2(sz), spc3(sz);
        IntegerMatrix coo(sz, 8);

        s = 0;
        for (i = 0; i < mat_pa.ncol() - 2; i++)
        {
                for (j = i + 1; j < mat_pa.ncol() - 1; j++)
                {
                        for (k = j + 1; k < mat_pa.ncol(); k++)
                        {
                                for (l = 0; l < mat_pa.nrow(); l++)
                                {
                                        if (mat_pa(l, i))
                                        {
                                                if (mat_pa(l, j))
                                                {
                                                        if (mat_pa(l, k))
                                                        {
                                                                // ijk
                                                                // 111
                                                                coo(s, 7)++;
                                                        }
                                                        else
                                                        {
                                                                /// 110
                                                                coo(s, 6)++;
                                                        }
                                                }
                                                else
                                                {
                                                        if (mat_pa(l, k))
                                                        {
                                                                // 101
                                                                coo(s, 5)++;
                                                        }
                                                        else
                                                        {
                                                                /// 100
                                                                coo(s, 4)++;
                                                        }
                                                }
                                        }
                                        else
                                        {
                                                if (mat_pa(l, j))
                                                {
                                                        if (mat_pa(l, k))
                                                        {
                                                                // 011
                                                                coo(s, 3)++;
                                                        }
                                                        else
                                                        {
                                                                /// 010
                                                                coo(s, 2)++;
                                                        }
                                                }
                                                else
                                                {
                                                        if (mat_pa(l, k))
                                                        {
                                                                // 001
                                                                coo(s, 1)++;
                                                        }
                                                        else
                                                        {
                                                                /// 000
                                                                coo(s, 1)++;
                                                        }
                                                }
                                        }
                                }
                                spc1(s) = i + 1;
                                spc2(s) = j + 1;
                                spc3(s) = k + 1;
                                s++;
                        }
                }
        }

        return (DataFrame::create(
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
            _["case_spc3"] = coo(_, 7) + coo(_, 5) + coo(_, 3) + coo(_, 1)));
}