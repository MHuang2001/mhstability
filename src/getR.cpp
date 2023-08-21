#include <Rcpp.h>
using namespace Rcpp;
// [[Rcpp::export]]
int getR(const NumericVector& d) {
  int p = d.size();
  NumericVector lq(p, 0.0);
  NumericVector sigma2(p);
  for (int q = 0; q < p; q++) {
    NumericVector d1 = head(d, q + 1);
    NumericVector d2 = tail(d, p - (q + 1));
    double mu1 = mean(d1);
    double mu2 = mean(d2);
    sigma2[q] = (sum(pow(d1 - mu1, 2)) + sum(pow(d2 - mu2, 2))) / (p - 2);
    lq[q] = sum(dnorm(d1, mu1, sqrt(sigma2[q]), true)) +
      sum(dnorm(d2, mu2, sqrt(sigma2[q]), true));
  }
  return which_max(lq) + 1;
}
