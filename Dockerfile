FROM rocker/rstudio:4.0.3
  
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite-dev \
    libmariadbd-dev \
    libmariadbclient-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libsasl2-dev \
    && install2.r --error \
      --deps TRUE \
      tidyverse \
      dplyr \
      devtools \
      formatR \
      remotes \
      selectr \
      caTools                  

RUN R -e 'install.packages("BiocManager")'

RUN chmod a+w /var/lib/rstudio-server \
    && chmod a+w /var/lib/rstudio-server/rstudio.sqlite
