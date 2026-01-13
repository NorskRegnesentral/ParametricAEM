Data examples
================

``` r
library(ParametricAEM)
```

# Data examples

The four data sets are examples of age-reading exchange data sets where
individual fish are aged by several readers. Mackerel_otoliths.csv
contains otolith readings of Atlantic mackerel,
NSAS_herring_otoliths.csv contains otolith readings of North Sea
Autumn-Spawning herring, NSS_herring_otoliths.csv contains otolith
readings of Norwegian Spring-Spawning herring, and
NSS_herring_scales.csv contains scale readings of Norwegian
Spring-Spawning herring.

# Columns used in ParametricAEM

In this R-package, we use the following columns *FishID: String,
individual identifier for each fish *reader: String, identifier for each
individual reader *expertise: Boolean, indicator for whether the reader
is an expert (1) or not (0) *age: Integer, age read by the reader

An extract of the relevant columns for the scale readings of Norwegian
Spring-Spawning herring is shown below

``` r

file_path = system.file("extdata",
                         "NSS_herring_scales.csv",
                          package = "ParametricAEM")
data_nss_scales = read.csv(file_path, sep = ",")
data_sub = data_nss_scales[,c("FishID", "reader", "expertise", "age")]
head(data_sub, n = 50)
#>        FishID reader expertise age
#> 1  S_39015_17 R02 NO         1   5
#> 2  S_39015_17 R04 NO         1   5
#> 3  S_39015_17 R08 IS         1   5
#> 4  S_39015_17 R14 NO         1   5
#> 5  S_39015_17 R16 NO         0   5
#> 6  S_39015_17 R18 IS         1   5
#> 7  S_39015_17 R24 NO         1   5
#> 8  S_39015_17 R30 FO         0   5
#> 9  S_39015_17 R32 FO         0   5
#> 10 S_39015_27 R02 NO         1   5
#> 11 S_39015_27 R04 NO         1   5
#> 12 S_39015_27 R08 IS         1   5
#> 13 S_39015_27 R14 NO         1   5
#> 14 S_39015_27 R16 NO         0   5
#> 15 S_39015_27 R18 IS         1   5
#> 16 S_39015_27 R24 NO         1   5
#> 17 S_39015_27 R30 FO         0   5
#> 18 S_39015_27 R32 FO         0   6
#> 19 S_39015_03 R02 NO         1   5
#> 20 S_39015_14 R02 NO         1   4
#> 21 S_39015_22 R02 NO         1   5
#> 22 S_39015_03 R04 NO         1   5
#> 23 S_39015_14 R04 NO         1   4
#> 24 S_39015_22 R04 NO         1   5
#> 25 S_39015_03 R08 IS         1   5
#> 26 S_39015_14 R08 IS         1   5
#> 27 S_39015_22 R08 IS         1   5
#> 28 S_39015_03 R14 NO         1   5
#> 29 S_39015_14 R14 NO         1   5
#> 30 S_39015_22 R14 NO         1   5
#> 31 S_39015_03 R16 NO         0   5
#> 32 S_39015_14 R16 NO         0   5
#> 33 S_39015_22 R16 NO         0   5
#> 34 S_39015_03 R18 IS         1   5
#> 35 S_39015_14 R18 IS         1   5
#> 36 S_39015_22 R18 IS         1   5
#> 37 S_39015_03 R24 NO         1   5
#> 38 S_39015_14 R24 NO         1   5
#> 39 S_39015_22 R24 NO         1   5
#> 40 S_39015_03 R30 FO         0   5
#> 41 S_39015_14 R30 FO         0   5
#> 42 S_39015_22 R30 FO         0   5
#> 43 S_39015_03 R32 FO         0   5
#> 44 S_39015_14 R32 FO         0   5
#> 45 S_39015_22 R32 FO         0   5
#> 46 S_39015_07 R02 NO         1   5
#> 47 S_39015_07 R04 NO         1   5
#> 48 S_39015_07 R08 IS         1   5
#> 49 S_39015_07 R14 NO         1   5
#> 50 S_39015_07 R16 NO         0   5
```
