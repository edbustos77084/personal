#!/usr/bin/env bash
set -e
set -o pipefail

# Using this script on the LR1 which requires different proxy settings that LR0
# NOTE: Assume you are running this from your home directory or cd ~...for the driver to load. 

NOW=$(date +"%T-%D")
VAR_PROXY="http://proxy.compaq.com:8080"
VAR_PEN_DRIVER="drivers-linux-eth.tar.xz"
VAR_NGINX="15.115.118.72:8081/"
log_file="logProxyKernelheaders.log"

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


echolog "$(tput setaf 4) $(tput setab 7)Check for Updates...$(tput sgr 0)"


if sudo yum check-update; then
  echo "There are updates available"
  exit 0
fi
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Install Kernel Devel Package...$(tput sgr 0)"
sudo yum -y install kernel-devel || exit 1
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Install Kernel Headers...$(tput sgr 0)"
sudo yum -y install kernel-headers || exit 1
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Update Kernel...$(tput sgr 0)"
sudo yum -y install kernel || exit 1 
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)build-essentials...$(tput sgr 0)"
sudo yum -y install gcc gcc-c++ kernel-devel make || exit 1
echolog "done.."

#echolog "$(tput setaf 4) $(tput setab 7)Development Tools...$(tput sgr 0)"
#sudo yum -y groupinstall "Development Tools" || exit 1
#echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Install Requirements for Driver update...$(tput sgr 0)"
sudo yum -y install elfutils-libelf-devel || exit 1
sudo yum -y install libtool automake autoconf cmake gcc libnl3-devel libudev-devel make pkgconfig valgrind-devel || exit 1
sudo yum -y install pciutils || exit 1 
sudo yum -y install lshw || exit 1
echolog "done.."


echolog "$(tput setaf 4) $(tput setab 7)System needs to be rebooted to load the Kernel-Headers...$(tput sgr 0)"
echolog "$(tput setaf 4) $(tput setab 7)Reboot before proceeding to the next script..............$(tput sgr 0)"
echolog "$(tput setaf 4) $(tput setab 7)Reboot System now........................................$(tput sgr 0)"

