#* @get /meggan
function(n=100, string = 'I love Meggan!'){
  a = rep(string, n)
  as.vector(a)
}

#* Makes a question
#*
#* @get /create_question
#*
#* @serializer unboxedJSON
#*
#* @param chapter
#* @param question_number
#* @param question_test
#* @param s3_audio_loc
create_question <- function(chapter         = NA,
                            question_number = NA,
                            question_test   = NA,
                            s3_audio_loc    = NA) {

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
                       question_test   = question_text,
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


#* Returns question data.
#*
#* @get /get_question
#*
#* @serializer unboxedJSON
#*
#* @param chapter
#* @param question_number
get_question <- function(chapter         = NA,
                         question_number = NA) {

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
                       question_number = question_number
                     ),
                     runtime = 0
                   )
  )

  response <- tryCatch(
    {
      # Run the algorithm
      tic()
      response$data <- get_question(chapter, question_number)
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

