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
    get_airnow_data(
        type = "observation",
        zip = zip,
        latitude = latitude,
        longitude = longitude,
        date = date,
        distance = distance,
        api_key = api_key
    )
}
