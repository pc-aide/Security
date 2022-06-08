# Lab08 - Policy routing

---

## Diagram
[<img src="https://i.imgur.com/UK6FB1P.png">](https://i.imgur.com/UK6FB1P.png)

---

## ps1
````ps1
# Deploy template (time: ~8m6s)
$Deploy = New-AzResourceGroupDeployment -ResourceGroupName (New-AzResourceGroup -Name test -location canadacentral).ResourceGroupName `
-TemplateFile 'Lab002 - outputs.json' -Name test

# O/P 
$Deploy |
select -property ProvisioningState,Timestamp,
@{n='client-pip';e={($Deploy.outputs.clientPIP.value)}} | fl

# Delete RGTest, 
Remove-azResourceGroup -name test -force
Remove-azResourceGroup -name NetworkWatcherRG -force
````

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
       "client-pip": {
           "type": "string",
           "value": "[reference(resourceId('Microsoft.Network/publicIPAddresses',variables('clientPIP'))).IpAddress]"
       }
    }
}
````

---

## FG
````fortiOS
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

# remove first start wizard
config system admin
edit admin
set gui-ignore-release-overview-version "6.4.1"
end

# port 0 static
config sys int
set allow ping
edit port1
set mode static
end

# hostname
conf system global
set hostname FG-1
end
````

---

## PC-1
````sh
auto eth0
iface eth0 inet static
	address 192.168.1.1
	netmask 255.255.255.0
	gateway 192.168.1.100
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
````

---

## PC-2
````ios
# ip add
config t
int gi0/0
ip add 192.168.1.2 255.255.255.0
no shut
exit

# no routing
no ip routing
ip default-gateway 192.168.1.100

# hostname
hostname PC-2
end

# save
wr

````

---

## RT-1
````ios
# hostname
config t
hostname RT-1

# interfaces:
int gi0/0 
ip add 192.168.2.1 255.255.255.0
no shut
exit
int loopback 1
ip add 8.8.8.8 255.0.0.0
no shut
exit

# telnet
line vty 0 4
transport input all
password 123
login
exit

# cred
username admin privilege 15 password 123

# web srv
ip http server
ip http secure-server
ip http authentication local

# route
ip route 0.0.0.0 0.0.0.0 192.168.2.100
end

# save
wr

````

---

## RT-2
````ios
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

# telnet
line vty 0 4
transport input all
password 123
login
exit

# cred
username admin privilege 15 password 123

# web srv
ip http server
ip http secure-server
ip http authentication local

# route
ip route 0.0.0.0 0.0.0.0 192.168.2.100
end

# save
wr

````
