#!/usr/bin/env bash

# Script for Ubuntu 18.0.4.4 LTS
# Fixed the Docker Proxy settings
# LR1 Proxy requires the http://proxy.compaq.com:8080
# LR0 Proxy can use http://web-proxy.houston.hpecorp.net:8080

VAR_PROXY="http://proxy.compaq.com:8080"
VAR_DRIVER="drivers-linux-eth.tar.xz"
VAR_NGINX1="http://16.85.2.24/drivers-linux-eth.tar.xz"

echo "$(tput setaf 4) $(tput setab 7)Setup Proxy...$(tput sgr 0)"
sudo cat>>/etc/environment<<EOF 
http_proxy="${VAR_PROXY}"
https_proxy="${VAR_PROXY}"
no_proxy="localhost,127.0.0.1,::1,.hpqcorp.net,hpecorp.net"
EOF
echo "done..."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Get System Updates...$(tput sgr 0)"
sudo apt update
sudo apt upgrade -y
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Enable SSH Access...$(tput sgr 0)"
sudo apt-get -y install openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Disable Firewall...$(tput sgr 0)"
sudo ufw disable
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Download Vagrant 2.2.9...$(tput sgr 0)"
sudo wget https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb
echo "done..."
echo ""
echo "$(tput setaf 4) $(tput setab 7)You have to change Directory Permissions if Vagrant does not start...$(tput sgr 0)"
echo "$(tput setaf 4) $(tput setab 7)run '$ sudo chown -R <user> <directory>...$(tput sgr 0)"
echo "Pause 10 seconds"
sudo sleep 10
echo ""

echo "$(tput setaf 4) $(tput setab 7)Install Vagrant...$(tput sgr 0)"
sudo dpkg -i vagrant_2.2.9_x86_64.deb 
echo "done..."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Install Plugins....$(tput sgr 0)"
sudo vagrant plugin install vagrant-vbguest
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Get Updates...$(tput sgr 0)"
sudo apt update
echo "done..."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Install Transport and CA-Certificates....$(tput sgr 0)"
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Curl Docker GPG...$(tput sgr 0)"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Configure repositories....$(tput sgr 0)"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Install Docker....$(tput sgr 0)"
sudo apt install docker-ce -y
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Create a systemd drop-in directory for docker service...$(tput sgr 0)"
sudo mkdir -p /etc/systemd/system/docker.service.d
echo "done..."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Create a file called http-proxy.conf....$(tput sgr 0)"
sudo touch /etc/systemd/system/docker.service.d/http-proxy.conf
sudo cat >>/etc/systemd/system/docker.service.d/http-proxy.conf<<EOF
[Service]
Environment="HTTP_PROXY=${VAR_PROXY}"
Environment="NO_PROXY=localhost,.hpecorp.net"
EOF
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Create a file called https-proxy.conf...$(tput sgr 0)"
sudo touch /etc/systemd/system/docker.service.d/https-proxy.conf
sudo cat >>/etc/systemd/system/docker.service.d/https-proxy.conf<<EOF
[Service]
Environment="HTTPS_PROXY=${VAR_PROXY}" 
EOF
echo "done.."
echo ""


echo "$(tput setaf 4) $(tput setab 7)Flush changes...$(tput sgr 0)"
sudo systemctl daemon-reload
echo "done.."
echo ""


echo "$(tput setaf 4) $(tput setab 7)Restart Docker...$(tput sgr 0)"
sudo systemctl restart docker
echo "done.."
echo ""

#echo "$(tput setaf 4) $(tput setab 7)Verify that the configuration has loaded...$(tput sgr 0)"
#sudo systemctl show --property=Environment docker
#echo "done.."
#echo ""


echo "$(tput setaf 4) $(tput setab 7)Add your user to the docker group...$(tput sgr 0)"
sudo usermod -aG docker $USER
echo "done.."
echo ""
echo "$(tput setaf 4) $(tput setab 7)YOU HAVE TO MANUALLY REBOOT and LOG BACK IN......$(tput sgr 0)"
echo ""
