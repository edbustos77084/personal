#!/usr/bin/env bash

echo "$(tput setaf 4) $(tput setab 7)Setup Proxy...$(tput sgr 0)"
sudo cat>>/etc/environment<<EOF 
http_proxy="http://web-proxy.houston.hpecorp.net:8080"
https_proxy="http://web-proxy.houston.hpecorp.net:8080"
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
sudo systemctl status ssh
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Disable Firewall...$(tput sgr 0)"
sudo ufw disable
echo "done.."
echo ""

