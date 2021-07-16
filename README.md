# Automated deployment of RStudio

## Summary
This repository covers the scripts for running RStudio with Ansible on cloud services. The RStudio Dockerfile is based off Rocker/Tidyverse - which is handy for bioinformatics users, with changes made to the read permissions of RStudio server paths to enable running of RStudio interactively. The container is first built with Docker, then pulled as a Singularity image. This allows the image to be used on HPC if required. 

## Quick start
This is an interactive deployment, such that when the Ansible playbook script is run, the user will be prompted to enter any R packages or Bioconductor packages that is required. While libraries can be installed post-container build, it is encouraged to build them into the container for software dependency efficiencies.

**Note that the time taken for this deployment varies, and if run for the first time, will require at least 5-10 minutes for the RStudio container to be built.**

### Prerequisite
This Ansible playbook works on Ubuntu 18.04 and Ubuntu 20.04. Other operating systems and versions will require testing. Raise a ticket if you face issues running this with other operating systems.

Ansible needs to be installed on the machine.

### Install Ansible (if it is not already installed)

    sudo apt install --yes software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install --yes ansible
    
### Clone this repo and run the Ansible script

    git clone https://github.com/audreystott/ansible-rstudio.git
    cd ansible-rstudio
    ansible-playbook ansible-rstudio.yaml -i vars_list

## Notes
It is recommended that users change their Singularity cache directory to a volume storage, as the default is in the `/home` directory, i.e. `/home/ubuntu/.singularity/cache`. To change it, simply create a new directory and update the `$SINGULARITY_CACHEDIR` variable to it. For e.g. if the volume storage is mounted to `/data`:

    mkdir /data/singularity_cache
    SINGULARITY_CACHEDIR=/data/singularity_cache

It is also good to clean the cache from time to time - when image pulls are completed. To clean it, first list and check that you are happy to remove the cache:

    singularity cache list
    singularity cache clean

    ** Use sudo if you did not change the $SINGULARITY_CACHEDIR variable **
    sudo singularity cache list
    sudo singularity cache clean