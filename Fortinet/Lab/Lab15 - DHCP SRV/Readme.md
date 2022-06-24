# Lab15 - DHCP SRV

---

## Acronym
* DHCP - Dynamic Host Configuration Protocol
* DMZ - Demilitarized zone
* FG - Fortigate
* NAT - Network Address Translation
* SW - Switch

---

## Diagram
[<img src="https://i.imgur.com/4dpLg0u.png">](https://i.imgur.com/4dpLg0u.png)

---

## How to Fix Mouse Pointer Not Aligned on QEMU
* Advanced\Additional settings\Options:
````txt
-usbdevice tablet
````

---

## FG-11
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
set hostname FG-11
end

# WAN
config sys int
edit port1
set mode static
set ip 192.168.122.100/24
set alias WAN
set role wan
set allow ping
end

# static route
config router static
edit 1
set device port1
set gateway 192.168.122.1
end

# dns
config system dns
set primary 8.8.8.8
set secondary 1.1.1.1
end

# DMZ (port2)
config sys int
edit port2
set mode static
set ip 192.168.2.100/24
set alias DMZ
set allow ping
end

# LAN (port4)
config sys int
edit port4
set mode static
set ip 192.168.1.100/24
set alias LAN
set allow ping
end

````
