#!/usr/bin/env bash
set -e
set -o pipefail

# Edward Bustos 06/15/2020
# Be sure you have the correct proxy settings
# Assume you are running this from your home directory as ROOT or cd ~
# This script should install Docker on your CentOS 8.1 image
# There are known conflict issues with PODMAN, so if you have that installed, you may have to remove those files. 
# See https://github.com/containers/libpod/issues/4791 describing the issue 

NOW=$(date +"%T-%D")
VAR_PROXY="http://proxy.compaq.com:8080"
VAR_PEN_DRIVER="drivers-linux-eth.tar.xz"
VAR_NGINX="15.115.118.72:8081/"
log_file="log_DockerInstall.log"

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


echolog "$(tput setaf 4) $(tput setab 7)Install Docker Dependencies...$(tput sgr 0)"
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Install Repository to CentOS...$(tput sgr 0)"
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Install Docker...$(tput sgr 0)"
sudo yum install docker-ce docker-ce-cli -y --nobest
echolog "done.."


echolog "$(tput setaf 4) $(tput setab 7)Create systemd directory for docker environment...$(tput sgr 0)"
sudo mkdir -p /etc/systemd/system/docker.service.d
echolog "done.."


echolog "$(tput setaf 4) $(tput setab 7)Create file called http-proxy.conf...$(tput sgr 0)"
sudo touch /etc/systemd/system/docker.service.d/http-proxy.conf
sudo cat >>/etc/systemd/system/docker.service.d/http-proxy.conf<<EOF
[Service]
Environment="HTTP_PROXY=${VAR_PROXY}"
Environment="NO_PROXY=localhost,.hpecorp.net"
EOF
echolog "done.."


echolog "$(tput setaf 4) $(tput setab 7)Create a file called https-proxy.conf...$(tput sgr 0)"
sudo touch /etc/systemd/system/docker.service.d/https-proxy.conf
sudo cat >>/etc/systemd/system/docker.service.d/https-proxy.conf<<EOF
[Service]
Environment="HTTPS_PROXY=${VAR_PROXY}"
EOF
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Manage Docker Service...$(tput sgr 0)"
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl enable docker



echolog "$(tput setaf 4) $(tput setab 7)DONE...Confirm Docker is working..........................$(tput sgr 0)"
echolog "$(tput setaf 4) $(tput setab 7)run this command: docker container run hello-world........$(tput sgr 0)"
echolog "$(tput setaf 4) $(tput setab 7)sudo systemctl show --property=Environment docker..........$(tput sgr 0)"