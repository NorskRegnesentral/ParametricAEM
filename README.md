
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ParametricAEM

<!-- badges: start -->
<!-- badges: end -->

The goal of ParametricAEM is to estimate a parametric age-reading error
matrix based on data where multiple readers have read the same fish.

## Installation

You can install the development version of ParametricAEM from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("NorskRegnesentral/ParametricAEM")
```

## Example

``` r
library(ParametricAEM)
file_path = system.file("extdata",
                         "NSS_herring_scales.csv",
                          package = "ParametricAEM")
 data_nss_scales = read.csv(file_path, sep = ",")
 data_exp = data_nss_scales[data_nss_scales$expertise == 1, ] # Extract experts
 data_exp = data_exp[data_exp$age > 0, ]
 data_analysis = Compute_modes(data_exp)
 data_analysis_capped = Cap_ages(data_analysis)
 fit = Estimate_model(data = data_analysis_capped,
                      min_age = 3,
                      max_age = 12,
                      start = c(2, 0, 0, 0, 0.2),
                      estimate = c(1, 1, 1, 1, 1))
 errormatrix = Calculate_matrix(fit$estimate[, "Estimate"], min_age = 3, max_age = 12)
 round(errormatrix, 3)
#>        3     4     5     6     7     8     9    10    11    12
#> 3  0.983 0.012 0.004 0.001 0.000 0.000 0.000 0.000 0.000 0.000
#> 4  0.017 0.961 0.015 0.005 0.001 0.000 0.000 0.000 0.000 0.000
#> 5  0.006 0.019 0.947 0.020 0.006 0.002 0.001 0.000 0.000 0.000
#> 6  0.002 0.007 0.025 0.929 0.026 0.008 0.002 0.001 0.000 0.000
#> 7  0.001 0.003 0.010 0.033 0.905 0.034 0.010 0.003 0.001 0.000
#> 8  0.000 0.001 0.004 0.013 0.045 0.875 0.043 0.013 0.004 0.002
#> 9  0.000 0.000 0.002 0.005 0.018 0.061 0.836 0.054 0.016 0.007
#> 10 0.000 0.000 0.001 0.002 0.007 0.024 0.082 0.789 0.067 0.028
#> 11 0.000 0.000 0.000 0.001 0.003 0.009 0.032 0.107 0.733 0.115
#> 12 0.000 0.000 0.000 0.000 0.001 0.004 0.012 0.041 0.137 0.805

## basic example code
```
