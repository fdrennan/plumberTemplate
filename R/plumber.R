#* @get /meggan
function(n=100, string = 'I love Meggan!'){
  a = rep(string, n)
  as.vector(a)
}


#* @get /create_question
function(
  chapter         = NA,
  question_number = NA,
  question_text   = NA,
  s3_audio_loc    = NA
){
  create_question(
    chapter         = chapter,
    question_number = question_number,
    question_text   = question_text,
    s3_audio_loc    = s3_audio_loc
  )
}

#* @get /get_questions
function(
  chapter         = NA,
  question_number = NA,
  question_text   = NA,
  s3_audio_loc    = NA
){
  create_question(
    chapter         = chapter,
    question_number = question_number,
    question_text   = question_text,
    s3_audio_loc    = s3_audio_loc
  )
}
