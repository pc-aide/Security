# Lab13 - PolicyObject filter by MAC address

---

## Diagram
[<img src="https://i.imgur.com/AOrMDJ7.png">](https://i.imgur.com/AOrMDJ7.png)

---

## Sinopsis
````md
1. test webBrowser from PCs
	* e.g.: nfl, facebook, & son on


2. get system arp | grep port2 - findOut mac for PC-1

3. FG-1
	* Policy & objects\Address\CreateNew\Address\
		* Name: PC1MAC
		* Type: Device Mac address
		* Interface: LAN
		* Firewall Policy\Lan2NAT-Internet
			* srcAddr: PC1MAC - remove old addr. LAN_192.168.1.0/24

4. test webBrowser from PCs again
	* only PC1MAC will be access internet

5. FT-1\Dashboard\
	* FortiView Sessions
		* only src: 192.168.1.1
	* Log & Report 
		* Forward Traffic
			* all IP add .1 & .2
				* filter: src: 192.168.1.1
	* fortiView Sources
	* fortiView Destinations
	* fortiView Policies
	* fortiView Session
````

---

## FG-1
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
set gui-default-dashboard-template ""expanded""
set gui-ignore-release-overview-version "6.4.1"
next
end

# LAN
config sys int
edit port2
set allow ping
set mode static
set ip 192.168.1.100/24
set alias LAN
set role Lan
end

# nat-internet
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

# address
config firewall address
edit "LAN_192.168.1.0"
set uuid 194a8682-f00a-51ec-bffd-c2b420662e1e
set associated-interface "port2"
set subnet 192.168.1.0 255.255.255.0
next
end

# firewall policy
config firewall policy
edit 1
set name "LAN2NAT-Internet"
set srcintf "port2"
set dstintf "port1"
set srcaddr "LAN_192.168.1.0"
set dstaddr "all"
set action accept
set schedule "always"
set service "PING" "Web Access"
set logtraffic all
set nat enable
next
end

# hostname
conf system global
set hostname FG-1
end

````

---

## PC-1
````bash
auto eth0
iface eth0 inet static
	address 192.168.1.1
	netmask 255.255.255.0
	gateway 192.168.1.100
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
````

---

## PC-2
````bash
auto eth0
iface eth0 inet static
	address 192.168.1.2
	netmask 255.255.255.0
	gateway 192.168.1.100
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
````
