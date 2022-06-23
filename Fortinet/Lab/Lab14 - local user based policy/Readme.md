# lab 14 - local user based policy

---

## Acronym
* FSSO - Fortinet Single Sign-On

---

## Diagram
[<img src="https://i.imgur.com/aT3EUGO.png">](https://i.imgur.com/aT3EUGO.png)
      
---

## Sinopsis
````md
1. Test Web Browser with PCs

2. FG-1
	* User & Auth.\User definition\Create New\
		* User Type: local
		* usr: paul
		* pwd: admin123
		* submit
	* Policy & Objects\Firewall Policy\Lan2Nat-internet\Edit:
		* Source: LAN_1092.168.1.0, paul

3. Test web Browser again
	* we have now 'Open network login page'
	
4. FG-1
	* Dashboard:
		* Firewall User Monitor
			* Test Deauth. & web browser again without auth
		* FortiView Sources
	* log & report
		* Forward Traffic
			* double click on entry (log Details)
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
set gui-default-dashboard-template "expanded"
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
set role lan
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
set hostname FG1
end

````

---

## PCs
* file: /etc/network/interfaces
````ruby
auto eth0
iface eth0 inet static
	address 192.168.1.
	netmask 255.255.255.0
	gateway 192.168.1.100
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
````
