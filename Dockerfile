FROM rocker/rstudio:4.1.0

RUN sudo apt-get update && sudo apt-get -y install libghc-bzlib-dev liblzma-dev
  
RUN install2.r --error \
      --deps TRUE \
      caTools              

RUN R -e 'install.packages("BiocManager")'

RUN chown -R root:root /var/lib/rstudio-server && chmod -R g=u /var/lib/rstudio-server

