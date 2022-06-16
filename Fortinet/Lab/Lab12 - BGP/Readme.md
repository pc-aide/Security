# BGP

---

## Acronym
* AS - Autonomous System
* BGP - Border Group Protocol

---

## azcli
````bash
# userName: email
az login --username 

# Deploy Template | time: ~9m
# -u or --template-uri: eg. *.json
az deployment group create -n gns3 \
  -g $(az group create -n gns3 -l canadacentral \
  --query 'name' -o tsv) \
  -u https://raw.githubusercontent.com/pc-aide/Security/master/Fortinet/Lab/Lab12%20-%20BGP/Lab12-BGP.json \ 
  --query '{clientPip:properties.outputs.clientPip.value,provisioningState:properties.provisioningState}'

# Del test group
az group delete -n gns3 --yes

# list account
# --query "[].{email:user.name,isDefault:isDefault}"
# --query "[? to_string(isDefault) == 'true']"
az account list --query "[? to_string(isDefault) == 'true']"
# log out
az logout --username
````

---

## Sinopsis
````md
1. BGP
  * Local AS: 1
  * Router ID: 1.1.1.1
  * Neightbors
    * IP: 192.168.2.2 - rt-2
    * Remote AS: 2
    * IP: 192.168.2.1 - rt-1
    * Remote AS: 3
  * Networks\IPNetmask: 
    * 1.0.0.0/8
    * 2.0.0.0/8
    * 3.0.0.0/8
    * 192.168.2.0/24
    
2. RTs
  * router bgp 2 - 2 ref 192.168.2.2 remote as 2 in the fg-1
  * neighbor 192.168.2.100 remote-as 1 - 1 ref local as of the fg-1
  
3. fg-1
  * gui\dashboard\network\routing
    * new entry: bgp for each add bgp in the routers

4. rt-2
  * network 8.0.0.0 mask 255.0.0.0
  * show ip bgp nighbor
  * show ip bgp
  * ping 1.1.1.1 - 
  
5. fg-1
  * gui\dashboard\network\routing
    * new entry: bgp for each add bgp in the routers
  
6. rt-1
  * network 9.0.0.0 mask 255.0.0.0
  * network 19.0.0.0 mask 255.0.0.0
  
7. fg-1
  * gui\dashboard\network\routing
    * new entry: bgp for each add bgp in the routers
    * cli\get router info routing-table bgp
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

# loopback 1,2,3
config sys int
edit Loopback1
set ip 1.1.1.1/8
set type loopback
set allow ping
set vdom root
next
edit Loopback2
set ip 2.2.2.2/8
set type loopback
set allow ping
set vdom root
next
edit Loopback3
set ip 3.3.3.3/8
set type loopback
set allow ping
set vdom root
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
set role lan
end

# WAN
config sys int
edit port1
set allow ping
set mode static
set ip 192.168.2.100/24
set alias WAN
set role wan
end

# LAN_192.168.1.0 (db)
config firewall address
edit "LAN_192.168.1.0"
set associated-interface port2
set subnet 192.168.1.0/24
end

# LAN2WAN
config firewall policy
edit 1
set name "LAN2WAN"
set srcintf "port2"
set dstintf "port1"
set srcaddr "LAN_192.168.1.0"
set dstaddr "all"
set action accept
set service "PING" "TRACEROUTE"
set logtraffic all
set schedule "always"
set nat enable
next
# WAN2LAN
edit 2
set name "WAN2LAN"
set srcintf "port1"
set dstintf "port2" "Loopback1" "Loopback2" "Loopback3"
set srcaddr "all"
set dstaddr "all"
set action accept
set service "PING" "TRACEROUTE"
set logtraffic all
set schedule "always"
set nat enable
end

# hostname
conf system global
set hostname FG-1
end

````

---

## RT-2
````ruby
# hostname
config t
hostname RT-2

# interfaces:
int gi0/0 
ip add 192.168.2.2 255.255.255.0
no shut
exit
int loopback 1
ip add 8.8.8.8 255.0.0.0
no shut
end

# save
wr

````

---

## RT-1
````ruby
# hostname
config t
hostname RT-1

# interfaces gi0/0:
int gi0/0 
ip add 192.168.2.1 255.255.255.0
no shut
exit
int loopback 1
ip add 8.8.8.8 255.0.0.0
no shut
exit
int loopback 2
ip add 9.9.9.9 255.0.0.0
no shut
exit
int loopback 3
ip add 19.9.9.9 255.0.0.0
no shut
end

# save
wr

````
