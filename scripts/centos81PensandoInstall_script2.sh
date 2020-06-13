#!/usr/bin/env bash
set -e
set -o pipefail

# Edward Bustos 
# SHELL Script to bootstrap CentOS 8.1 and install the Pensando Driver
# Assume you are running this as Root from your home directory or cd ~
# Depending on whether you are on the LR1 or LR0 you may have to adjust the PROXY SERVER
# Confirm the Docker Container (NGINZ) is running if you can't download the DRIVER  

NOW=$(date +"%T-%D")
VAR_PROXY="http://proxy.compaq.com:8080"
VAR_PEN_DRIVER="drivers-linux-eth.tar.xz"
VAR_NGINX="15.115.118.72:8081/"
log_file="log_InstallPensandoDriver.log"

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
echolog "Proxy appears to be available"
else
echolog "Ooops appears to be missing, let's write it"
sudo cat>>/etc/environment<<EOF 
http_proxy="${VAR_PROXY}"
https_proxy="${VAR_PROXY}"
no_proxy="localhost,127.0.0.1,::1,.hpqcorp.net,hpecorp.net"
EOF
fi
echolog "done..."


echolog "$(tput setaf 4) $(tput setab 7)Test for YUM settings..$(tput sgr 0)"
fileYum=/etc/yum.conf
if grep -q proxy $fileYum
then
echolog "Proxy appears to be available"
else
echolog "Ooops appears to be missing, let's write it"
sudo cat>>/etc/yum.conf<<EOF
proxy="${VAR_PROXY}"
EOF
fi
echolog "done.."


if [ -f drivers-linux-eth.tar.xz ]; then
echolog "Driver is already downloaded"
else
echolog "$(tput setaf 4) $(tput setab 7)Get the Pensando Driver Package...$(tput sgr 0)"
sudo wget http://${VAR_NGINX}${VAR_PEN_DRIVER} 
fi
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Extract the Pensando Driver...$(tput sgr 0)"
if [ -f drivers-linux-eth.tar ]; then
echo "Driver is already downloaded"
else
sudo xz -d ${VAR_PEN_DRIVER}
sudo tar xvf drivers-linux-eth.tar
fi
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Install the Pensando driver...$(tput sgr 0)"
cd ~/drivers-linux-eth/
sudo ./build.sh
echolog "done.."

echolog "Creating the directory where to put the driver"
sudo mkdir -p /lib/modules/`uname -r`/extra
echolog "done.."

echolog "Copying the file to the correct location"
cp -R ~/drivers-linux-eth/drivers/eth/ionic/* /lib/modules/`uname -r`/extra
depmod -a
echolog "done.."

echolog "Pause for 3 seconds to modprobe ionic"
sudo sleep 3
modprobe ionic 
echolog "done.."


echolog "$(tput setaf 4) $(tput setab 7)DONE...................................................$(tput sgr 0)"
echolog "$(tput setaf 4) $(tput setab 7)DONE...Confirm Pensando driver is loaded...............$(tput sgr 0)"
echolog "$(tput setaf 4) $(tput setab 7)DONE...Confirm Pensando loads after a system reboot....$(tput sgr 0)"
