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
  system('cp -r misc/. /home/fdrennan/docker_api')
  system('cp -r R/plumber.R /home/fdrennan/docker_api/plumber.R')
  # docker run --rm -d -p 8000:8000 -v `pwd`/plumber.R:/plumber.R dockerfile /plumber.R
  # cd /home/fdrennan/docker_api
}

#' @export redshift_connector
redshift_connector <- function() {
  con <- dbConnect(PostgreSQL(),
                   dbname   = 'musicdb',
                   host     = '18.220.132.82',
                   port     = 5432,
                   user     = "postgres",
                   password = "postgres")
  con
}

#' @export create_question
create_question <- function(
  chapter         = NA,
  question_number = NA,
  question_text   = NA,
  s3_audio_loc    = NA
) {

  chapter = as.numeric(chapter)
  question_number = as.numeric(question_number)

  con <- redshift_connector()

  question <-
    tibble(
      chapter         = chapter,
      question_number = question_number,
      question_text   = question_text,
      s3_audio_loc    = s3_audio_loc,
      time_added      = Sys.time()
    )

  query <- '
    SELECT
      chapter, question_number
    FROM
      questions
    WHERE
    '
  loc = paste0("  chapter = ", chapter, " AND question_number = ", question_number, collapse = " ")
  query <- paste0(query , loc)
  existing_data <- tbl(con, sql(query)) %>% as.data.frame
  if(nrow(existing_data) == 0) {
    dbWriteTable(conn = con,
                 name = "questions",
                 value = question,
                 append = TRUE,
                 row.names = FALSE)

  } else {
    query <-
      paste0(
        '
      UPDATE
        questions
      SET
        question_text = \'', question_text, '\',
        s3_audio_loc = \'', s3_audio_loc, '\'', ',
        time_added = \'', Sys.time(), '\'
      WHERE
        chapter = ', chapter, ' AND question_number = ', question_number
      )

    dbSendQuery(con, query)

  }

  dbDisconnect(con)
  return(toJSON(question, pretty = TRUE))
}

#' @export get_question
get_question <- function(
  chapter         = NA,
  question_number = NA
) {

  con <- redshift_connector()

  chapter = as.numeric(chapter)
  question_number = as.numeric(question_number)

  query <-
    paste0(
      '
      SELECT
        *
      FROM
        questions
      WHERE
        chapter = ', chapter, ' AND question_number = ', question_number
    )
  response <- tbl(con, sql(query)) %>% as.data.frame
  dbDisconnect(con)
  return(toJSON(response, pretty = TRUE))
}





