# Lab15 - DHCP SRV

---

## Acronym
* DHCP - Dynamic Host Configuration Protocol
* DMZ - Demilitarized zone
* FG - Fortigate
* NAT - Network Address Translation
* SW - Switch

---

## URL
* [vnc-mouse-out-of-sync-in-qemu](https://gns3.com/community/featured/vnc-mouse-out-of-sync-in-qemu)

---

## Diagram
[<img src="https://i.imgur.com/xSM3nNt.png">](https://i.imgur.com/xSM3nNt.png)

---

## WinXP Qemu
* keyboard
  * Full Screen: ctrl + shift + alt + f

---

## Sinopsis
````md
1. FG1
  * interface\DMZ\
    * toggle DHCP srv
      * Range: 192.168.2.200 @ 192.168.2.250
      * IP address Assignement Rule
        * type: mac
        * MAC add: <WinXP1>
        * IP: 192.168.2.240
        
2. CapturePacket Gi0/1

3. winXP1
  * cmd
    * ipconfig /release && ipcofig /renew
   
4. Wireshark
  * filter: dhcp
    * DHCP Release
    * DHCP Discover
    * DHCP offer
    * DHCP Request
    * DHCP ACK
    * DHCP Discover
      * UDP
        * SrcPort: 68
        * DstPort: 67
        
5. VPC2
  * ip dhcp - set automatic to IP.dhcp
	* ping 192.168.2.100 - yes reply
	* show ip


6. winXP
	* test IE\bing.com\
		* searchEngine: nfl, rds, & nhl

7. FG1
	* Dashboard\
		* FortiView Source
			* 192.168.2.240\Destination
		* FortiView Sessions
		* DHCP Monitor
			* look around
		
8. FG1
	* interfaces\
    * LAN\NewDHCP
	    * Range: 192.168.1.101 @ 192.168.1.254
			
9. VPC3
	* ip dhcp
	* show ip
	* ping 8.8.8.8

10. FG1
	* Dashboard
		* DHCP monitor

11. VPC4
	* ip dhcp
	* show ip
	* ping 8.8.8.8

12. FG1
	* Dashboard
		* DHCP Monitor
			* new entry
	* Policy Object\New
		* Name: LAN2WAN  - same logic that the DMZ2WAN

````

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
set hostname FG1
end

# WAN (port1)
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

# Address (firewall policy)
config firewall address
edit "DMZ_192.168.2.0"
set associated-interface "port2"
set subne 192.168.2.0 255.255.255.0
next
end

# Firewall Policy
config firewall policy
edit 1
set name "DMZ2WAN"
set srcintf "port2"
set dstintf "port1"
set srcaddr "DMZ_192.168.2.0"
set dstaddr "all"
set action accept
set schedule "always"
set service "PING" "Web Access"
set logtraffic all
set nat enable
next
end

````

