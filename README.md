
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ParametricAEM

<!-- badges: start -->
<!-- badges: end -->

The goal of ParametricAEM is to estimate a parametric age-reading error
matrix based on data where multiple readers have read the same fish. The
package contains four such example data sets in inst/extdata, and
scripts for analysing each of these in the folder demo. The data sets
have been generated using the SmartDots-tool Bekaert (2024). The data
sets on scale and otolith readings of Norwegian Spring-Spawning Herring
originate from an international age-reading exchange (ICES 2023a). The
data sets on Atlantic mackerel and North Sea herring originate from
internal age-reading exchanges hosted by The Institute of Marine
Research (IMR) of Norway.

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

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-SmartDots2024" class="csl-entry">

Bekaert, Karen. 2024. “<span class="nocase">SmartDots Report for the
2024 Irish Sea Sole (sol.27.7a) age reading exchange (ID 1842)</span>.”
<https://smartdots.ices.dk/sampleImages/2023/1842/SmartDots_Report_Event_1842_sole%207a%202024.docx>.

</div>

<div id="ref-ices2023" class="csl-entry">

ICES. 2023a. “<span class="nocase">Workshop on age reading of Norwegian
springspawning herring (*Clupea harengus*) (WKARNSSH)</span>.” *ICES
Scientific Reports* 5 (84).
<https://doi.org/10.17895/ices.pub.24105534>.

</div>

<div id="ref-SmartDots_template" class="csl-entry">

———. 2023b. “<span class="nocase">SmartDots Report template</span>.”
<https://github.com/ices-taf/SmartDotsReport_template/commits/master/report_full.Rmd>.

</div>

<div id="ref-SmartDots" class="csl-entry">

———. 2024. “SmartDots.”
<https://github.com/ices-taf/SmartDotsReport_template/>.

</div>

</div>
