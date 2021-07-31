# Automated deployment of RStudio

## Summary
This repository covers the scripts for running RStudio with Ansible on cloud services. The RStudio Dockerfile is based off Rocker/Tidyverse - which is handy for bioinformatics users, with changes made to the read permissions of RStudio server paths to enable running of RStudio interactively. The container is first built with Docker, then pulled from the Docker daemon to build a Singularity container. This allows the container to be used on HPC if required. 

## Before you start

This deployment uses Singularity to build an RStudio Singularity container.

It is recommended that users change their Singularity cache directory to a storage volume, as the default is in the `/home` directory, i.e. `/home/ubuntu/.singularity/cache`, which can run out of space quickly. To change it, simply create a new directory and update the `$SINGULARITY_CACHEDIR` variable to it. It is also recommended that you have your storage volume [mounted to a directory named `/data`](https://support.pawsey.org.au/documentation/display/US/Attach+a+Storage+Volume).
    
    # Skip this step if you do not have a storage volume.
    mkdir /data/singularity_cache
    SINGULARITY_CACHEDIR=/data/singularity_cache


## Quick start
This is an interactive deployment, such that when the Ansible playbook script is run, the user will be prompted to enter any R packages or Bioconductor packages that is required. While libraries can be installed post-container build, it is encouraged to build them into the container for software dependency efficiencies.

**Note that the time taken for this deployment varies, and if run for the first time, will require at least 10 minutes for the RStudio container to be built and pulled as a Singularity image. Ensure that your computer does not go to sleep during this time.**

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

    #If you make a mistake answering the prompts, cancel (control+c) and rerun the `ansible-playbook` command.

## Ensure RStudio is running as intended

Once you have run the above, you will have followed instructions to create a port forwarding on your computer, then open a web browser to localhost:8787 to login to RStudio.

On the RStudio console, check that your library path is correct as below:

    # If the R version = 3.6.3, you should see:
    > .libPaths()
    [1] "/usr/local/lib/R/site-library" "/usr/local/lib/R/library"     
    [3] "/home/rstudio/library"

    # If the R version >= 4.0.0, you should see:
    > .libPaths()
    [1] "/home/rstudio/R/x86_64-pc-linux-gnu-library/4.1"
    [2] "/usr/local/lib/R/site-library"                  
    [3] "/usr/local/lib/R/library" 

From here, you can load the libraries you require, add data to `/home/rstudio`, and run the analyses you require. Note that `/home/rstudio` on RStudio corresponds to `/data/rstudio` on your Nimbus instance.

## Notes

It is advisable to clean the Singularity cache from time to time - when image pulls are completed. To clean it, first list and check that you are happy to remove the cache:

    singularity cache list
    singularity cache clean

    ** Use sudo if you did not change the $SINGULARITY_CACHEDIR variable **
    sudo singularity cache list
    sudo singularity cache clean