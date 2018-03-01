// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// betadiversity_core
DataFrame betadiversity_core(LogicalMatrix mat_pa);
RcppExport SEXP _ecoocc_betadiversity_core(SEXP mat_paSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< LogicalMatrix >::type mat_pa(mat_paSEXP);
    rcpp_result_gen = Rcpp::wrap(betadiversity_core(mat_pa));
    return rcpp_result_gen;
END_RCPP
}
// cooccurrence_core
DataFrame cooccurrence_core(LogicalMatrix mat_pa);
RcppExport SEXP _ecoocc_cooccurrence_core(SEXP mat_paSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< LogicalMatrix >::type mat_pa(mat_paSEXP);
    rcpp_result_gen = Rcpp::wrap(cooccurrence_core(mat_pa));
    return rcpp_result_gen;
END_RCPP
}
// temporal_beta_core
DataFrame temporal_beta_core(LogicalMatrix mat_pa1, LogicalMatrix mat_pa2);
RcppExport SEXP _ecoocc_temporal_beta_core(SEXP mat_pa1SEXP, SEXP mat_pa2SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< LogicalMatrix >::type mat_pa1(mat_pa1SEXP);
    Rcpp::traits::input_parameter< LogicalMatrix >::type mat_pa2(mat_pa2SEXP);
    rcpp_result_gen = Rcpp::wrap(temporal_beta_core(mat_pa1, mat_pa2));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_ecoocc_betadiversity_core", (DL_FUNC) &_ecoocc_betadiversity_core, 1},
    {"_ecoocc_cooccurrence_core", (DL_FUNC) &_ecoocc_cooccurrence_core, 1},
    {"_ecoocc_temporal_beta_core", (DL_FUNC) &_ecoocc_temporal_beta_core, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_ecoocc(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}