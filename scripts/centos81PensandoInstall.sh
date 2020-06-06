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


echolog "$(tput setaf 4) $(tput setab 7)Check for Updates...$(tput sgr 0)"
sudo yum check-update || exit 1
echo "done.."
echolog "$(tput setaf 4) $(tput setab 7)Install Kernel Devel Package...$(tput sgr 0)"
sudo yum -y install kernel-devel || exit 1
echo "done.."
echolog "$(tput setaf 4) $(tput setab 7)Install Kernel Headers...$(tput sgr 0)"
sudo yum -y install kernel-headers || exit 1
echo "done.."
echolog "$(tput setaf 4) $(tput setab 7)Update Kernel...$(tput sgr 0)"
sudo yum -y install kernel || exit 1 
echo "done.."
echolog "$(tput setaf 4) $(tput setab 7)build-essentials...$(tput sgr 0)"
sudo yum -y install gcc gcc-c++ kernel-devel make || exit 1
echo "done.."
echolog "$(tput setaf 4) $(tput setab 7)Development Tools...$(tput sgr 0)"
sudo yum -y groupinstall "Development Tools" || exit 1
echo "done.."

# I don't we need this 
#echolog "$(tput setaf 4) $(tput setab 7)Install Kernel-devel package...$(tput sgr 0)"
#sudo wget https://rpmfind.net/linux/centos/8.1.1911/BaseOS/x86_64/os/Packages/kernel-devel-4.18.0-147.8.1.el8_1.x86_64.rpm || exit 1
#sudo rpm -ivh kernel-devel-4.18.0-147.8.1.el8_1.x86_64.rpm || exit 1
#echo "done"


echolog "$(tput setaf 4) $(tput setab 7)Install Requirements for Driver update...$(tput sgr 0)"
sudo yum -y install elfutils-libelf-devel || exit 1
sudo yum -y install libtool automake autoconf cmake gcc libnl3-devel libudev-devel make pkgconfig valgrind-devel || exit 1
sudo yum -y install pciutils || exit 1 
sudo yum -y install lshw || exit 1
echo "done.."


if [ -f drivers-linux-eth.tar.xz ]; then
echo "Driver is already downloaded"
else
echolog "$(tput setaf 4) $(tput setab 7)Get the Pensando Driver Package...$(tput sgr 0)"
sudo wget http://${VAR_NGINX}${VAR_PEN_DRIVER} 
fi

echolog "$(tput setaf 4) $(tput setab 7)Extract the Pensando Driver...$(tput sgr 0)"
sudo xz -d ${VAR_PEN_DRIVER}
sudo tar xvf drivers-linux-eth.tar


echolog "$(tput setaf 4) $(tput setab 7)Install the Pensando driver...$(tput sgr 0)"
cd drivers-linux-eth/
sudo ./build.sh 
echo "pause 5 seconds"
sudo sleep 5
sudo insmod drivers/eth/ionic/ionic.ko 


echolog "$(tput setaf 4) $(tput setab 7)Test for Driver settings...$(tput sgr 0)"
fileIonic=/etc/sysconfig/modules/ionic.modules
if [ -f fileIonic ]; then
	echo "$fileIonic exists"
else
echolog "Ooops appears the file is missing, let's write it"
sudo cat>>/etc/sysconfig/modules/ionic.modules<<EOF 
insmod ~/drivers-linux-eth/drivers/eth/ionic/ionic.ko
EOF
fi

sudo chmod 755 /etc/sysconfig/modules/ionic.modules

echolog "Changed ionic permissions.."


echolog "$(tput setaf 4) $(tput setab 7)DONE...Confirm Pensando driver is loaded...$(tput sgr 0)"
