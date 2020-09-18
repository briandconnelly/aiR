#' Register and Configure AirNow API Tokens
#'
#' @param browse Whether to open a browser window to create/view AirNow API token (default: `TRUE` for interactive sessions, `FALSE` otherwise)
#' @note Be sure to re-start your R session after setting API token
#'
#' @export
#'
#' @examples
#' \dontrun{use_airnow()}
use_airnow <- function(browse = rlang::is_interactive()) {

    api_create_url <- "https://docs.airnowapi.org/account/request/"
    usethis::ui_todo("Follow the instructions at {api_create_url} to establish your AirNow API token")
    if (browse) {
        on.exit(utils::browseURL(api_create_url), add = TRUE)
    }

    usethis::ui_todo("Don't forget to add the code below to your {usethis::ui_path('.Renviron')} file:")

    usethis::ui_code_block(c(
        "# AirNow API configuration -------------------------",
        "AIRNOW_API_KEY=<your API key here>",
        "\n"
    ))

    usethis::edit_r_environ()
}
