#' Get air quality conditions

#' @description
#' \lifecycle{experimental}
#'
#' `get_conditions` gets forecast conditions for a given ZIP code or latitude/longitude pair
#'
#' @param zip US ZIP code
#' @param latitude TODO
#' @param longitude TODO
#' @param date Date at which to observe historical conditions. If not provided, current conditions will be returned.
#' @param distance If no data are associated with the given ZIP code, find observations from nearby reporting areas within this distance (in miles) (default: `25`)
#' @param api_key AirNow API key. By default, the `AIRNOW_API_KEY` environment variable is used.

#'
#' @note API keys can be created by signing up for an account at [https://docs.airnowapi.org](https://docs.airnowapi.org)
#'
#' @return Tibble containing current conditions for the given location
#' @export
#'
#' @examples
#' \dontrun{
#' get_conditions(zip = 90210)
#' }
get_conditions <- function(zip = NULL,
                           latitude = NULL,
                        longitude = NULL,
                               date = NULL,
                               distance = 25,
                               api_key = Sys.getenv("AIRNOW_API_KEY")) {


    if (!is.null(zip)) {
        location = "zipCode"
        query <- list(zipCode = zip)

        if (!is.null(latitude) | !is.null(longitude)) {
            rlang::warn("Ignoring 'latitude' and 'longitude' parameters")
        }

    } else if (!is.null(latitude) & !is.null(longitude)) {
        location <- "latLong"
        query <- list(latitude = latitude, longitude = longitude)
    } else {
        rlang::abort("Must provide either latitude/longitude or ZIP code")
    }

    if (is.null(date)) {
        date <- Sys.Date()
        target_time <- "current"
    } else {
        target_time <- "historical"
        if (!stringr::str_ends(date, "T00-0000")) {
            date <- stringr::str_glue("{date}T00-0000")
        }
    }
    # TODO check for future dates?

    result <- api_request(
        type = "observation",
        location = location,
        time = target_time,
        query = append(
            query,
            list(
                format = "text/csv",
                distance = distance,
                date = date,
                API_KEY = api_key
            )
        )
    )

    httr::content(
        result,
        type = "text/csv",
        encoding = "UTF-8",
        col_types = readr::cols(
            DateObserved = readr::col_date(),
            CategoryNumber = readr::col_integer(),
            CategoryName = readr::col_factor(levels = c("Unavailable", "Hazardous", "Very Unhealthy", "Unhealthy", "Unhealthy for Sensitive Groups", "Moderate", "Good"), ordered = TRUE)
        )
    )
}

