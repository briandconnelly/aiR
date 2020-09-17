api_request <- function(type = c("observation", "forecast"),
                        location = c("zipCode", "latLong"),
                        time = c("current", "historical"),
                        query) {

    type <- rlang::arg_match(type)
    location <- rlang::arg_match(location)

    url <- httr::parse_url("http://www.airnowapi.org")

    if (type == "observation") {
        url$path <- stringr::str_glue("aq/{type}/{location}/{time}")
    } else {
        url$path <- stringr::str_glue("aq/{type}/{location}")
    }

    url$query <- query
    target_url <- httr::build_url(url)

    cli::cli_alert_info(stringr::str_glue("Using URL {target_url}"))

    result <- httr::GET(url = target_url)
    httr::stop_for_status(result)
    result
}
