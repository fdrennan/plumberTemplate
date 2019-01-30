FROM trestletech/plumber
MAINTAINER Docker User <docker@user.org>

RUN apt-get update -qq && apt-get install -y \
  git-core \
  libssl-dev \
  default-jdk \
  libcurl4-openssl-dev \
  libxml2-dev

RUN R CMD javareconf


RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('lubridate')"
RUN R -e "install.packages('xlsx')"
RUN R -e "install.packages('devtools')"
RUN apt-get install libpq-dev -y
RUN R -e "install.packages('RPostgreSQL')"
RUN R -e "install.packages('DBI')"
RUN R -e "install.packages('jsonlite')"
RUN R -e "install.packages('tictoc')"
RUN R -e "install.packages('fortunes')"
RUN R -e "install.packages('keras')"
RUN R -e "install.packages('fields')"

RUN apt-get update -qq && apt-get install -y \
  libtiff5-dev

RUN R -e "install.packages('tiff')"
RUN R -e "install.packages('OpenImageR')"

RUN R -e 'devtools::install_github("fdrennan/plumberTemplate", auth_token = "0dbf964ae840cb1259e1ecbe5edaabb60bc273b5", ref = "v1")'


EXPOSE 8000
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000)"]
CMD ["/app/plumber.R"]
