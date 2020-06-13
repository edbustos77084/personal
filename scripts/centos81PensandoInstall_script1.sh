#!/usr/bin/env bash
set -e
set -o pipefail

# Edward Bustos 
# SHELL Script to bootstrap CentOS 8.1 (build 1911) after a base OS install.
# The script(s) will install all prerequisites and automatically load the Pensando Driver, even after an OS reboot. 
# Assume you are running this as Root from your home directory or cd ~
# Depending on whether you are on the LR1 or LR0 you may have to adjust the PROXY SERVER
# Confirm the Docker Container (NGINZ) is running if you can't download the DRIVER 

# Instructions: 
# 1. Install a base OS from Blofly: http://blofly.us.rdlabs.hpecorp.net/community/CentOS/8.1/CentOS-8.1.1911-x86_64-dvd1.iso
# 2. As Root run "centos81PensandoInstall_script1.sh" 
# 3. Be sure to reboot the system, so that the kernel headers can load before running the second script.
# 4. As Root run "centos81PensandoInstall_script2.sh"
# 5. Verify the Pensando driver is loaded >$ lsmod | grep ionic 


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

