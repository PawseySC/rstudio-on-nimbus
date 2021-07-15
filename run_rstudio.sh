#!/bin/bash

pubkey_path="$1"
rstudio_password="$2"
public_ip_address=$(curl ifconfig.me)

echo '------------------------------------------------------------------------------------------- 
Run the following command on your local computer to enable port forwarding from this instance to your local computer: 

ssh -i '$pubkey_path' -N -f -L 8787:localhost:8787 ubuntu@'$public_ip_address'

Then go to a web browser and enter the following URL to run RStudio: http://localhost:8787

username=ubuntu 
password=what your entered when prompted at the start

****After exiting RStudio, close the 8787 port on your local computer****: lsof -ti:8787 | xargs kill -9
-------------------------------------------------------------------------------------------'