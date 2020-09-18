
<!-- README.md is generated from README.Rmd. Please edit that file -->

aiR
===

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/aiR)](https://CRAN.R-project.org/package=aiR)
<!-- badges: end -->

aiR is an [R](https://www.r-project.org) package for querying and
retrieving air quality information from [AirNow](https://www.airnow.gov)
via the [AirNow API](https://airnowapi.org). Current and historical
readings as well as forecasts can be retrieved as tidy data frames.

Installation
------------

This package is changing rapidly, so it’s not quite ready for CRAN.

Development version
-------------------

To get a bug fix or to use a feature from the development version, you
can install the development version of aiR from GitHub.

    # install.packages("remotes")
    remotes::install_github("briandconnelly/aiR")

Creating an API Token
---------------------

The [AirNow API](https://airnowapi.org) is generally free to use. The
`use_airnow()` function can be used to help you create and configure
your API token.

    aiR::use_airnow()

Air Quality in Seattle
----------------------

The AirNow API allows you to query air conditions either by ZIP code or
latitude/longitude. Here, we’ll get the current conditions in Seattle by
ZIP code:

    library(aiR)

    get_conditions(zip = 98101)
    #> ℹ Using URL http://www.airnowapi.org/aq/observation/zipCode/current?zipCode=98101&format=text%2Fcsv&distance=25&API_KEY=329E30B6-1474-4644-B238-6F36E2BF1912
    #> # A tibble: 2 x 11
    #>   DateObserved HourObserved LocalTimeZone ReportingArea StateCode Latitude
    #>   <date>              <dbl> <chr>         <chr>         <chr>        <dbl>
    #> 1 2020-09-17             17 PST           Seattle-Bell… WA            47.6
    #> 2 2020-09-17             17 PST           Seattle-Bell… WA            47.6
    #> # … with 5 more variables: Longitude <dbl>, ParameterName <chr>, AQI <dbl>,
    #> #   CategoryNumber <int>, CategoryName <ord>

Code of Conduct
---------------

Please note that the aiR project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
