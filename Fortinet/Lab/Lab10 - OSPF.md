# Lab10 - OSPF

---

## Acronym
* OSPF - Open Shortest Path First
* vdom - virtual domain

---

## Diagram

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
        "clientNSG": "[concat(variables('clientName'),'-nsg-nic')]",
        "clientName": "client",
        "clientScript": "[concat(variables('clientName'),'/','Script')]", //Only one version of an extension can be installed on a VM at a point in time. Specifying a custom script twice in the same Azure Resource Manager template for the same VM will fail. (https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows#extension-schema)
        "clientPIP":"[concat(variables('clientName'),'-pip')]",
        "clientVnetID": "[resourceId('Microsoft.Network/virtualNetworks', 'test-vnet')]",
        "clientSubnetRef": "[concat(variables('clientVnetID'), '/subnets/', variables('test-vnetSubnet1Name'))]",
        "clientNicName": "[concat(variables('clientName'), '-nic')]",
        "test-vnetPrefix": "10.0.0.0/16",
        "test-vnetSubnet1Name": "Subnet-1",
        "test-vnetSubnet1Prefix": "10.0.0.0/24",
        "test-vnetSubnet2Name": "Subnet-2",
        "test-vnetSubnet2Prefix": "10.0.1.0/24",
        "gns3Name": "gns3",
        "gns3VnetID": "[resourceId('Microsoft.Network/virtualNetworks', 'test-vnet')]",
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
                "[concat('Microsoft.Network/virtualNetworks/', 'test-vnet')]",
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
                    "adminPassword": "[parameters('adminPassword')]"
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
            "name": "test-vnet",
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
                "[concat('Microsoft.Network/virtualNetworks/', 'test-vnet')]"
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
              "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File 05-06-2022.ps1",
              "fileUris": [
                "https://raw.githubusercontent.com/pc-aide/Windows/master/PowerShell/ARM/gns3_%26_loopback/05-06-2022.ps1"
              ]
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
az deployment group create -n test \
  -g $(az group create -n test -l canadacentral \
  --query 'name' -o tsv) \
  -f Lab.json --query '{clientPip:properties.outputs.clientPip.value,provisioningState:properties.provisioningState}'

# Del test group
az group delete -n test --yes

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
edit loopback1
set ip 1.1.1.1/8
set type loopback
set allow ping
set vdom root
next
edit loopback2
set ip 2.2.2.2/8
set type loopback
set allow ping
set vdom root
next
edit loopback3
set ip 3.3.3.3/8
set type loopback
set allow ping
set vdom root
end

# remove first start wizard
config system admin
edit admin
set gui-ignore-release-overview-version "6.4.1"
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
set service "PING" "TELNET" "TRACEROUTE"
set logtraffic all
set schedule "always"
set nat enable
next
# WAN2LAN
edit 2
set name "WAN2LAN"
set srcintf "port1"
set dstintf "port2"
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

## PC-1
````ruby
# ip add
config t
int gi0/0
ip add 192.168.1.1 255.255.255.0
no shut
exit

# no routing
no ip routing
ip default-gateway 192.168.1.100

# hostname
hostname PC-1
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
exit

# route
ip route 0.0.0.0 0.0.0.0 192.168.2.100
end

# save
wr

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
exit

# route
ip route 0.0.0.0 0.0.0.0 192.168.2.100
end

# save
wr

````
