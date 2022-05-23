# Lab02 - VLAN

---

## Diagram
[<img src="https://i.imgur.com/mqUAZDN.png">](https://i.imgur.com/mqUAZDN.png)

---

## Req
1. FG1
2. SW1\Cisco
3. 3x VLAN
   1. HR
   2. SAL
   3. IT

---

## user-data
* gns3_srv_ubu.sh
````
#!/bin/sh
# Download
curl https://raw.githubusercontent.com/GNS3/gns3-server/master/scripts/remote-install.sh > gns3-remote-install.sh

# run with args
# --with-iou: Install IOU
# --with-i386-repository: Add the i386 repositories required by IOU if
# they are not already available on the system. Warning
bash gns3-remote-install.sh --with-iou --with-i386-repository

# ifconfig eth0 | grep inet | port 3080
````

---

## cloud-config
````yaml
#cloud-config

# Tested on ubuntu-srv-18.04 LTS
# Req.: hypervisor : true
#
# Time: ~2m40s
#
# curl <*.sh> Download
# --with-iou: Install IOU
# --with-i386-repository: Add the i386 repositories required by IOU if
# they are not already available on the system. Warning
runcmd:
  - curl https://raw.githubusercontent.com/GNS3/gns3-server/master/scripts/remote-install.sh > gns3-remote-install.sh
  - bash gns3-remote-install.sh --with-iou --with-i386-repository

# Once installed, ifconfig eth0 | grep inet | port 3080
````

---

## webTerm
* EditConfig\eth0\dhcp:
````sh
````
* EditConfig\eth0\static:
````sh
#
# This is a sample network config, please uncomment lines to configure the network
#

# Uncomment this line to load custom interface files
# source /etc/network/interfaces.d/*

# Static config for eth0
auto eth0
iface eth0 inet static
	address 192.168.10.2
	netmask 255.255.255.0
	gateway 192.168.10.100
	up echo nameserver 8.8.8 > /etc/resolv.conf

# DHCP config for eth0
#auto eth0
#iface eth0 inet dhcp
````
