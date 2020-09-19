#' Test AQI Values
#'
#' @description `is_aqi` tests whether a given value is a valid AQI number or not.
#' @seealso https://docs.airnowapi.org/aq101
#'
#' @param x Object to be tested
#'
#' @return Logical value indicating whether the given value
#' @export
#' @aliases is.aqi
#'
#' @examples
#' is_aqi(42)
#' is_aqi(-2)
is_aqi <- function(x) {
    assertthat::assert_that(
        assertthat::is.number(x),
        assertthat::is.scalar(x)
    )
    x >= 0 & x <= 500
}

assertthat::on_failure(is_aqi) <- function(call, env) {
    paste0(deparse(call$x), " is not a valid AQI number. AQI numbers are defined from 0 to 500, inclusive.")
}
