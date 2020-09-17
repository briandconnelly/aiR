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

    get_airnow_data(
        type = "forecast",
        zip = zip,
        latitude = latitude,
        longitude = longitude,
        date = date,
        distance = distance,
        api_key = api_key
    )
}
