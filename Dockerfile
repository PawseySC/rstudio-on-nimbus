FROM rocker/tidyverse:4.0.3
  
RUN install2.r --error \
      --deps TRUE \
      caTools                

RUN R -e 'install.packages("BiocManager")'

RUN chmod a+w /var/lib/rstudio-server \
    && chmod a+w /var/lib/rstudio-server/rstudio.sqlite

