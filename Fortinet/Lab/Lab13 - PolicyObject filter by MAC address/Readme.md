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
````

---

## PC-1
````bash
````

---

## PC-2
````bash
````
