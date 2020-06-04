#!/usr/bin/env bash

# Using this script on the LR1 which requires different proxy settings that LR0
# Be sure to the script creates the /bin directory ie. /home/volante/bin to copy the tar driver package

VAR_PROXY="http://proxy.compaq.com:8080"
VAR_DRIVER="drivers-linux-eth.tar.xz"
VAR_NGINX1="http://16.85.2.24/drivers-linux-eth.tar.xz"

sudo mkdir bin


echo "$(tput setaf 4) $(tput setab 7)Setup Proxy...$(tput sgr 0)"
sudo cat>>/etc/environment<<EOF 
http_proxy="${VAR_PROXY}"
https_proxy="${VAR_PROXY}"
no_proxy="localhost,127.0.0.1,::1,.hpqcorp.net,hpecorp.net"
EOF
echo "done..."
echo ""


echo "$(tput setaf 4) $(tput setab 7)Enable yum.conf...$(tput sgr 0)"
sudo cat>>/etc/yum.conf<<EOF
proxy="${VAR_PROXY}"
EOF
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Check for Updates...$(tput sgr 0)"
sudo yum check-update
echo "done.."
echo "$(tput setaf 4) $(tput setab 7)Install Kernel Devel Package...$(tput sgr 0)"
sudo yum -y install kernel-devel
echo "done.."
echo "$(tput setaf 4) $(tput setab 7)Install Kernel Headers...$(tput sgr 0)"
sudo yum -y install kernel-headers
echo "done.."
echo "$(tput setaf 4) $(tput setab 7)Update Kernel...$(tput sgr 0)"
sudo yum -y install kernel
echo "done.."
echo "$(tput setaf 4) $(tput setab 7)build-essentials...$(tput sgr 0)"
sudo yum -y install gcc gcc-c++ kernel-devel make
echo "done.."
echo "$(tput setaf 4) $(tput setab 7)Development Tools...$(tput sgr 0)"
sudo yum -y groupinstall "Development Tools"
echo "done.."

echo "$(tput setaf 4) $(tput setab 7)Install Kernel-devel package...$(tput sgr 0)"
sudo wget https://rpmfind.net/linux/centos/8.1.1911/BaseOS/x86_64/os/Packages/kernel-devel-4.18.0-147.8.1.el8_1.x86_64.rpm
echo "done"
sudo rpm -ivh kernel-devel-4.18.0-147.8.1.el8_1.x86_64.rpm
echo "done"

echo "$(tput setaf 4) $(tput setab 7)Install Requirements for Driver update...$(tput sgr 0)"
sudo yum -y install kernel-uek-devel 
sudo yum -y install libelf-dev 
sudo yum -y install libelf-devel 
sudo yum -y install elfutils-libelf-devel
echo "done.."
sudo yum -y install libtool automake autoconf cmake gcc libnl3-devel libudev-devel make pkgconfig valgrind-devel
echo "done.."
sudo yum -y install pciutils 
echo "done.."
sudo yum -y install lshw
echo "done.."


#echo "$(tput setaf 4) $(tput setab 7)Get the Pensando driver...$(tput sgr 0)"
#sudo wget http://${nginx1}

#echo "$(tput setaf 4) $(tput setab 7)Install the Pensando driver...$(tput sgr 0)"
#sudo tar xvf ${VAR_DRIVER}
#
#cd /home/volante/bin/drivers-linux-eth
#./build.sh 
#insmod eth/ionic/ionic.ko 

#echo "done.."

