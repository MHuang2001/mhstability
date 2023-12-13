// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// getLQ
NumericVector getLQ(const NumericVector& d);
RcppExport SEXP _mhstability_getLQ(SEXP dSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericVector& >::type d(dSEXP);
    rcpp_result_gen = Rcpp::wrap(getLQ(d));
    return rcpp_result_gen;
END_RCPP
}
// getR
int getR(const NumericVector& d);
RcppExport SEXP _mhstability_getR(SEXP dSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericVector& >::type d(dSEXP);
    rcpp_result_gen = Rcpp::wrap(getR(d));
    return rcpp_result_gen;
END_RCPP
}
// rcpp_hello
List rcpp_hello();
RcppExport SEXP _mhstability_rcpp_hello() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(rcpp_hello());
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_mhstability_getLQ", (DL_FUNC) &_mhstability_getLQ, 1},
    {"_mhstability_getR", (DL_FUNC) &_mhstability_getR, 1},
    {"_mhstability_rcpp_hello", (DL_FUNC) &_mhstability_rcpp_hello, 0},
    {NULL, NULL, 0}
};

RcppExport void R_init_mhstability(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}