#!/usr/bin/env bash

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
