#' Get air quality info for a US ZIP code
#'
#' @description \code{get_zip_conditions} gets forecasted conditions for a given ZIP code
#' \lifecycle{experimental}
#' @param zip US ZIP code
#' @param distance If no data are associated with the given ZIP code, find observations from nearby reporting areas within this distance (in miles) (default: `25`)
#' @param api_key AirNow API key
#'
#' @return Tibble containing current conditions for the given ZIP code
#' @export
#' @rdname zip
#'
#' @examples
#'
get_zip_conditions <- function(zip, distance = 25, api_key = Sys.getenv("AIRNOW_API_KEY")) {
    type <- "text/csv"
    query <- stringr::str_glue("http://www.airnowapi.org/aq/observation/zipCode/current/?format={type}&zipCode={zip}&distance={distance}&API_KEY={api_key}")
    result <- httr::GET(url = query)
    httr::stop_for_status(result)

    httr::content(
        result,
        type = type,
        col_types = readr::cols(
            DateObserved = readr::col_date(),
            CategoryNumber = readr::col_integer(),
            CategoryName = readr::col_factor(levels = c("Unavailable", "Hazardous", "Very Unhealthy", "Unhealthy", "Unhealthy for Sensitive Groups", "Moderate", "Good"), ordered = TRUE)
        )
    )
}

#' @rdname zip
#' @export
#' @description \code{get_zip_forecast} gets forecasted conditions for a given ZIP code
get_zip_forecast <- function(zip, date = Sys.Date(), distance = 25, api_key = Sys.getenv("AIRNOW_API_KEY")) {
    type <- "text/csv"
    query <- stringr::str_glue("http://www.airnowapi.org/aq/forecast/zipCode/?format={type}&zipCode={zip}&date={date}&distance={distance}&API_KEY={api_key}")
    result <- httr::GET(url = query)
    httr::stop_for_status(result)

    httr::content(
        result,
        type = type,
        col_types = readr::cols(
            DateIssue = readr::col_date(),
            DateForecast = readr::col_date(),
            CategoryNumber = readr::col_integer(),
            CategoryName = readr::col_factor(levels = c("Unavailable", "Hazardous", "Very Unhealthy", "Unhealthy", "Unhealthy for Sensitive Groups", "Moderate", "Good"), ordered = TRUE)
        )
    )
}
