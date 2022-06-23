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
    * Disk image: FGT6.4.7.qcow2 & 
    * Disk interface: virtio
3. Network
  * Name format: Port{port1}
  * Segment size: 0


### SW
1. RAM: 456
2. Qemu binary: /usr/bin/qemu-system-x86_64

---

## FG1
````ruby
admin

123
123

# MGMT
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

````
