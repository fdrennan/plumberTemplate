#* @get /meggan
function(n=100, string = 'I love Meggan!'){
  a = rep(string, n)
  as.vector(a)
}

#* Makes a question
#*
#* @get /create_quest
#*
#* @serializer unboxedJSON
#*
#* @param chapter
#* @param question_number
#* @param question_text
#* @param s3_audio_loc
create_quest <- function(chapter            = NA,
                            question_number = NA,
                            question_text   = NA,
                            s3_audio_loc    = NA) {
  # 18.220.132.82/create_quest?chapter=1&question_number=1&question_text="Hello"&s3_audio_loc="jalsd"
  require(plumberTemplate)
  require(tictoc)

  # dummy comment for testing auto-deploy, test 2

  # Build the response object (list will be serialized as JSON)
  response <- list(statusCode = 200,
                   data = "",
                   message = "sucess",
                   console = list(
                     args = list(
                       chapter         = chapter,
                       question_number = question_number,
                       question_text   = question_text,
                       s3_audio_loc    = s3_audio_loc
                     ),
                     runtime = 0
                   )
  )

  response <- tryCatch(
    {
      # Run the algorithm
      tic()
      response$data <- create_question(
        chapter         = chapter,
        question_number = question_number,
        question_text   = question_text,
        s3_audio_loc    = s3_audio_loc
      )
      timer <- toc(quiet = T)
      response$console$runtime <- as.numeric(timer$toc - timer$tic)

      return(response)
    },
    error = function(err) {
      response$statusCode <- 400
      response$message <- paste(err)
      return(response)
    }
  )
  return(response)
}


# 18.220.132.82/get_quest?question_number=1&chapter=1

#* Returns question data.
#*
#* @get /get_quest
#*
#* @serializer unboxedJSON
#*
#* @param chapter
#* @param question_number
get_quest <- function(chapter         = NA,
                      question_number = NA) {

  require(plumberTemplate)
  require(tictoc)

  # Build the response object (list will be serialized as JSON)
  response <- list(statusCode = 200,
                   data = "",
                   message = "sucess",
                   console = list(
                     args = list(
                       chapter         = chapter,
                       question_number = question_number
                     ),
                     runtime = 0
                   )
  )

  response <- tryCatch(
    {
      # Run the algorithm
      tic()
      response$data <- get_question(chapter = chapter, question_number = question_number)
      timer <- toc(quiet = T)
      response$console$runtime <- as.numeric(timer$toc - timer$tic)

      return(response)
    },
    error = function(err) {
      response$statusCode <- 400
      response$message <- paste(err)
      return(response)
    }
  )

  return(response)
}


#* Returns flight data.
#*
#* @get /get_flights
#*
#* @serializer unboxedJSON
#*
#* @param n
get_flights <- function(n         = NA) {

  require(plumberTemplate)
  return_flights <- function(n = 1) {
    n = as.numeric(n)
    con = redshift_connector()

    flights = tbl(con, in_schema("public", 'p_flights'))

    counts <- flights %>%
      group_by(year, month, day) %>%
      summarise(n = n()) %>%
      collect

    counts <- sample_frac(counts, n)

    dbDisconnect(con)

    toJSON(counts, pretty = TRUE)
  }
  require(tictoc)

  # Build the response object (list will be serialized as JSON)
  response <- list(statusCode = 200,
                   data = "",
                   message = "sucess",
                   console = list(
                     args = list(
                       n         = n
                     ),
                     runtime = 0
                   )
  )

  response <- tryCatch(
    {
      # Run the algorithm
      tic()
      response$data <- return_flights(n = n)
      timer <- toc(quiet = T)
      response$console$runtime <- as.numeric(timer$toc - timer$tic)

      return(response)
    },
    error = function(err) {
      response$statusCode <- 400
      response$message <- paste(err)
      return(response)
    }
  )

  return(response)
}
