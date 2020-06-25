#!/usr/bin/env bash
set -e
set -o pipefail

# Edward Bustos 
# SHELL Script to bootstrap CentOS 8.1 (build 1911) after a base OS install.
# Test for Proxy and if not present set it.  


NOW=$(date +"%T-%D")
VAR_PROXY="http://proxy.compaq.com:8080"
VAR_PEN_DRIVER="drivers-linux-eth.tar.xz"
VAR_NGINX="15.115.118.72:8081/"
log_file="installCentOS81-kernel-devel package.log"

echolog()
(
 echo "$@"
 echo "$@" >> $log_file
)

echolog "Starting log $NOW...."


echolog "$(tput setaf 4) $(tput setab 7)Download CentOS 8.1 kernel-devel package...$(tput sgr 0)"
sudo wget https://rpmfind.net/linux/centos/8.1.1911/BaseOS/x86_64/os/Packages/kernel-devel-4.18.0-147.el8.x86_64.rpm
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Install CentOS 8.1 kernel-devel package..$(tput sgr 0)"
sudo rpm -ivh kernel-devel-4.18.0-147.el8.x86_64.rpm
echolog "done.."

echolog "$(tput setaf 4) $(tput setab 7)Installed the 8.1 kernel-devell package 4.18.0-147.el8.x86_64.............$(tput sgr 0)"

