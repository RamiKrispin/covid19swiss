
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
cantons and the Principality of Liechtenstein (FL). The `covid19swiss`
dataset includes the following fields:

  - `date` - the timestamp of the case, a `Date` object
  - `canton` - the cantons of Switzerland and Principality of
    Liechtenstein (FL) abbreviation code
  - `type` - the type of case
  - `cases` - the number of cases corresponding to the date and case
    type fields
  - `gn_a1_code` - a canton index code for merging geometry data from
    the **rnaturalearth** package

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

More information can be found the following vignettes:

  - [Introduction to the covid19swiss Dataset]()
  - [Updating the covid19swiss Dataset]()
  - [Geospatial Visualization of Switzerland Cantons]() (non CRAN
    vignette)

Data source: [Specialist Unit for Open Government Data Canton of
Zurich](http://open.zh.ch/internet/justiz_inneres/ogd/de/daten.html),
raw data is available on the following
[repository](https://github.com/openZH/covid_19). Special thanks for all
the people that collaborate and contribute to pull the data from
multiple sources and make this data available\!

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
bases. The `update_swiss_data` function enables a simple refresh of the
installed package datasets with the most updated version on Github:

``` r
library(covid19swiss)

update_swiss_data()
```

More information about updating the data is available on this
[vignette](https://covid19r.github.io/covid19swiss/articles/update_the_data.html)

**Note:** must restart the R session after using the `update_swiss_data`
function in order to have the updates available

## Usage

``` r
data(covid19swiss)

head(covid19swiss)
#>         date canton            type cases gn_a1_code
#> 1 2020-02-25     GE    total_tested    72      CH.GE
#> 2 2020-02-25     GE total_confirmed     0      CH.GE
#> 3 2020-02-25     GE        new_hosp    NA      CH.GE
#> 4 2020-02-25     GE    current_hosp     0      CH.GE
#> 5 2020-02-25     GE     current_icu     0      CH.GE
#> 6 2020-02-25     GE    current_vent     0      CH.GE
```

### Wide format

``` r
library(tidyr)

covid19swiss_wide <- covid19swiss %>% 
  pivot_wider(names_from = type, values_from = cases)

head(covid19swiss_wide)
#> # A tibble: 6 x 11
#>   date       canton gn_a1_code total_tested total_confirmed new_hosp current_hosp current_icu current_vent total_recovered total_death
#>   <date>     <chr>  <chr>             <int>           <int>    <int>        <int>       <int>        <int>           <int>       <int>
#> 1 2020-02-25 GE     CH.GE                72               0       NA            0           0            0              NA          NA
#> 2 2020-02-25 TI     CH.TI                NA               1       NA           NA          NA           NA              NA          NA
#> 3 2020-02-26 GE     CH.GE               178               1       NA            1           0            0              NA          NA
#> 4 2020-02-26 TI     CH.TI                NA              NA       NA           NA          NA           NA              NA          NA
#> 5 2020-02-27 BS     CH.BS                NA               1       NA           NA          NA           NA              NA          NA
#> 6 2020-02-27 FL     <NA>                  3              NA       NA           NA          NA           NA              NA          NA
```

## Missing values

The data is collected from multiple resources on the canton level, and
not necessarily each data resource provides the same field. Therefore,
some fields, such as total recovered or total tested may not be
available at this point for some cantons and are marked as missing
values (i.e., `NA`).

## Contributing

Please submit [issues](https://github.com/Covid19R/covid19swiss/issues)
and [pull requests](https://github.com/Covid19R/covid19swiss/pulls) with
any package improvements\!

Please note that the ‘covid19swiss’ project is released with a
[Contributor Code of
Conduct](https://github.com/Covid19R/covid19swiss/blob/master/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.
