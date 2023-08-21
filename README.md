# mhstability

Extends stability selection and introduces automatic threshold selection to compute a data-adaptive stability cutoff. This is an R Package created to extend the use of stabsel objects from the stabs package. The package also includes an `ats` function to compute the threshold. 

The main function to create a stabsel object using the `stabs` package:

```{r}
s = stabs::stabsel(X, y, cutoff, PFER)
```
The object `s` can be inputted into the function `mhstability::plot_stabs`, to plot the variable selection probability scree plot. It automatically computes the automatic threshold selection (ATS) rate $\hat{\pi}$. This can be manually found using the `ats` function. The function can also plot the likelihood function, used to determine the optimal threshold. 

# Usage 
``` r
# Plot variable selection probability scree plot
plot_stabs(s, which = 1)

# Plot likelihood function
plot_stabs(s, which = 2)

# Plot variable selection probability scree plot with respect to manual threshold selection and display top 4 variables
plot_stabs(s, which = 1, threshold = "MTS", top = 4)

# Plot variable selection probability scree plot with respect to automatic threshold selection and display all selected variables
plot_stabs(s, which = 1, threshold = "ATS", top = "all)

# Compute elbow index
ats(s, type = "index")

# Compute ATS cutoff
ats(s, type = "prob")
```

# References

* Meinshausen, N. and Buehlmann, P. (2009). Stability Selection. arXiv:0809.2932 [stat]

* Shah, R. D. and Samworth, R. J. (2013). Variable selection with error control: another look at stability selection. Journal of the Royal     Statistical Society. Series B (Statistical
Methodology), 75(1):55–80. Publisher: Wiley.
