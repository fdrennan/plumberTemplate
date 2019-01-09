# plumber.R
library(plumberTemplate)

#* @get /meggan
function(n=100, string = 'I love Meggan!'){
  a = rep(string, n)
  as.vector(a)
}


#* @get /addTwo
function(a=10, b=10){
  as.numeric(a) + as.numeric(b)
}

#' Echo the parameter that was sent in
#' @param msg The message to echo back.
#' @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#' Plot out data from the iris dataset
#' @param spec If provided, filter the data to only this species (e.g. 'setosa')
#' @get /plot
#' @png
function(spec){
  myData <- iris
  title <- "All Species"

  # Filter if the species was specified
  if (!missing(spec)){
    title <- paste0("Only the '", spec, "' Species")
    myData <- subset(iris, Species == spec)
  }

  plot(myData$Sepal.Length, myData$Petal.Length,
       main=title, xlab="Sepal Length", ylab="Petal Length")
}

# If the URL gets called the browser will automatically download the file.
#' @serializer contentType list(type="application/octet-stream")
#' @get /rds
rest_rds = function() {
  tfile = tempfile()
  saveRDS(iris, file = tfile)
  readBin(tfile, "raw", n = file.info(tfile)$size)
}

#* @serializer contentType list(type="application/pdf")
#* @get /pdf
function(){
  tmp <- tempfile()
  pdf(tmp)
  plot(1:10, type="b")
  text(4, 8, "PDF from plumber!")
  text(6, 2, paste("The time is", Sys.time()))
  dev.off()

  readBin(tmp, "raw", n=file.info(tmp)$size)
}

#* @serializer contentType list(type="xlsx")
#* @get /USArests
function(){

  file <- 'USArrests.xlsx'
  xlsx::write.xlsx(USArrests, file=file)
  readBin(file, "raw", n=file.info(file)$size)
}
