# Lab15 - DHCP srv in gns3 web UI

---

## Acronym
* DHCP - Dynamic Host Configuration Protocol
* DMZ - Demilitarized zone
* FG - Fortigate
* NAT - Network Address Translation
* SW - Switch

---

## Diagram
[<img src="https://i.imgur.com/DEZyCJ6.png">](https://i.imgur.com/DEZyCJ6.png)

---

## qemu
### FG
1. General settings
  * RAM: 856
  * Qemu binary: /usr/bin/qemu-system-x86_64
2. HDD
  * HDA: 
    * Disk image: FGT6.4.7.qcow2
    * Disk interface: virtio
3. Network
  * Name format: Port{port1}
  * Segment size: 0


### SW
1. General settings
  * RAM: 456
  * Qemu binary: /usr/bin/qemu-system-x86_64
2. HDD
  * HDA: 
    * Disk image: FGT6.4.7.qcow2
    * Disk interface: virtio
3. Network
  * Name format: 


### winXP
1. General settings
  * RAM: 856
  * Qemu binary: /usr/bin/qemu-system-i386 ?
2. HDD
  * HDA: 
    * Disk image: xp-lite
    * Disk interface: none
3. Network
  * Name format: 

---

## FG1
````ruby
admin

123
123

# MGMT (port3)
config system interface
edit port3
set alias MGMT
set mode static
set ip 192.168.3.100/24
set allow ping http
end

# remove first start wizard + dashboard-template
config system admin
edit admin
set gui-default-dashboard-template "expanded"
set gui-ignore-release-overview-version "6.4.1"
next
end

# hostname
conf system global
set hostname FG-1
end

# NAT-Internet
config sys int
edit port1
set mode static
set ip 192.168.122.100/24
set alias NAT-internet
set allow ping
end

# static route
config router static
edit 1
set device port1
set gateway 192.168.122.1
end

# DMZ (port2)
config sys int
edit port2
set mode static
set ip 192.168.2.100/24
set alias DMZ
set allow ping
end

# IN (port4)
config sys int
edit port4
set mode static
set ip 192.168.1.100/24
set alias IN
set allow ping
end

````

---

## MGMT
````bash
auto eth0
iface eth0 inet static
	address 192.168.3.2
	netmask 255.255.255.0
	gateway 192.168.3.100
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
````
