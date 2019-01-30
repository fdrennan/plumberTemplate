# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

#' @export update_docker
update_docker <- function() {
  system('cp -r misc/. /home/fdrennan/plumberTemplate')
  system('cp -r R/plumber.R /home/fdrennan/plumberTemplate/misc/plumber.R')
}

#' @export redshift_connector
redshift_connector <- function() {
  con <- dbConnect(PostgreSQL(),
                   dbname   = 'website',
                   host     = 'drenr.com',
                   port     = 5432,
                   user     = "website",
                   password = "thirdday1")
  con
}


#' @export return_flights
return_flights <- function(n = 1,
                           plot_data = FALSE,
                           from = "2013-01-01",
                           to = '2014-01-01') {
  n = as.numeric(n)
  con = redshift_connector()

  flights = tbl(con, in_schema("public", 'p_flights'))

  counts <- flights %>%
    group_by(year, month, day) %>%
    summarise(n = n()) %>%
    collect %>%
    ungroup

  counts <- counts %>%
    mutate(date = paste0(year, '-', month, '-', day)) %>%
    select(date, n)

  counts <- sample_frac(counts, n) %>%
    mutate( date = as.Date(date)) %>%
    arrange(date) %>%
    filter(date >= from,
           date <= to)

  dbDisconnect(con)

  if (plot_data) {
    gg = ggplot(counts) +
      aes(x = date, y = n) +
      geom_line()
  } else {
    return(toJSON(counts, pretty = TRUE))
  }

  print(gg)
}

predict_number <- function(data) {

  # data = suppressWarnings(readLines('data.txt'))
  download.file('https://s3.us-east-2.amazonaws.com/kerasmods/number_data.txt', 'number_data.txt')
  data = readLines('number_data.txt')
  split <- data %>%
    str_split(",") %>%
    .[1] %>% .[[1]] %>% as.numeric %>% as.matrix()

  data = array_reshape(split, c(250, 250, 4))
  image_1 = data[,,1]
  image_1 = resizeImage(image_1, 28, 28)
  image_1 = image.smooth(image_1)$z
  image_1 = image_1/max(image_1)
  image_1 = round(image_1, 4)
  # model = model_from_json(plumberTemplate::mod)
  download.file('https://s3.us-east-2.amazonaws.com/kerasmods/model.hdf5', 'model.hdf5')
  model = load_model_hdf5('model.hdf5')
  value = predict_classes(model, array_reshape(image_1, c(1, 28, 28, 1)))
  toJSON(value)
}


