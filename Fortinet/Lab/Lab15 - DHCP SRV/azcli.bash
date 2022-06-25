# acount cleanUp
az account clear

# login
read -p "Your email: " email
az login -u $email

# Storage Account unique name
export SAName="sa$RANDOM"
# Variables
rgName=gns3
location=canadacentral

# New gns3-RG
az group create \
  -n $rgName \
  -l $location

# New StorageAccount
az storage account create \
-n $SAName \
-g $rgName \
-l $location \
--sku Premium_LRS \
--kind FileStorage

# variable SAName
SAName="$(az storage account list \
  -g gns3 \
  --query "[].name" -o tsv)"

# New SMB
az storage share-rm create \
  --resource-group $rgName \
  --storage-account $SAName \
  --name $SAName \
  --enabled-protocols SMB

# key
key="$(az storage account keys list -n ${SAName} \
  --query "[0].{value:value}" -o tsv)"

# Replace a variable in a file
sed -i 's/$user =.*/$user = "'$SAName'"/' vmExtension.ps1
# sed\escape character: , vs /
sed -i 's,$pwd =.*,$pwd = "'$key'",' vmExtension.ps1

#######################
# Upload *.ps1 online #
#######################
# valide: 30d URL
vmExtension="$(pastebinit -i vmExtension.ps1 -f powershell -b dpaste.com)".txt

########################
# Upload *.json online #
########################
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
