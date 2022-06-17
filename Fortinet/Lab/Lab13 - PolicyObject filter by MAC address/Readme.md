# Lab13 - PolicyObject filter by MAC address

---

## Diagram
[<img src="https://i.imgur.com/AOrMDJ7.png">](https://i.imgur.com/AOrMDJ7.png)

---

## Sinopsis
````md
````

---

## azcli
````bash
#######################
# upload *.ps1 online #
#######################
# pastebinit -l --list paste code online
# valide: 30d URL
vmExtension="$(pastebinit -i vmExtension.ps1 -f powershell -b dpaste.com)".txt

########################
# upload *.json online #
########################
armJson="$(pastebinit -i arm.json -f json -b dpaste.com)".txt

# userName: email
az login --username 

#######################
# deploy arm template #
#######################

# Time: ~9m
az deployment group create -n gns3 \
  -g $(az group create -n gns3 -l canadacentral \
  --query 'name' -o tsv) \
  -u $armJson \
  -p vmExtension=$vmExtension \
  --query '{clientPip:properties.outputs.clientPip.value,provisioningState:properties.provisioningState}'

# Del gns3 group
az group delete -n gns3 --yes

# list account
# --query "[].{email:user.name,isDefault:isDefault}"
# --query "[? to_string(isDefault) == 'true']"
az account list --query "[? to_string(isDefault) == 'true']"
# log out
az logout --username
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
end

# static route
configure router static
edit 1
set device port1
set gateway 192.168.122.1
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
