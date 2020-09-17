
<!-- README.md is generated from README.Rmd. Please edit that file -->

aiR
===

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/aiR)](https://CRAN.R-project.org/package=aiR)
<!-- badges: end -->

Installation
------------

You can install the released version of aiR from
[CRAN](https://CRAN.R-project.org) with:

    install.packages("aiR")

Development version
-------------------

To get a bug fix or to use a feature from the development version, you
can install the development version of aiR from GitHub.

    # install.packages("remotes")
    remotes::install_github("briandconnelly/aiR")

Example
-------

This is a basic example which shows you how to solve a common problem:

    library(aiR)

    get_zip_conditions(zip = 98105)
    #> No encoding supplied: defaulting to UTF-8.
    #> # A tibble: 2 x 11
    #>   DateObserved HourObserved LocalTimeZone ReportingArea StateCode Latitude
    #>   <date>              <dbl> <chr>         <chr>         <chr>        <dbl>
    #> 1 2020-09-17             10 PST           Seattle-Bell… WA            47.6
    #> 2 2020-09-17             10 PST           Seattle-Bell… WA            47.6
    #> # … with 5 more variables: Longitude <dbl>, ParameterName <chr>, AQI <dbl>,
    #> #   CategoryNumber <int>, CategoryName <ord>
