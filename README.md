# mhstability

Stability Selection Visualisation Tool with Automatic Threshold Selection.

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

# Theory


Stability selection (SS) \citep{meinshausen_stability_2009} is a simple process that utilises subsampling and randomness to improve the performance of a variable selection algorithm. SS is based on the aggregation of results, given by repeated variable selection algorithms on multiple subsamples of the data. A key feature of SS is an error bound, which can be controlled by modifying various parameters. Therefore, a practitioner can tailor their tolerance for error simply by changing the parameters. SS aims to improve the performance of existing variable selection algorithms and construct a theoretical error control.

## Framework 
Any variable selection algorithm aims to estimate the set of signal features $S$. With features indexed from $\{1,\dots,p\}$, we let $S\subseteq \{1,\dots,p\}$ and the set of Noise variables $N= \{1,\dots,p\}\backslash S$. This is equivalent to a set of signal variables containing non-zero coefficients, $S = \{k:\beta_k \neq 0\}$, inverse to the set of noise variables containing a coefficient of zero, $N = \{k:\beta_k = 0\}$. The estimation of the set of signal features $\hat{S}$ are the selected variables given by some feature selection algorithm, such as LASSO. In feature selection algorithms that have a regularisation parameter $\lambda$ such as LASSO, Stepwise Selection, Elastic Net, we note that $\hat{S}$ is a function of $\lambda$, and such denote $\hat{S}^\lambda = \{ k: \beta_k \neq 0\},\ k= 1,\dots,p$ the set of selected variables for $\lambda \in \Lambda$. For every value of $\lambda \in \Lambda$, the feature selection algorithm will estimate $\hat{S}^\lambda$ with the goal of selecting the right $\hat{S}^\lambda$ such that the probability of the selected $\hat{S}^\lambda$ is identical to the true set $S$ with high probability. Formally, we aim that consistent variable selection (or stability of the variables) is equivalent to $\mathbb{P}(\hat{S}^\lambda = S) \rightarrow 1$. Each estimated set is derived from a subsample of the data $I$. A useful visualisation is a regularisation path when determining the optimal value of $\lambda \in \Lambda$. This regularisation path shows the coefficient of all variables for all values of $\lambda$; $\{\hat{\beta}^\lambda _k ; \lambda \in \Lambda,\ k=1,\dots,p\}$. An extension to the regularisation path is the stability path, which replaces the coefficients of the variables, with the probability of each variable being selected when randomly resampling from the data. 

Let $I$ be a random subsample of $\{1,\dots,n\}$ ($n =$ number of entries), of equal probabilities with size $\lfloor \frac{n}{2}\rfloor$ drawn without replacement. Let $\hat{S}^\lambda(I)$ represent the subsample as a function of $I$ and some regularisation parameter $\lambda$. 

Let $K \subseteq \{1,\dots,p\}$ denote every set of features $p$. Then, the probability of a set of features in the selected set $\hat{S}^\lambda (I)$ is
    $$\hat{\mathbb{P}i}^\lambda _K  = \mathbb{P} \left(K\subseteq \hat{S} ^\lambda (I)\right)$$


An attractive property of SS is that there can be derived a bound for the expected number $V$ of falsely selected variables, where $V = |N\cap \hat{S}^{\text{stable}} |$. Our definition of a falsely selected variable is a variable that is deemed stable when in reality belongs to the noise set $N$. Denote that $\hat{S}^\Lambda = \bigcup_{\lambda \in \Lambda} \hat{S}^\lambda$ is the union of the set of selected variables for all varying regularisation parameter $\lambda$. Then $q_\Lambda = \mathbb{E} (|\hat{S} ^\Lambda (I)| )$ is the average number of selected variables per run. An error bound or the maximum number of allowed falsely selected variables can be mathematically described by incorporating $q_\Lambda$, $\mathbb{P}i$, and the number of features $p$. While this error bound is helpful, it is more of a theoretical advantage, as it requires assumptions, including the exchangeability of the noise variables. Given that this exchangeability assumption for the noise variables is quite hard to prove in practice, Shah \& Samworth (2013) introduced their version of SS, Complementary Pairs Stability Selection (CPSS), which requires no exchangeability assumption. The authors introduce a different sampling method, straying away from random subsampling that the original authors utilises. This new sampling method features samples from the data set with the same size $\lfloor \frac{n}{2}\rfloor$ and has no intersect.


Let the subsamples be drawn as complementary pairs from $\{1,\dots,n\}$. Then the subsampling procedure outputs index sets $\{ (A_{2j-1}, A_{2j}): j=1,\dots,B\}$, where each $A_j$ is a subset of $\{1,\dots,n\}$ of size $\lfloor \frac{n}{2}\rfloor$ and $A_{2j-1} \cap A_{2j}  = \emptyset$. For $\mathbb{P}i \in [0,1]$, the simultaneous selection version of $\hat{S}_n$ is $\hat{S}^{\text{CPSS}} _{n,\mathbb{P}i} = \{k:\hat{\mathbb{P}i}_B (k) \geq \mathbb{P}i \}$, where the function $\hat{\mathbb{P}i}_B:\{1,\dots,p\} \rightarrow \{0, 1/(2B),1/B,\dots, B\}$ is given by 

$$\hat{\mathbb{P}i} _B (k) = \frac{1}{2B} \sum^{2B} _{j=1} \mathbf{1}_{k\in \hat{S} (A_{j})} $$


The methodology and steps between using SS and CPSS do not change, and the steps hereafter in determining the stable set $\hat{S}$ are identical. The difference lies in the sampling step. Given that the data is sampled in pairs and twice at a time, the authors recommend letting $B= 50$, yielding $100$ samples, the same number of samples as SS when $B=100$. Since the pairs $A_{2j-1} \cap A_{2j} = \emptyset$ and $A_{2j-1} \cup A_{2j} = A$, where $A$ is the set of all data points, there is no loss in data due to chance, as this sampling process always considers all data points. This mitigates the possible loss of information in SS, as the random subsampling has no guarantee that all information is used.   

$$\hat{\mathbb{P}i} _B (k) = \frac{1}{2B} \sum^{2B} _{j=1} \mathbf{1}_{k\in \hat{S} (A_{j})} $$


# Notice

This work has been created as part of my Honours degree at the University of Sydney 2023. 

# References

* Meinshausen, N. and Buehlmann, P. (2009). Stability Selection. arXiv:0809.2932 [stat]

* Shah, R. D. and Samworth, R. J. (2013). Variable selection with error control: another look at stability selection. Journal of the Royal     Statistical Society. Series B (Statistical
Methodology), 75(1):55–80. Publisher: Wiley.

* Hofner, B. and Hothorn, T. (2021). stabs: Stability Selection with Error Control.

* Zhu, M. and Ghodsi, A. (2006). Automatic dimensionality selection from the scree plot
via the use of profile likelihood. Computational Statistics & Data Analysis, 51(2):918–930.
