#' Get air quality info for a US ZIP code
#'
#' @description \code{get_zip_conditions} gets forecasted conditions for a given ZIP code
#' \lifecycle{experimental}
#' @param zip US ZIP code
#' @param date Date at which to observe historical conditions. If not provided, current conditions will be returned.
#' @param distance If no data are associated with the given ZIP code, find observations from nearby reporting areas within this distance (in miles) (default: `25`)
#' @param api_key AirNow API key
#'
#' @return Tibble containing current conditions for the given ZIP code
#' @export
#' @rdname zip
#'
#' @examples
#'
get_zip_conditions <- function(zip,
                               date = NULL,
                               distance = 25,
                               api_key = Sys.getenv("AIRNOW_API_KEY")) {
    type <- "text/csv"
    query <- stringr::str_glue("http://www.airnowapi.org/aq/observation/zipCode/current/?format={type}&zipCode={zip}&distance={distance}&API_KEY={api_key}")
    result <- httr::GET(url = query)
    httr::stop_for_status(result)

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
        location = "zipCode",
        time = target_time,
        query = list(
            format = "text/csv",
            zipCode = zip,
            distance = distance,
            date = date,
            API_KEY = api_key
        )
    )

    httr::content(
        result,
        type = type,
        encoding = "UTF-8",
        col_types = readr::cols(
            DateObserved = readr::col_date(),
            CategoryNumber = readr::col_integer(),
            CategoryName = readr::col_factor(levels = c("Unavailable", "Hazardous", "Very Unhealthy", "Unhealthy", "Unhealthy for Sensitive Groups", "Moderate", "Good"), ordered = TRUE)
        )
    )

    # TODO add attributes to tibble?
}

#' @rdname zip
#' @export
#' @description \code{get_zip_forecast} gets forecasted conditions for a given ZIP code
get_zip_forecast <- function(zip,
                             date = Sys.Date(),
                             distance = 25,
                             api_key = Sys.getenv("AIRNOW_API_KEY")) {

    result <- api_request(
        type = "forecast",
        location = "zipCode",
        time = "current",
        query = list(
            format = "text/csv",
            zipCode = zip,
            distance = distance,
            date = date,
            API_KEY = api_key
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

    # TODO add attributes to tibble?
}
