
<!-- README.md is generated from README.Rmd. Please edit that file -->

# covid19swiss

<!-- badges: start -->

[![build](https://github.com/covid19r/covid19swiss/workflows/build/badge.svg?branch=master)](https://github.com/covid19r/covid19swiss/actions?query=workflow%3Abuild)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/covid19swiss)](https://cran.r-project.org/package=covid19swiss)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub
commit](https://img.shields.io/github/last-commit/covid19r/covid19swiss)](https://github.com/covid19r/covid19swiss/commit/master)
<!-- badges: end -->

The covid19swiss R package provides a tidy format dataset of the 2019
Novel Coronavirus COVID-19 (2019-nCoV) pandemic outbreak in Switzerland
cantons. The `covid19swiss` dataset includes the following fields:

  - `date` - the timestamp of the case, a `Date` object
  - `canton` - the canton abbreviation
  - `type` - the type of case
  - `cases` - the number of cases corresponding to the date and case
    type fields

Where the available `type` field includes the following cases:

  - `total_tested` - number of tests performed as of the date
  - `total_confirmed` - number of positive cases as of the date
  - `new_hosp` - new hospitalizations with respect to the previously
    reported date
  - `current_hosp` - number of hospitalized patients as of the current
    date
  - `current_icu` - number of hospitalized patients in ICUs as of the
    current date
  - `current_vent` - number of hospitalized patients requiring
    ventilation as of the current date
  - `total_recovered` - total number of patients recovered as of the
    current date
  - `total_death` - total number of death as of the current date

Data source: [Specialist Unit for Open Government Data Canton of
Zurich](http://open.zh.ch/internet/justiz_inneres/ogd/de/daten.html)

## Installation

You can install the released version of covid19swiss from
[CRAN](https://cran.r-project.org/web/packages/covid19swiss/index.html)
with:

``` r
install.packages("covid19swiss")
```

Or, install the most recent version from
[GitHub](https://github.com/Covid19R/covid19swiss) with:

``` r
# install.packages("devtools")
devtools::install_github("Covid19R/covid19swiss")
```

## Data refresh

The **covid19swiss** package dev version is been updated on a daily
bases. The `update_data` function enables a simple refresh of the
installed package datasets with the most updated version on Github:

``` r
library(covid19swiss)

update_data()
```

Note: must restart the R session to have the updates available

## Usage

``` r
data(covid19swiss)

head(covid19swiss)
#>         date canton            type cases
#> 1 2020-02-25     GE    total_tested    72
#> 2 2020-02-25     GE total_confirmed     0
#> 3 2020-02-25     GE        new_hosp     0
#> 4 2020-02-25     GE    current_hosp     0
#> 5 2020-02-25     GE     current_icu     0
#> 6 2020-02-25     GE    current_vent     0
```

### Wide format

``` r
library(tidyr)

covid19swiss_wide <- covid19swiss %>% 
  pivot_wider(names_from = type, values_from = cases)

head(covid19swiss_wide)
#> # A tibble: 6 x 10
#> # Groups:   date [3]
#>   date       canton total_tested total_confirmed new_hosp current_hosp current_icu current_vent total_recovered total_death
#>   <date>     <chr>         <int>           <int>    <int>        <int>       <int>        <int>           <int>       <int>
#> 1 2020-02-25 GE               72               0        0            0           0            0               0           0
#> 2 2020-02-25 TI                0               1        0            0           0            0               0           0
#> 3 2020-02-26 GE              178               1        0            1           0            0               0           0
#> 4 2020-02-26 TI                0               0        0            0           0            0               0           0
#> 5 2020-02-27 BS                0               1        0            0           0            0               0           0
#> 6 2020-02-27 FL                3               0        0            0           0            0               0           0
```
