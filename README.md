# mhstability

Stability Selection Visualisation Tool and Automatic Threshold Selection.

Extends stability selection and introduces automatic threshold selection to compute a data-adaptive stability cutoff. This is an R Package created to complement the use of stabs objects from the stabs package. It visualises variable selection probability and likelihood function through `plot_stabs`. The package also includes an `ats` function to compute the threshold. 


# Installation

Install package via GitHub
``` r
devtools::install_github("MHuang2001/mhstability")
library(mhstability)
```

# Usage 

The main function to create a stabs object and conduct stability selection using the `stabs` package:

``` r
s = stabs::stabsel(X, y, cutoff, PFER)
```
The object `s` can be inputted into the function `mhstability::plot_stabs`, to plot the variable selection probability scree plot. It automatically computes the automatic threshold selection (ATS) rate $\hat{\pi}$. This can be manually found using the `ats` function. The function can also plot the likelihood function, used to determine the optimal threshold. 

``` r
# Plot variable selection probability scree plot
plot_stabs(s, which = 1)

# Plot likelihood function
plot_stabs(s, which = 2)

# Plot variable selection probability scree plot with respect to manual threshold selection and display top 4 variables
plot_stabs(s, which = 1, threshold = "MTS", top = 4)

# Plot variable selection probability scree plot with respect to automatic threshold selection and display all selected variables
plot_stabs(s, which = 1, threshold = "ATS", top = "all")

# Compute elbow index
ats(s, type = "index")

# Compute ATS cutoff
ats(s, type = "prob")
```

# Notice

This work has been created as part of my Honours degree at the University of Sydney 2023. 

# References

* Meinshausen, N. and Buehlmann, P. (2009). Stability Selection. arXiv:0809.2932 [stat]

* Shah, R. D. and Samworth, R. J. (2013). Variable selection with error control: another look at stability selection. Journal of the Royal     Statistical Society. Series B (Statistical
Methodology), 75(1):55–80. Publisher: Wiley.

* Hofner, B. and Hothorn, T. (2021). stabs: Stability Selection with Error Control.

* Zhu, M. and Ghodsi, A. (2006). Automatic dimensionality selection from the scree plot
via the use of profile likelihood. Computational Statistics & Data Analysis, 51(2):918–930.
