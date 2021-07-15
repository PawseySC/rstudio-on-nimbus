# Automated deployment of RStudio

## Summary
This repository covers the scripts for running RStudio with Ansible on cloud services. The RStudio Dockerfile is written based off Rocker/Tidyverse - which is handy for bioinformatics users, with changes made to the read permissions of RStudio server paths to enable running of RStudio interactively. The container is first built with Docker, then pulled as a Singularity image. This allows the image to be used on HPC if required. 

## How to
When the Ansible script is run, the user will be prompted to enter any R packages or Bioconductor packages that is required. While libraries can be installed post-container build, it is encouraged to build them into the container for software dependency efficiencies.

    git clone https://github.com/audreystott/ansible-rstudio.git
    cd ansible-rstudio
    ansible-playbook ansible-rstudio.yaml -i vars_list
