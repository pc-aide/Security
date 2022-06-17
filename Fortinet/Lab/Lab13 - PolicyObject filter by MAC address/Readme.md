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
set role Lan
end

# WAN 

# hostname
conf system global
set hostname FG-1
end

````

---

## PC-1
````bash
````

---

## PC-2
````bash
````
