#' Get current conditions for a ZIP code
#'
#' @param zip US ZIP code
#' @param distance If no data are associated with the given ZIP code, find observations from nearby reporting areas within this distance (in miles) (default: `25`)
#' @param api_key AirNow API key
#'
#' @return Tibble containing current conditions for the given ZIP code
#' @export
#'
#' @examples
get_current_conditions_zip <- function(zip, distance = 25, api_key = Sys.getenv("AIRNOW_API_KEY")) {
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
