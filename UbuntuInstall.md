# Ubuntu Installation Instructions
## How to install KVM w/ Bonding on Ubuntu
+ https://raymii.org/s/tutorials/KVM_with_bonding_and_VLAN_tagging_setup_on_Ubuntu_12.04.html
+ https://www.linuxtechi.com/install-configure-kvm-ubuntu-18-04-server/

## How to install Docker on Ubuntu 18.04
+ https://linuxize.com/post/how-to-install-and-use-docker-on-ubuntu-18-04/

1. sudo apt update
1. sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
1. curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
1. sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

## Now install Docker CE
1. sudo apt update
1. apt list -a docker-ce (will show what versions are out there)should be done first
1. sudo apt install docker-ce (will install the latest, might not be what you want)
### To prevent the Docker package from being automatically updated, mark it as held back
1. sudo apt-mark hold docker-ce
1. sudo systemctl status docker
1. sudo usermod -aG docker $USER
1. docker container run hello-world (NOTE: This will fail behind our Corporate proxy "docker: Got permission denied while trying to connect to the Docker daemon socket at unix:/ //var/run/docker.sock: Post http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/create: dial unix /var/run/docker.sock: connect: permission denied. ")
1. Proceed with the setup instructions on how to configure a VM or Physical system behind a Corporate Proxy Server below
1. To Remove Docker follow instructions at the link (https://linuxize.com/post/how-to-install-and-use-docker-on-ubuntu-18-04/)

## How to setup a VM behind the Corporate Proxy server to download Docker Images - 
1. Docker Daemon needs to be configured along with your domain credentials: 
 https://medium.com/@saniaky/configure-docker-to-use-a-host-proxy-e88bd988c0aa
 http://sourceforge.net/projects/cntlm/files/cntlm/cntlm%200.92.3/
 https://www.unixmen.com/ubuntu-14-04-behind-domain-proxy-solved/
1. dpkg -i cntlm_0.92.3_amd64.deb


## You have to install the Ubuntu deb package and then follow the instructions on both links. To configure 
   Look under the heading "Configure Docker Daemon to use proxy"
1. If you get this error: "Error response from daemon: Get https://registry-1.docker.io/v2/: remote error: tls:    access denied"
1. This example assumes you are using Ubuntu 19.04
1. First download the deb package "cntlm"
    +  http://sourceforge.net/projects/cntlm/files/cntlm/cntlm%200.92.3/
	+  Use WinSCP or some other method to get onto your VM in the lab (assume your VM is on an LR0 - 16.x.x.x)
	+  Copy the deb package to /tmp
	+  As root install the package "dpkg -i cntlm_0.92.3_amd64.deb"
	+  Edit cntlm.conf with the following
	+  vim /etc/cntlm.conf
        +  Username 
		+  Domain
		+  Password
		+  Proxy Server
		+  Listen 127.0.0.1:3128
		+  Gateway "yes"
	+ Save and exit
	+ Generate password hash
		+ cntlm -H
		+ Copy the hash PassNTLMv2 back into the file for the "Password" instead of leaving your domain plain text password
	+ Save and exit
	+ Export the Local Proxy: 
	    + export http_proxy=http://127.0.0.1:3128
	+ Restart cntml daemon to load the new settings
	    + /etc/init.d/cntlm restart
	+ Now configure your Docker Proxy Settings:
	    + Run under root, create this file:
		+ cat > /etc/systemd/system/docker.service.d/http-proxy.conf 
		+ <<EOF
		    + [Service]
		    + Environment="HTTP_PROXY=http://127.0.0.1:3128"
		    + Environment="HTTPS_PROXY=http://127.0.0.1:3128"
		    + Environment="NO_PROXY=localhost,127.0.0.1,172.17.0.1,172.30.1.1"
		 >>EOF
	+ Restart Docker
		+ systemctl daemon-reload
		+ systemctl restart docker
	+ Verify that the configuration has been loaded:
	    + Systemctl show --property=Environment docker
		+ You should see below, if not verify spelling and that you included [Service]
		+ Environment=HTTP_PROXY=http://127.0.0.1:3128 HTTPS_PROXY=http://127.0.0.1:3128 NO_PROXY=localhost,127.0.0.1
	+ Configure Docker Client to pass proxy information to containers: (note: back as your normal user). 
	    + Create /edit ~/.docker/config.json
		 
        {
		  "proxies":
		  {
		    "default":
		      {
		        "httpProxy": "http://localhost:3128",
		        "httpsProxy": "http://localhost:3128",
		        "noProxy": "localhost"
		     }
		  }
		}
        
	+ Reboot the system
	+ docker search ubuntu
	+ docker image pull ubuntu
	+ docker image ls
	+ docker image rm ubuntu
		
		
## Ubuntu 19.04 in 4th floor Lab - Sandbox
+ VLAN2 - LR0 - 16.x.x.x
+ VLAN3 - Private { 192.168.3.200-254}
+ VLAN4 - Private { no dhcp/dns yet}
+ vm1 - VLAN2 = 16.81.51.23 (edward/HPinvent123)
+ vm2 - VLAN3 = 192.168.3.9 (DHCP/DNS Server) - (edward/HPinvent123)
+ vm3 - VLAN3 = 192.168.3.201 (dhcp lease)- (volante/HPinvent123)
+ vm4 - VLAN4 = 192.168.4.10 { no dhcp/dns yet} - (volante/HPinvent123)
+ vm5 - VLAN3 = 192.168.3.202 (dhcp lease) - (volante/HPinvent123)

## Set Proxy
+ $ sudo vi /etc/environment
+ $ http_proxy="http://proxy.compaq.com:8080"
+ $ https_proxy="http://proxy.compaq.com:8080"
+ $ no_proxy="localhost,127.0.0.1,::1"

## Proxy in SIOS LAB's LR1:
+ $ sudo vi /etc/environment
+ $ http_proxy="http://proxy.houston.hpecorp.net:8080

## Get the latest updates:
+ $ sudo apt update
+ $ sudo apt upgrade

## Install VIM:
+ $ sudo apt -y install vim

## Enable SSH access: 
+ $ sudo apt-get -y install openssh-server
+ $ sudo systemctl enable ssh
+ $ sudo systemctl start ssh
+ $ sudo systemctl status ssh 

## Enable Firewall to allow SSH:
+ $ sudo ufw allow ssh
+ $ sudo ufw enable
+ $ sudo ufw status 

## Change Hostname if necessary:
+ $ sudo hostname new-name

## Prepare to install VMs:if
+ Ubuntu 19.04 Server - NO GUI
+ https://vitux.com/how-to-install-kvm-to-create-and-manage-virtual-machines-in-ubuntu/
+ https://www.linuxtechi.com/install-configure-kvm-ubuntu-18-04-server/

+ $ egrep -c ‘(svm|vmx)’ /proc/cpuinfo

## sudo apt install cpu-checker
+ sudo kvm-ok

+ $ sudo apt-get install qemu-kvm 
+ $ sudo apt-get install libvirt-daemon-system
+ $ sudo apt-get install libvirt-clients
+ $ sudo apt-get install bridge-utils
+ $ sudo apt-get install virt-manager

### NOTE: installing libvirt-bin gave an error 18.10+ (so instead of libvirt-bin use libvirt-daemon-system libvirt-clients)

+ $ sudo adduser [username] libvirtd
+ NOTE: This indicates that you are using a new version of KVM that has a default group libvirt serving the same purpose as that of the libvirtd group.
+ The following output of the groups command will indicate that the current root user is already a member of the libvirt group. Therefore there is no need to add yourself to this group.

## To add other users into the group
+ $ sudo adduser [username] libvirt
+ $ sudo virsh -c qemu:///system list
+ $ sudo service libvirtd status

## Check the VLAN settings:
+ $ cat /proc/net/vlan/config
+ Install the vlan package which adds some scripts to the ifup/ifdown mimic:
+ $ apt-get install vlan


## **Original Network setup: **
+ Using Mellanox with Trunk with VLAN 2 configured during the OS install manually. (Ubuntu 19.02 Server) - eno5.2:mactap (bridged)



## **Changing Network setup file to include the bridges: 
+ Network bridge is required to access the KVM based virtual machines outside the KVM hypervisor host. In Ubuntu 18.04, network is managed by netplan utility, whenever we freshly installed Ubuntu 18.04 server then a file with name “/etc/netplan/50-cloud-init.yaml” is created automatically, to configure static IP and bridge, netplan utility will refer this file.
+ ** When creating new VMs on the host, be sure to specify the correct NIC via QEMU - GUI
(In our example we used ENO5: macvtap on SMARTIO-05 for private VLANS**notice we did not select eno5.2:mactap from the drop-down selection. 
Problems were seen when selecting eno5.2 if using a private vlan, you may still get a corporate 16.x.x. IP address anyways, when you expected to get a 192.168.3.x address. 

## Create new VLANs on the TRUNK port:
+ Create new VLANs on the TOR switch, allow them to pass via the Trunk port connected to the VM Host:
+ Sample on a FlexFabric 5950

+ sys
    + vlan 10
    + exit
    + int Twenty-FiveGigE1/0/17
    + port link-mode bridge
    + port link-type trunk
    + port trunk permit vlan 10

## Configure DHCP & DNS using these links:
+ https://www.webhostinghero.com/ubuntu-dns-server-tutorial/
+ https://www.server-world.info/en/note?os=Ubuntu_19.04&p=dhcp&f=1

## Download the necessary DHCP and DNS packages before re-configuring to the Private Network:
+ DNS: 
+ sudo apt install bind9 bind9utils bind9-doc dnsutils -y

+ DHCP:
+ sudo apt install isc-dhcp-server -y


+ Sample NIC configuration of the VM on a Private VLAN-3, that is both the DHCP and DNS server: 

+ $sudo vi /etc/netplan/50-cloud-init.yaml

+ network:
    + ethernets:
        + enp1s0:
            + dhcp4: no
            + addresses: [192.168.3.9/24]
            + gateway4: 192.168.3.1
	+ nameservers: 
	    + addresses: [192.168.3.9]
    + version: 2
    + vlans:
        + enp1s0.3:
          + id: 3
          + link: enp1s0

+ Applying the Network changes: 
+  $sudo netplan --debug apply


## Configure DHCP server:
+ Download the necessary files before 

+ sudo vim /etc/dhcp/dhcpd.conf


## How to verify your DHCP lease:
+ 	netplan ip leases enp1s0  (substitute your adapter identified via ifconfig)

## How to verify what DHCP leases the server has handed out:
+ 	cat /var/lib/dhcp/dhcpd.leases

## Start and Stop DHCP server
+ sudo service isc-dhcp-server restart
+ sudo service isc-dhcp-server start
+ sudo service isc-dhcp-server stop 

+ From <https://help.ubuntu.com/community/isc-dhcp-server> 

+ Verify if DHCP server is running
+ sudo service isc-dhcp-server status
	
## Renew DHCP Address
+ sudo dhclient -r

## How to view DHCP leases handed out by the DHCP server:
+ sudo cat /var/lib/dhcp/dhcpd.leases

## Configure DNS settings:
+ sudo /etc/bind/named.conf.options
+ https://www.hiroom2.com/2019/06/15/ubuntu-1904-bind-en/
+ https://www.youtube.com/watch?v=P1Kf3rDuhJE

## Configure your server with a Host Name:
+ sudo hostnamectl set-hostname vm2.volante.dev

+ Modify the /etc/bind/named.config.local (create Forward and Reverse Zones)
    + Specify where the newly created files will reside, they must be in the BIND directory


+ Create Forward and Reverse Zones:
    + Copy the file db.local -> create two new files called
	    + forward.volante.dev
		+ reverse.volante.dev
		


    + The Forward zone files will contain this: /etc/bind/forward.volante.dev
		
	+ The Reverse zone file will contain this: /etc/bind/reverse.volante.dev
		
	+ Be sure your NIC has the DNS server specified 
	+ On Ubuntu 19.04 modify your -> sudo vim /etc/netplan/50-cloud-init.yaml 
	
	

	+ Apply network changes > sudo netplan --debug apply
	+ Restart BIND
        + sudo chmod -R 755 /etc/bind
		+ sudo systemctl restart bind9
		+ sudo systemctl status bind9
		+ IF you have a Firewall enabled: 
		    + sudo ufw status
			+ sudo ufw allow bind9
	+ Test your setup doing an nslookup and ping by name
