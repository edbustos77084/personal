#!/usr/bin/env bash
set -e
set -o pipefail

# Using this script on the LR1 which requires different proxy settings that LR0
# NOTE: Assume you are running this from your home directory or cd ~...for the driver to load. 

NOW=$(date +"%T-%D")
VAR_PROXY="http://proxy.compaq.com:8080"
VAR_PEN_DRIVER="drivers-linux-eth.tar.xz"
VAR_NGINX="15.115.118.72:8081/"

log_file="log_file2.log"
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


echolog "$(tput setaf 4) $(tput setab 7)Test for YUM settings..$(tput sgr 0)"
fileYum=/etc/yum.conf
if grep -q proxy $fileYum
then
echo "Proxy appears to be available"
else
echolog "Ooops appears to be missing, let's write it"
sudo cat>>/etc/yum.conf<<EOF
proxy="${VAR_PROXY}"
EOF
fi
echo "done.."


if [ -f drivers-linux-eth.tar.xz ]; then
echo "Driver is already downloaded"
else
echolog "$(tput setaf 4) $(tput setab 7)Get the Pensando Driver Package...$(tput sgr 0)"
sudo wget http://${VAR_NGINX}${VAR_PEN_DRIVER} 
fi


echolog "$(tput setaf 4) $(tput setab 7)Extract the Pensando Driver...$(tput sgr 0)"
if [ -f drivers-linux-eth.tar ]; then
echo "Driver is already downloaded"
else
sudo xz -d ${VAR_PEN_DRIVER}
sudo tar xvf drivers-linux-eth.tar
fi

echo "$(tput setaf 4) $(tput setab 7)Install the Pensando driver...$(tput sgr 0)"
cd ~/drivers-linux-eth/
sudo ./build.sh

echo "Creating the directory where to put the driver"
sudo mkdir -p /lib/modules/`uname -r`/extra

echo "Copying the file to the correct location"
cp -R ~/drivers-linux-eth/drivers/eth/ionic/ /lib/modules/`uname -r`/extra


echo "Pause 3 seconds"
sudo sleep 3
modprobe ionic 


#echolog "$(tput setaf 4) $(tput setab 7)Test for Driver settings...$(tput sgr 0)"
#fileIonic=/etc/sysconfig/modules/ionic.modules
#if [ -f "$fileIonic" ]; then
#	echo "$fileIonic exists"
#else
#echolog "Ooops appears the file is missing, let's write it"
#sudo cat>/etc/sysconfig/modules/ionic.modules<<EOF 
#!/bin/sh
#insmod ~/drivers-linux-eth/drivers/eth/ionic/ionic.ko
#EOF
#fi

#sudo chmod 755 /etc/sysconfig/modules/ionic.modules

#echolog "Changed ionic permissions.."


echolog "$(tput setaf 4) $(tput setab 7)DONE...................................................$(tput sgr 0)"
echolog "$(tput setaf 4) $(tput setab 7)DONE...Confirm Pensando driver is loaded...............$(tput sgr 0)"
echolog "$(tput setaf 4) $(tput setab 7)DONE...Confirm Pensando loads after a system reboot....$(tput sgr 0)"
