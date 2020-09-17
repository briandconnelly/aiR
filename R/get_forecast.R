#' Get air quality forecast

#' @description
#' \lifecycle{experimental}
#'
#' `get_forecast` gets forecast conditions for a given ZIP code or latitude/longitude pair
#'
#' @inheritParams get_conditions
#'
#' @note API keys can be created by signing up for an account at [https://docs.airnowapi.org](https://docs.airnowapi.org)
#'
#' @return Tibble containing current conditions for the given location
#' @export
#'
#' @examples
#' \dontrun{
#' get_forecast(zip = 90210)
#' get_forecast(latitude = 47, longitude = -122)
#' }
get_forecast <- function(zip = NULL,
                         latitude = NULL,
                         longitude = NULL,
                         date = Sys.Date(),
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

    result <- api_request(
        type = "forecast",
        location = location,
        time = "current",
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
            DateIssue = readr::col_date(),
            DateForecast = readr::col_date(),
            CategoryNumber = readr::col_integer(),
            CategoryName = readr::col_factor(levels = c("Unavailable", "Hazardous", "Very Unhealthy", "Unhealthy", "Unhealthy for Sensitive Groups", "Moderate", "Good"), ordered = TRUE)
        )
    )
}
