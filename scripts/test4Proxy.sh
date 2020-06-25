#!/usr/bin/env bash
set -e
set -o pipefail

# Using this script on the LR1 which requires different proxy settings that LR0
# NOTE: Assume you are running this from your home directory or cd ~...for the driver to load. 

NOW=$(date +"%T-%D")
VAR_PROXY="http://proxy.compaq.com:8080"
VAR_PEN_DRIVER="drivers-linux-eth.tar.xz"
VAR_NGINX="15.115.118.72:8081/"

log_file="log_file.log"
echolog()
(
 echo "$@"
 echo "$@" >> $log_file
)

echolog "Starting log $NOW...."


echolog "$(tput setaf 4) $(tput setab 7)Test for Proxy settings...$(tput sgr 0)"
fileEnv=/etc/environment
if grep -q proxy $fileEnv;
then
echo "Proxy appears to be available"
else
echolog "Ooops appears to be missing, let's write it"
sudo cat>>/etc/environment<<EOF 
http_proxy="${VAR_PROXY}"
https_proxy="${VAR_PROXY}"
no_proxy="localhost,127.0.0.1,::1,.hpqcorp.net,hpecorp.net"
EOF
fi
echo "done..."



echolog "$(tput setaf 4) $(tput setab 7)DONE...Confirm Proxy is set...$(tput sgr 0)"
