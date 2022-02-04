FROM rocker/tidyverse:4.0.3

RUN sudo apt-get update && sudo apt-get -y install libghc-bzlib-dev liblzma-dev
  
RUN install2.r --error \
      --deps TRUE \
      caTools                

RUN R -e 'install.packages("BiocManager")'

RUN chmod a+w /var/lib/rstudio-server

