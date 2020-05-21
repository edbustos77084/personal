#!/usr/bin/env bash

echo "$(tput setaf 4) $(tput setab 7)Create a systemd drop-in directory for doocker service...$(tput sgr 0)"
sudo mkdir -p /etc/systemd/system/docker.service.d
echo "done..."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Create a file called http-proxy.conf....$(tput sgr 0)"
sudo touch /etc/systemd/system/docker.service.d/http-proxy.conf
sudo cat >>/etc/systemd/system/docker.service.d/http-proxy.conf<<EOF
[Service]
Environment="HTTP_PROXY=http://web-proxy.houston.hpecorp.net:8080" "NO_PROXY=localhost,127.0.0.1,hpecorp.net"
EOF
echo "done.."
echo ""

echo "$(tput setaf 4) $(tput setab 7)Create a file called https-proxy.conf...$(tput sgr 0)"
sudo touch /etc/systemd/system/docker.service.d/https-proxy.conf
sudo cat >>/etc/systemd/system/docker.service.d/https-proxy.conf<<EOF
[Service]
Environment="HTTPS_PROXY=https://web-proxy.houston.hpecorp.net:8080" "NO_PROXY=localhost,127.0.0.1,hpecorp.net"
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
echo "$(tput setaf 4) $(tput setab 7)YOU HAVE TO MANUALLY LOGOUT and LOG BACK IN......$(tput sgr 0)"
echo ""
