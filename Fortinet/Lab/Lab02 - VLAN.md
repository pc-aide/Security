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
### GNS3
````json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "VMName": {
      "type": "string",
      "defaultValue": "gns3",
      "metadata": {
        "description": "Name of the VM"
      }
    },
    "vmSize": {
      "type": "string",
      "defaultValue": "Standard_D2s_v3",
      "allowedValues": [
        "Standard_DS3_v2",
        "Standard_D4s_v3",
	"Standard_D2s_v3"
      ],
      "metadata": {
        "description": "D2s where s for hypervision present"
      }
    },
    "source_AddressPrefix": {
      "type": "string",
      "defaultValue": "192.168.1.10",
      "metadata": {
        "description": "Put here your client Public IP for the access for gns3 srv"
      }
    },
    "adminPassword": {
      "type": "securestring",
      "metadata": {
        "description": "Password of the VM"
      }
    }
  },
  "functions": [],
  "variables": {
    "userData": "[concat('#cloud-config\n runcmd:\n - curl https://raw.githubusercontent.com/GNS3/gns3-server/master/scripts/remote-install.sh > gns3-remote-install.sh\n - bash gns3-remote-install.sh --with-iou --with-i386-repository')]"
  },
  "resources": [
    {
      "name": "[concat(parameters('VMName'),'-PublicIP')]",
      "type": "Microsoft.Network/publicIPAddresses",
      "apiVersion": "2020-11-01",
      "location": "Canada Central",
      "properties": {
        "publicIPAllocationMethod": "Dynamic"
      }
    },
    {
      "name": "[concat(parameters('VMName'),'-nsg')]",
      "type": "Microsoft.Network/networkSecurityGroups",
      "apiVersion": "2020-11-01",
      "location": "Canada Central",
      "properties": {
        "securityRules": [
          {
            "name": "AllowOnlyOneClientInBound",
            "properties": {
              "description": "Allow only one Client on GNS3 SRV",
              "protocol": "Tcp",
              "sourcePortRange": "*",
              "destinationPortRange": "*",
              "sourceAddressPrefix": "[parameters('source_AddressPrefix')]",
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
      "name": "[concat(parameters('VMName'),'-vnet')]",
      "type": "Microsoft.Network/virtualNetworks",
      "apiVersion": "2020-11-01",
      "location": "Canada Central",
      "dependsOn": [
        "[resourceId('Microsoft.Network/networkSecurityGroups', concat(parameters('VMName'),'-nsg'))]"
      ],
      "properties": {
        "addressSpace": {
          "addressPrefixes": [
            "10.0.0.0/16"
          ]
        },
        "subnets": [
          {
            "name": "[concat(parameters('VMName'),'-subnet')]",
            "properties": {
              "addressPrefix": "10.0.0.0/24",
              "networkSecurityGroup": {
                "id": "[resourceId('Microsoft.Network/networkSecurityGroups', concat(parameters('VMName'),'-nsg'))]"
              }
            }
          }
        ]
      }
    },
    {
      "name": "[concat(parameters('VMName'),'-nic')]",
      "type": "Microsoft.Network/networkInterfaces",
      "apiVersion": "2020-11-01",
      "location": "Canada Central",
      "dependsOn": [
        "[resourceId('Microsoft.Network/publicIPAddresses', concat(parameters('VMName'),'-PublicIP'))]",
        "[resourceId('Microsoft.Network/virtualNetworks', concat(parameters('VMName'),'-vnet'))]"
      ],
      "properties": {
        "ipConfigurations": [
          {
            "name": "ipConfig1",
            "properties": {
              "privateIPAllocationMethod": "Dynamic",
              "publicIPAddress": {
                "id": "[resourceId('Microsoft.Network/publicIPAddresses', concat(parameters('VMName'),'-PublicIP'))]"
              },
              "subnet": {
                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', concat(parameters('VMName'),'-vnet'), concat(parameters('VMName'),'-subnet'))]"
              }
            }
          }
        ]
      }
    },
    {
      "name": "[parameters('VMName')]",
      "type": "Microsoft.Compute/virtualMachines",
      "apiVersion": "2021-03-01",
      "location": "Canada Central",
      "dependsOn": [
        "[resourceId('Microsoft.Network/networkInterfaces', concat(parameters('VMName'),'-nic'))]"
      ],
      "properties": {
        "hardwareProfile": {
          "vmSize": "[parameters('vmSize')]"
        },
        "osProfile": {
          "computerName": "[parameters('VMName')]",
          "adminUsername": "azureuser",
          "adminPassword": "[parameters('adminPassword')]",
          "customData": "[base64(variables('userData'))]"
        },
        "storageProfile": {
          "imageReference": {
            "publisher": "Canonical",
            "offer": "UbuntuServer",
            "sku": "18.04-LTS",
            "version": "latest"
          },
          "osDisk": {
            "name": "[concat(parameters('VMName'),'-OSDisk')]",
            "caching": "ReadWrite",
            "createOption": "FromImage"
          }
        },
        "networkProfile": {
          "networkInterfaces": [
            {
              "id": "[resourceId('Microsoft.Network/networkInterfaces', concat(parameters('VMName'),'-nic'))]"
            }
          ]
        }
      }
    }
  ],
  "outputs": {

  }
}
````

### Client
````json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "vmName": {
      "type": "string",
      "metadata": {
        "description": "Name of the VM"
      }
    },
    "vmSize": {
      "type": "string",
      "defaultValue": "Standard_DS3_v2",
      "allowedValues": [
        "Standard_DS3_v2",
        "Standard_D4s_v3"
      ],
      "metadata": {
        "description": "Size of the VM"
      }
    },
      "adminPassword": {
        "type": "securestring",
        "minLength": 12,
        "metadata": {
          "description": "Password for the virtual machine"
        }
      }
  },
  "variables": {},
  "resources": [
{
  "name": "[concat(parameters('vmName'),'-PublicIP')]",
  "type": "Microsoft.Network/publicIPAddresses",
  "apiVersion": "2020-11-01",
  "location": "Canada Central",
  "properties": {
    "publicIPAllocationMethod": "Dynamic"
  }
},
{
  "name": "[concat(parameters('vmName'),'-nsg')]",
  "type": "Microsoft.Network/networkSecurityGroups",
  "apiVersion": "2020-11-01",
  "location": "Canada Central",
  "properties": {
    "securityRules": [
      {
        "name": "nsgRule1",
        "properties": {
          "description": "description",
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
  "name": "[concat(parameters('vmName'),'-vnet')]",
  "type": "Microsoft.Network/virtualNetworks",
  "apiVersion": "2020-11-01",
  "location": "Canada Central",
  "dependsOn": [
    "[resourceId('Microsoft.Network/networkSecurityGroups', concat(parameters('vmName'),'-nsg'))]"
  ],
  "properties": {
    "addressSpace": {
      "addressPrefixes": [
        "10.0.0.0/16"
      ]
    },
    "subnets": [
      {
        "name": "[concat(parameters('vmName'),'-subnet')]",
        "properties": {
          "addressPrefix": "10.0.0.0/24",
          "networkSecurityGroup": {
            "id": "[resourceId('Microsoft.Network/networkSecurityGroups', concat(parameters('vmName'),'-nsg'))]"
          }
        }
      }
    ]
  }
},
{
  "name": "[concat(parameters('vmName'),'-nic')]",
  "type": "Microsoft.Network/networkInterfaces",
  "apiVersion": "2020-11-01",
  "location": "Canada Central",
  "dependsOn": [
    "[resourceId('Microsoft.Network/publicIPAddresses', concat(parameters('vmName'),'-PublicIP'))]",
    "[resourceId('Microsoft.Network/virtualNetworks', concat(parameters('vmName'),'-vnet'))]"
  ],
  "properties": {
    "ipConfigurations": [
      {
        "name": "ipConfig1",
        "properties": {
          "privateIPAllocationMethod": "Dynamic",
          "publicIPAddress": {
            "id": "[resourceId('Microsoft.Network/publicIPAddresses', concat(parameters('vmName'),'-PublicIP'))]"
          },
          "subnet": {
            "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', concat(parameters('vmName'),'-vnet'), concat(parameters('vmName'),'-subnet'))]"
          }
        }
      }
    ]
  }
},
{
  "name": "[parameters('vmName')]",
  "type": "Microsoft.Compute/virtualMachines",
  "apiVersion": "2021-03-01",
  "location": "Canada Central",
  "dependsOn": [
    "[resourceId('Microsoft.Network/networkInterfaces', concat(parameters('vmName'),'-nic'))]"
  ],
  "properties": {
    "hardwareProfile": {
      "vmSize": "[parameters('vmSize')]"
    },
    "osProfile": {
      "computerName": "windowsVM1",
      "adminUsername": "paul",
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
        "name": "[concat(parameters('vmName'),'_OSDisk')]",
        "caching": "ReadWrite",
        "createOption": "FromImage"
      }
    },
    "networkProfile": {
      "networkInterfaces": [
        {
          "id": "[resourceId('Microsoft.Network/networkInterfaces', concat(parameters('vmName'),'-nic'))]"
        }
      ]
    }
  }
}
  ],
  "outputs": {
    
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
