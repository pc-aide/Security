# acount cleanUp
az account clear

# login
read -p "Your email: " email
az login -u $email

# Variables
rgName=gns3
location=canadacentral

# New gns3-RG
az group create \
  -n $rgName \
  -l $location

# New Storage Account with unique name
SAName="$(az storage account create \
-n sa$RANDOM \
-g $rgName \
-l $location \
--sku Premium_LRS \
--kind FileStorage \
--query "name" -o tsv)"

# New SMB
az storage share-rm create \
  -g $rgName \
  --storage-account $SAName \
  -n $SAName \
  --enabled-protocols SMB

# key
key="$(az storage account keys list -n ${SAName} \
  --query "[0].{value:value}" -o tsv)"

# Replace a variable in a file
sed -i 's/$user =.*/$user = "'$SAName'"/' vmExtension.ps1
# sed\escape character: , vs /
sed -i 's,$pwd =.*,$pwd = "'$key'",' vmExtension.ps1

#######################
# Upload files online #
#######################
# Valide: 30d URL
vmExtension="$(pastebinit -i vmExtension.ps1 -f powershell -b dpaste.com)".txt

# Upload *.json online #
# pastebinit -l --list
# sprunge.us if dpaste.com = null
armJson="$(pastebinit -i arm.json -f json -b dpaste.com)".txt

# Time: ~15m
az deployment group create -n gns3 \
  -g $rgName \
  -u $armJson \
  -p vmExtension=$vmExtension \
  --query '{clientPip:properties.outputs.clientPip.value,provisioningState:properties.provisioningState}'

# Del gns3 group
az group delete -n gns3 --yes
