get_airnow_data <- function(type = c("observation", "forecast"),
                            zip = NULL,
                            latitude = NULL,
                            longitude = NULL,
                            date = Sys.Date(),
                            distance = 25,
                            api_key = Sys.getenv("AIRNOW_API_KEY")) {

    type <- rlang::arg_match(type)

    assertthat::assert_that(
        assertthat::is.number(distance),
        distance >= 0
    )

    if (!is.null(zip)) {
        if (!stringr::str_detect(as.character(zip), "^\\d{5}$")) {
            rlang::abort(stringr::str_glue("'{zip}' does not appear to be a valid 5-digit US ZIP code"))
        }

        location <- "zipCode"
        query <- list(zipCode = zip)

        if (!is.null(latitude) | !is.null(longitude)) {
            rlang::warn("Ignoring 'latitude' and 'longitude' parameters")
        }
    } else if (!is.null(latitude) & !is.null(longitude)) {
        assertthat::assert_that(
            assertthat::is.number(latitude),
            latitude >= -90,
            latitude < 90,
            assertthat::is.number(longitude),
            longitude >= -180,
            longitude <= 180
        )

        location <- "latLong"
        query <- list(latitude = latitude, longitude = longitude)
    } else {
        rlang::abort("Must provide either latitude/longitude or ZIP code")
    }

    result <- api_request(
        type = type,
        location = location,
        time = "current", # TODO handle time
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

    if (type == "observation") {
        col_types <- readr::cols(
            DateObserved = readr::col_date(),
            CategoryNumber = readr::col_integer(),
            CategoryName = readr::col_factor(levels = c("Unavailable", "Hazardous", "Very Unhealthy", "Unhealthy", "Unhealthy for Sensitive Groups", "Moderate", "Good"), ordered = TRUE)
        )
    } else if (type == "forecast") {
        col_types <- readr::cols(
            DateIssue = readr::col_date(),
            DateForecast = readr::col_date(),
            CategoryNumber = readr::col_integer(),
            CategoryName = readr::col_factor(levels = c("Unavailable", "Hazardous", "Very Unhealthy", "Unhealthy", "Unhealthy for Sensitive Groups", "Moderate", "Good"), ordered = TRUE)
        )
    }

    httr::content(
        result,
        type = "text/csv",
        encoding = "UTF-8",
        col_types = col_types
    )
}
