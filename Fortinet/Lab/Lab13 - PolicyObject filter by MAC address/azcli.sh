# -u email
read -p 'eamil: ' email
az login -u $email

########################
#    SMB for client    #
########################
# Storage Account Name
SAName="$(az storage account list --query "[].name" -o tsv)"
# key
key="$(az storage account keys list -n ${SAName} --query "[0].{value:value}" -o tsv)"

# Replace a variable in a file using sed
# -i --in-place[=SUFFIX]
# s - The substitute command
# g - Global replacement flag
# '$variableBash' 
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

#######################
# Deploy arm template #
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
