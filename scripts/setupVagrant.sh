#!/usr/bin/env bash

echo "$(tput setaf 4) $(tput setab 7)Download Vagrant 2.2.9...$(tput sgr 0)"
sudo wget https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb
echo "done..."
echo ""
echo "sleep for 10 seconds"
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

