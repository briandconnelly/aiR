#' Categorize API numbers
#'
#' @description
#' As described in [Air Quality 101](https://docs.airnowapi.org/aq101), the AQI is divided into a number of categories that indicate the potential health impacts of air conditions.
#' For example, a value of 23 corresponds to "Good", and is displayed with a green color.
#'
#' `aqi_category` translates a given AQI number to it's category descriptor.
#'
#' @param aqi A numeric Air Quality Index (AQI) value
#' @seealso [Air Quality 101](https://docs.airnowapi.org/aq101)
#'
#' @return `aqi_category` returns a string with the AQI Category Descriptor
#' @export
#'
#' @examples
#' aqi_category(23)
aqi_category <- function(aqi) {
    aqi_category_names[aqi_category_number(aqi)]
}

#' @rdname aqi_category
#' @description `aqi_category_number` TODO
#' @return `aqi_category_number` returns a numeric value 1-6 indicating the corresponding AQI category number
#' @export
#' @examples
#' aqi_category_number(123)
aqi_category_number <- function(aqi) {
    assertthat::assert_that(
        is_aqi(aqi)
    )

    if (aqi >= 0 && aqi < 51) {
        1
    } else if (aqi >= 51 && aqi < 101) {
        2
    } else if (aqi >= 101 && aqi < 151) {
        3
    } else if (aqi >= 151 && aqi < 201) {
        4
    } else if (aqi >= 201 && aqi < 301) {
        5
    } else if (aqi >= 301 && aqi <= 500) {
        6
    }
}

#' @rdname aqi_category
#' @export
#' @description `aqi_category_color` TODO
#' @return `aqi_category_color` returns a string containing the hexidecimal color code associated with the corresponding AQI category number (e.g., `#00E400` for "Good)
#' @examples
#' aqi_category_color(23?a)
aqi_category_color <- function(aqi) {
    aqi_category_colors[aqi_category_number(aqi)]
}
