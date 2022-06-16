# BGP

---

## Acronym
* AS - Autonomous System
* BGP - Border Group Protocol


---

## ARM
````json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "adminPassword": {
            "type": "securestring",
            "minLength": 12
        }
    },
    "variables": {
        "adminUserName": "paul",
        "customData": "[concat('#cloud-config\n runcmd:\n - curl https://raw.githubusercontent.com/GNS3/gns3-server/master/scripts/remote-install.sh > gns3-remote-install.sh\n - bash gns3-remote-install.sh --with-iou --with-i386-repository')]",
        "vmSize": "Standard_D2s_v3",
        "vnetName": "gns3-vnet",
        "clientNSG": "[concat(variables('clientName'),'-nsg-nic')]",
        "clientName": "client",
        "clientScript": "[concat(variables('clientName'),'/','Script')]", //Only one version of an extension can be installed on a VM at a point in time. Specifying a custom script twice in the same Azure Resource Manager template for the same VM will fail. (https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows#extension-schema)
        "clientPIP":"[concat(variables('clientName'),'-pip')]",
        "clientVnetID": "[resourceId('Microsoft.Network/virtualNetworks', variables('vnetName'))]",
        "clientSubnetRef": "[concat(variables('clientVnetID'), '/subnets/', variables('test-vnetSubnet1Name'))]",
        "clientNicName": "[concat(variables('clientName'), '-nic')]",
        "test-vnetPrefix": "10.0.0.0/16",
        "test-vnetSubnet1Name": "Subnet-1",
        "test-vnetSubnet1Prefix": "10.0.0.0/24",
        "test-vnetSubnet2Name": "Subnet-2",
        "test-vnetSubnet2Prefix": "10.0.1.0/24",
        "gns3Name": "gns3",
        "gns3VnetID": "[resourceId('Microsoft.Network/virtualNetworks', variables('vnetName'))]",
        "gns3SubnetRef": "[concat(variables('gns3VnetID'), '/subnets/', variables('test-vnetSubnet1Name'))]",
        "gns3NicName": "[concat(variables('gns3Name'), '-nic')]"
    },
    "resources": [
        {
            "name": "[variables('clientNSG')]",
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2019-02-01",
            "location": "[resourceGroup().location]",
            "properties": {
                "securityRules": [
                    {
                        "name": "AllowRDPInBound",
                        "properties": {
                            "description": "Allow RDP InBound",
                            "protocol": "Tcp",
                            "sourcePortRange": "*",
                            "destinationPortRange": "3389",
                            "sourceAddressPrefix": "*",
                            "destinationAddressPrefix": "*",
                            "access": "Allow",
                            "priority": 100,
                            "direction": "Inbound"
                        }
                    }
                ]
            }
        },
        {
            "name": "[variables('clientPIP')]",
            "type": "Microsoft.Network/publicIPAddresses",
            "apiVersion": "2020-11-01",
            "location": "[resourceGroup().location]",
            "properties": {
                "publicIPAllocationMethod": "Static"
            }
        },
        {
            "name": "[variables('clientNicName')]",
            "type": "Microsoft.Network/networkInterfaces",
            "location": "[resourceGroup().location]",
            "apiVersion": "2020-11-01",
            "dependsOn": [
                "[concat('Microsoft.Network/networkSecurityGroups/', variables('clientNSG'))]",
                "[concat('Microsoft.Network/virtualNetworks/', variables('vnetName'))]",
                "[concat('Microsoft.Network/publicIpAddresses/',variables('clientPIP'))]"
            ],
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "properties": {
                            "publicIPAddress": {
                                "id": "[resourceId(resourceGroup().name,'Microsoft.Network/publicIpAddresses',variables('clientPIP'))]"
                            },
                            "privateIPAllocationMethod": "Dynamic",
                            "subnet": {
                                "id": "[variables('clientSubnetRef')]"
                            }
                        }
                    }
                ],
                "networkSecurityGroup": {
                    "id": "[resourceId('Microsoft.Network/networkSecurityGroups',variables('clientNSG'))]"
                }
            }
        },
        {
            "name": "[variables('clientName')]",
            "type": "Microsoft.Compute/virtualMachines",
            "location": "[resourceGroup().location]",
            "apiVersion": "2021-03-01",
            "dependsOn": [
                "[concat('Microsoft.Network/networkInterfaces/', variables('clientNicName'))]"
            ],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "[variables('vmSize')]"
                },
                "osProfile": {
                    "computerName": "[variables('clientName')]",
                    "adminUsername": "[variables('adminUserName')]",
                    "adminPassword": "[parameters('adminPassword')]",
                    "windowsConfiguration": {
                      "timeZone": "Eastern Standard Time" //[System.TimezoneInfo]::getSystemTimeZones() or tzutil /l
                    }
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "MicrosoftWindowsDesktop",
                        "offer": "windows-10",
                        "sku": "win10-21h2-entn-g2",
                        "version": "latest"
                    },
                    "osDisk": {
                        "name": "clientOSDisk",
                        "createOption": "FromImage"
                    }
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', variables('clientNicName'))]"
                            
                        }
                    ]
                }
            }
        },
        {
            "name": "[variables('vnetName')]",
            "type": "Microsoft.Network/virtualNetworks",
            "location": "[resourceGroup().location]",
            "apiVersion": "2020-06-01",
            "properties": {
                "addressSpace": {
                    "addressPrefixes": [
                        "[variables('test-vnetPrefix')]"
                    ]
                },
                "subnets": [
                    {
                        "name": "[variables('test-vnetSubnet1Name')]",
                        "properties": {
                            "addressPrefix": "[variables('test-vnetSubnet1Prefix')]"
                        }
                    },
                    {
                        "name": "[variables('test-vnetSubnet2Name')]",
                        "properties": {
                            "addressPrefix": "[variables('test-vnetSubnet2Prefix')]"
                        }
                    }
                ]
            }
        },
        {
            "name": "[variables('gns3NicName')]",
            "type": "Microsoft.Network/networkInterfaces",
            "location": "[resourceGroup().location]",
            "apiVersion": "2020-06-01",
            "dependsOn": [
                "[concat('Microsoft.Network/virtualNetworks/', variables('vnetName'))]"
            ],
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "properties": {
                            "privateIPAllocationMethod": "Dynamic",
                            "subnet": {
                                "id": "[variables('gns3SubnetRef')]"
                            }
                        }
                    }
                ]
            }
        },
        {
            "name": "[variables('gns3Name')]",
            "type": "Microsoft.Compute/virtualMachines",
            "location": "[resourceGroup().location]",
            "apiVersion": "2021-03-01",
            "dependsOn": [
                "[concat('Microsoft.Network/networkInterfaces/', variables('gns3NicName'))]"
            ],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "[variables('vmSize')]"
                },
                "osProfile": {
                    "computerName": "[variables('gns3Name')]",
                    "adminUsername": "[variables('adminUserName')]",
                    "adminPassword": "[parameters('adminPassword')]",
                    "customData": "[base64(variables('customData'))]"
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "Canonical",
                        "offer": "UbuntuServer",
                        "sku": "18.04-LTS",
                        "version": "latest"
                    },
                    "osDisk": {
                        "name": "gns3OSDisk",
                        "createOption": "FromImage"
                    }
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', variables('gns3NicName'))]"
                        }
                    ]
                }
            }
        },
        {
          "name": "[variables('clientScript')]",
          "type": "Microsoft.Compute/virtualMachines/extensions",
          "apiVersion": "2021-03-01",
          "location": "[resourceGroup().location]",
          "dependsOn": [
            "[resourceId('Microsoft.Compute/virtualMachines', variables('clientName'))]"
          ],
          "properties": {
            "publisher": "Microsoft.Compute",
            "type": "CustomScriptExtension",
            "typeHandlerVersion": "1.10",
            "autoUpgradeMinorVersion": true,
            "settings": {
              "commandToExecute": "powershell -nop -c \"iex(New-Object Net.WebClient).DownloadString('https://pastebin.com/raw/ZTxAYqyU')\""
            }
          }
        }
   ],
   "outputs": {
       "clientPip": {
           "type": "string",
           "value": "[reference(resourceId('Microsoft.Network/publicIPAddresses',variables('clientPIP'))).IpAddress]"
       }
    }
}
````

---

## azcli
````bash
# userName: email
az login --username 

# Deploy Template | time: ~9m
az deployment group create -n gns3 \
  -g $(az group create -n gns3 -l canadacentral \
  --query 'name' -o tsv) \
  -f gns3.json --query '{clientPip:properties.outputs.clientPip.value,provisioningState:properties.provisioningState}'

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
