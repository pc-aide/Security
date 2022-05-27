# Lab02 - VLAN

---

## Diagram
[<img src="https://i.imgur.com/mqUAZDN.png">](https://i.imgur.com/mqUAZDN.png)

---

## Req
1. FG1
2. SW1\Cisco
3. 3x VLAN
   1. HR
   2. SAL
   3. IT

---

## user-data
* gns3_srv_ubu.sh
````
#!/bin/sh
# Download
curl https://raw.githubusercontent.com/GNS3/gns3-server/master/scripts/remote-install.sh > gns3-remote-install.sh

# run with args
# --with-iou: Install IOU
# --with-i386-repository: Add the i386 repositories required by IOU if
# they are not already available on the system. Warning
bash gns3-remote-install.sh --with-iou --with-i386-repository

# ifconfig eth0 | grep inet | port 3080
````

---

## cloud-config
````yaml
#cloud-config

# Tested on ubuntu-srv-18.04 LTS
# Req.: hypervisor : true
#
# Time: ~2m40s
#
# curl <*.sh> Download
# --with-iou: Install IOU
# --with-i386-repository: Add the i386 repositories required by IOU if
# they are not already available on the system. Warning
runcmd:
  - curl https://raw.githubusercontent.com/GNS3/gns3-server/master/scripts/remote-install.sh > gns3-remote-install.sh
  - bash gns3-remote-install.sh --with-iou --with-i386-repository

# Once installed, ifconfig eth0 | grep inet | port 3080
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
    "resources": [
        {
            "name": "[variables('nsgClient')]",
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
            "name": "[variables('PublicIPClient')]",
            "type": "Microsoft.Network/publicIPAddresses",
            "apiVersion": "2020-11-01",
            "location": "[resourceGroup().location]",
            "properties": {
                "publicIPAllocationMethod": "Dynamic"
            }
        },
        {
            "name": "[variables('clientNicName')]",
            "type": "Microsoft.Network/networkInterfaces",
            "location": "[resourceGroup().location]",
            "apiVersion": "2020-11-01",
            "dependsOn": [
                "[concat('Microsoft.Network/networkSecurityGroups/', variables('nsgClient'))]",
                "[concat('Microsoft.Network/virtualNetworks/', 'test-vnet')]",
                "[concat('Microsoft.Network/publicIpAddresses/',variables('PublicIPClient'))]"
            ],
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "properties": {
                            "publicIPAddress": {
                                "id": "[resourceId(resourceGroup().name,'Microsoft.Network/publicIpAddresses',variables('PublicIPClient'))]"
                            },
                            "privateIPAllocationMethod": "Dynamic",
                            "subnet": {
                                "id": "[variables('clientSubnetRef')]"
                            }
                        }
                    }
                ],
                "networkSecurityGroup": {
                    "id": "[resourceId('Microsoft.Network/networkSecurityGroups',variables('nsgClient'))]"
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
            "apiVersion": "2015-06-15",
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
            "apiVersion": "2015-06-15",
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
        }
    ],
    "variables": {
        "PublicIPClient":"[concat(variables('clientName'),'PublicIP')]",
        "nsgClient": "[concat(variables('clientName'),'-nsg')]",
        "customData": "[concat('#cloud-config\n runcmd:\n - curl https://raw.githubusercontent.com/GNS3/gns3-server/master/scripts/remote-install.sh > gns3-remote-install.sh\n - bash gns3-remote-install.sh --with-iou --with-i386-repository')]",
        "clientName": "client",
        "adminUserName": "paul",
        "gns3Name": "gns3",
        "vmSize": "Standard_D2s_v3",
        "clientVnetID": "[resourceId('Microsoft.Network/virtualNetworks', 'test-vnet')]",
        "clientSubnetRef": "[concat(variables('clientVnetID'), '/subnets/', variables('test-vnetSubnet1Name'))]",
        "clientNicName": "[concat(variables('clientName'), 'NetworkInterface')]",
        "test-vnetPrefix": "10.0.0.0/16",
        "test-vnetSubnet1Name": "Subnet-1",
        "test-vnetSubnet1Prefix": "10.0.0.0/24",
        "test-vnetSubnet2Name": "Subnet-2",
        "test-vnetSubnet2Prefix": "10.0.1.0/24",
        "gns3VnetID": "[resourceId('Microsoft.Network/virtualNetworks', 'test-vnet')]",
        "gns3SubnetRef": "[concat(variables('gns3VnetID'), '/subnets/', variables('test-vnetSubnet1Name'))]",
        "gns3NicName": "[concat(variables('gns3Name'), 'NetworkInterface')]"
    }
}
````

---

## webTerm
* EditConfig\eth0\dhcp:
````sh
#
# This is a sample network config, please uncomment lines to configure the network
#

# Uncomment this line to load custom interface files
# source /etc/network/interfaces.d/*

# Static config for eth0
#auto eth0
#iface eth0 inet static
#	address 192.168.0.2
#	netmask 255.255.255.0
#	gateway 192.168.0.1
#	up echo nameserver 192.168.0.1 > /etc/resolv.conf

# DHCP config for eth0
auto eth0
iface eth0 inet dhcp
````
* EditConfig\eth0\static:
````sh
#
# This is a sample network config, please uncomment lines to configure the network
#

# Uncomment this line to load custom interface files
# source /etc/network/interfaces.d/*

# Static config for eth0
auto eth0
iface eth0 inet static
	address 192.168.10.2
	netmask 255.255.255.0
	gateway 192.168.10.100
	up echo nameserver 8.8.8.8 > /etc/resolv.conf

# DHCP config for eth0
#auto eth0
#iface eth0 inet dhcp
````

[<img src="https://i.imgur.com/nk5TXlx.png">](https://i.imgur.com/nk5TXlx.png)
