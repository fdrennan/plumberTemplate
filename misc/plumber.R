#' @filter cors
cors <- function(req, res) {

  res$setHeader("Access-Control-Allow-Origin", "*")

  if (req$REQUEST_METHOD == "OPTIONS") {
    res$setHeader("Access-Control-Allow-Methods","*")
    res$setHeader("Access-Control-Allow-Headers", req$HTTP_ACCESS_CONTROL_REQUEST_HEADERS)
    res$status <- 200
    return(list())
  } else {
    plumber::forward()
  }

}

#* Returns flight data.
#* @get /get_flights_plot
#*
#* @param n
#* @param from
#* @param to
#* @param plot_data
#* @png
get_flights <- function(n = 1,
                        from = "2013-01-01",
                        to = "2014-01-01",
                        plot_data = TRUE) {
  # yadd yadda
  # ..
  # removed code
  return(response)
}

