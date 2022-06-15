# Lab11 - Routing Redistribution

---

## Diagram
[<img src="https://i.imgur.com/4JKNqC2.png">](https://i.imgur.com/4JKNqC2.png)

---

## Synopsis
````md

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
  -f Lab.json --query '{clientPip:properties.outputs.clientPip.value,provisioningState:properties.provisioningState}'

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

## ps1
````ps1
<#
  time: ~8 minutes 41 seconds
#>

# Variables
$ErrorActionPreference = "stop"

# path
$pth_usrPrf = "C:\Users\Default"
$pth_AppData = "C:\Users\Default\AppData\Roaming"
$pth_OneDriveSetup = "C:\Windows\SysWOW64\OneDriveSetup.exe"
# taskBar
$pth_PinnedTaskBar = "C:\Users\Default\AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
# ddl x64
$pth_ddlX64 = "$env:winDir\system32"
# ddl x32
$pth_ddlX32 = "$env:winDir\SysWOW64\"
# drivers
$pth_drivers = "$env:winDir\system32\drivers"
# shell:startUp
$pth_StartUp = ni "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\StartUp" -type directory

# ddl-gns3 (93.3M)
$URL_gns3 = "https://downloads.solarwinds.com/solarwinds/GNS3/v2.2.32/GNS3-2.2.32-all-in-one-regular.exe"

# empty30G_qcow2 (FG)
$URL_empty30G_qcow2  = "https://cfhcable.dl.sourceforge.net/project/gns-3/Empty%20Qemu%20disk/empty30G.qcow2"
# SW_iosv_2020.qcow2
$URL_sw_iosv_2020_qcow2 = "https://master.dl.sourceforge.net/project/images/SW_iosv_2020.qcow2?viasf=1"
# FGT6.4.7.qcow2
$URL_FGT6_4_7_qcow2 = "https://master.dl.sourceforge.net/project/images/FGT6.4.7.qcow2?viasf=1"
# rt_159-3.m4.qcow
$URL_vios_159_3_m4_qcow2 = "https://master.dl.sourceforge.net/project/images/qcow2/vios_159-3.m4.qcow2?viasf=1"
# iosV_startup_config.img (router)
$URL_iosv_startup_cfg_img = "https://master.dl.sourceforge.net/project/images/qcow2/iosv_startup_config.img?viasf=1"

# fortinet.svg
$URL_fortinet_svg = "https://master.dl.sourceforge.net/project/images/fortinet.svg?viasf=1"
# firefox.svg
$URL_firefox_svg = "https://master.dl.sourceforge.net/project/images/firefox.svg?viasf=1"

# gns3_server.ini (appData)
$URL_gns3_server_ini = "https://master.dl.sourceforge.net/project/images/gns3_server.ini?viasf=1"
# gns3_controller_ini (appData)
$URL_gns3_controller_ini = "https://master.dl.sourceforge.net/project/images/AppData/02-06-2022/gns3_controller.ini?viasf=1"

# Packet dll_x64
$URL_packet_x64 = "https://master.dl.sourceforge.net/project/images/System32/Packet.dll?viasf=1"
# wpcap ddl_x32
$URL_wpcap_x32 = "https://master.dl.sourceforge.net/project/images/SysWOW64/wpcap.dll?viasf=1"
# pthreadVC.dll
$URL_pthreadVC_x32 = "https://master.dl.sourceforge.net/project/images/SysWOW64/pthreadVC.dll?viasf=1"
# Packet ddl_x32
$URL_packet_x32 = "https://master.dl.sourceforge.net/project/images/SysWOW64/Packet.dll?viasf=1"
# npf.sys
$URL_npf_sys = "https://master.dl.sourceforge.net/project/images/drivers/npf.sys?viasf=1"
# rpcapd.exe in InstallDir\WinPcap
$URL_rpcapd_exe = "https://altushost-swe.dl.sourceforge.net/project/images/ProgramFilesX86/rpcapd.exe"

# winPcap (tmp - bypass checkUp from gns3.exe)
$URL_winPcap_msi = "http://www.win10pcap.org/download/Win10Pcap-v10.2-5002.msi"

# ScriptLogon
$URL_ScriptLogon = "https://raw.githubusercontent.com/pc-aide/Windows/master/PowerShell/ARM/gns3_%26_loopback/StartUp/ScriptLogon/11-06-2022.ps1"

# NTUSER.DAT
$URL_ntuser = "https://master.dl.sourceforge.net/project/images/NTUSER.DAT/NTUSER.DAT?viasf=1"

# loopback
$loopbackName = "Loopback"
# loopback nic
$primary_interface = "Ethernet"

# files
# gns3_gui.ini
$fil_gns3_gui = @"
{
    "Builtin": {
        "default_nat_interface": "vmnet8"
    },
    "Docker": {
        "containers": []
    },
    "Dynamips": {
        "allocate_aux_console_ports": false,
        "dynamips_path": "",
        "ghost_ios_support": true,
        "mmap_support": true,
        "sparse_memory_support": true
    },
    "GraphicsView": {
        "default_label_color": "#000000",
        "default_label_font": "TypeWriter,10,-1,5,75,0,0,0,0,0",
        "default_note_color": "#000000",
        "default_note_font": "TypeWriter,10,-1,5,75,0,0,0,0,0",
        "draw_link_status_points": true,
        "draw_rectangle_selected_item": false,
        "drawing_grid_size": 25,
        "grid_size": 75,
        "limit_size_node_symbols": true,
        "scene_height": 1000,
        "scene_width": 2000,
        "show_grid": false,
        "show_grid_on_new_project": false,
        "show_interface_labels": false,
        "show_interface_labels_on_new_project": false,
        "show_layers": false,
        "snap_to_grid": false,
        "snap_to_grid_on_new_project": false,
        "zoom": null
    },
    "IOU": {
        "iourc_content": "",
        "license_check": true
    },
    "MainWindow": {
        "check_for_update": true,
        "debug_level": 0,
        "delay_console_all": 1500,
        "direct_file_upload": false,
        "experimental_features": false,
        "geometry": "AdnQywADAAAAAAHSAAAAgwAABa0AAANuAAAB0wAAAKIAAAWsAAADbQAAAAAAAAAAB4AAAAHTAAAAogAABawAAANt",
        "hdpi": true,
        "hide_getting_started_dialog": false,
        "hide_new_template_button": false,
        "hide_setup_wizard": true,
        "last_check_for_update": 0,
        "multi_profiles": false,
        "overlay_notifications": true,
        "recent_files": [],
        "recent_projects": [],
        "send_stats": true,
        "spice_console_command": "\"C:\\Program Files\\VirtViewer v7.0-256\\bin\\remote-viewer.exe\" spice://%h:%p",
        "state": "AAAA/wAAAAD9AAAAAwAAAAAAAAAAAAAAAPwCAAAAAfsAAAAiAHUAaQBOAG8AZABlAHMARABvAGMAawBXAGkAZABnAGUAdAAAAAAA/////wAAAIcA////AAAAAQAAAQAAAAGT/AIAAAAC+wAAADYAdQBpAFQAbwBwAG8AbABvAGcAeQBTAHUAbQBtAGEAcgB5AEQAbwBjAGsAVwBpAGQAZwBlAHQBAAAAQwAAAMcAAABZAP////sAAAA0AHUAaQBDAG8AbQBwAHUAdABlAFMAdQBtAG0AYQByAHkARABvAGMAawBXAGkAZABnAGUAdAEAAAEQAAAAxgAAAFkA////AAAAAwAAA5oAAADT/AEAAAAB+wAAACYAdQBpAEMAbwBuAHMAbwBsAGUARABvAGMAawBXAGkAZABnAGUAdAEAAABAAAADmgAAAEYAB///AAAClAAAAZMAAAAEAAAABAAAAAgAAAAI/AAAAAIAAAAAAAAAAQAAACIAdQBpAEIAcgBvAHcAcwBlAHIAcwBUAG8AbwBsAEIAYQByAwAAAAD/////AAAAAAAAAAAAAAACAAAAAwAAACAAdQBpAEcAZQBuAGUAcgBhAGwAVABvAG8AbABCAGEAcgEAAAAA/////wAAAAAAAAAAAAAAIAB1AGkAQwBvAG4AdAByAG8AbABUAG8AbwBsAEIAYQByAQAAAGL/////AAAAAAAAAAAAAAAmAHUAaQBBAG4AbgBvAHQAYQB0AGkAbwBuAFQAbwBvAGwAQgBhAHIBAAABmP////8AAAAAAAAAAA==",
        "stats_visitor_id": "bdde99d6-7b08-4a90-9d18-144f902e683a",
        "style": "Classic",
        "symbol_theme": "Classic",
        "telnet_console_command": "Solar-PuTTY.exe --telnet --hostname %h --port %p  --name \"%d\"",
        "vnc_console_command": "tvnviewer.exe %h:%p"
    },
    "NodesView": {
        "nodes_view_filter": 0
    },
    "Qemu": {
        "enable_hardware_acceleration": true,
        "require_hardware_acceleration": true
    },
    "VMware": {
        "block_host_traffic": true,
        "host_type": "ws",
        "vmnet_end_range": 19,
        "vmnet_start_range": 2,
        "vmrun_path": ""
    },
    "VPCS": {
        "vpcs_path": ""
    },
    "VirtualBox": {
        "vboxmanage_path": ""
    },
    "type": "settings",
    "version": "2.2.32"
}
"@

# test.gns3 - file
$fil_test_gns3 = @"
{
    "auto_close": true,
    "auto_open": false,
    "auto_start": false,
    "drawing_grid_size": 25,
    "grid_size": 75,
    "name": "test",
    "project_id": "a755b1fc-5c72-4a35-aae9-b1ff3cf7092c",
    "revision": 9,
    "scene_height": 1000,
    "scene_width": 2000,
    "show_grid": false,
    "show_interface_labels": true,
    "show_layers": false,
    "snap_to_grid": false,
    "supplier": null,
    "topology": {
        "computes": [
            {
                "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
                "host": "gns3",
                "name": "gns3",
                "port": 3080,
                "protocol": "http"
            }
        ],
        "drawings": [
            {
                "drawing_id": "94e23d4e-5fc9-4266-a451-ff7cc60ef138",
                "locked": false,
                "rotation": 0,
                "svg": "<svg height=\"100\" width=\"200\"><rect fill=\"#ffff7f\" fill-opacity=\"1.0\" height=\"100\" stroke=\"#000000\" stroke-width=\"2\" width=\"200\" /></svg>",
                "x": -407,
                "y": -136,
                "z": 1
            },
            {
                "drawing_id": "03d40926-e0ec-4e95-bcb8-457f6e4514a9",
                "locked": false,
                "rotation": 0,
                "svg": "<svg height=\"24\" width=\"33\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">LAN</text></svg>",
                "x": -326,
                "y": -125,
                "z": 2
            },
            {
                "drawing_id": "0e9291a8-c567-48aa-96ae-61cea2f542a1",
                "locked": false,
                "rotation": 0,
                "svg": "<svg height=\"24\" width=\"108\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">192.168.1.0/24</text></svg>",
                "x": -357,
                "y": -105,
                "z": 2
            },
            {
                "drawing_id": "4960bc4c-6f9b-40d1-9dcc-0433d49099af",
                "locked": false,
                "rotation": 0,
                "svg": "<svg height=\"100\" width=\"200\"><rect fill=\"#aaffff\" fill-opacity=\"1.0\" height=\"100\" stroke=\"#000000\" stroke-width=\"2\" width=\"200\" /></svg>",
                "x": 67,
                "y": -136,
                "z": 1
            },
            {
                "drawing_id": "55cebb1e-0fe4-42d6-a8ed-fe04f77da74c",
                "locked": false,
                "rotation": 0,
                "svg": "<svg height=\"24\" width=\"39\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">WAN</text></svg>",
                "x": 153,
                "y": -125,
                "z": 2
            },
            {
                "drawing_id": "d129cd9d-2896-4fe9-ab5e-23d0ff067186",
                "locked": false,
                "rotation": 0,
                "svg": "<svg height=\"24\" width=\"108\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">192.168.2.0/24</text></svg>",
                "x": 118,
                "y": -105,
                "z": 2
            },
            {
                "drawing_id": "f1675736-35fb-437a-8c17-7138eda57109",
                "locked": false,
                "rotation": 0,
                "svg": "<svg height=\"24\" width=\"206\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">Lab11 - Routing Redistribution</text></svg>",
                "x": -133,
                "y": -297,
                "z": 2
            }
        ],
        "links": [
            {
                "filters": {},
                "link_id": "cd72c182-551c-4ba5-a333-f913b1ab0bb8",
                "link_style": {},
                "nodes": [
                    {
                        "adapter_number": 2,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Port3",
                            "x": 39,
                            "y": 64
                        },
                        "node_id": "375ab30d-530e-45f8-9de6-897ea2f600d4",
                        "port_number": 0
                    },
                    {
                        "adapter_number": 0,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Loopback",
                            "x": 48,
                            "y": -16
                        },
                        "node_id": "5861eb87-977e-4c84-b6c1-161acab661ce",
                        "port_number": 1
                    }
                ],
                "suspend": false
            },
            {
                "filters": {},
                "link_id": "585a68bf-b7cb-47c4-ba81-539a126f53c0",
                "link_style": {},
                "nodes": [
                    {
                        "adapter_number": 0,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Port1\n(.100)",
                            "x": 87,
                            "y": -24
                        },
                        "node_id": "375ab30d-530e-45f8-9de6-897ea2f600d4",
                        "port_number": 0
                    },
                    {
                        "adapter_number": 0,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Gi0/0",
                            "x": -55,
                            "y": 23
                        },
                        "node_id": "8b543623-a673-46cc-9291-235aa99da544",
                        "port_number": 0
                    }
                ],
                "suspend": false
            },
            {
                "filters": {},
                "link_id": "e20b3ecd-c84a-4b1d-a4b5-7bb5ea03fc16",
                "link_style": {},
                "nodes": [
                    {
                        "adapter_number": 1,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Port2\n(.100)",
                            "x": -72,
                            "y": -20
                        },
                        "node_id": "375ab30d-530e-45f8-9de6-897ea2f600d4",
                        "port_number": 0
                    },
                    {
                        "adapter_number": 0,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Gi0/0",
                            "x": 65,
                            "y": 24
                        },
                        "node_id": "b2ce7b1b-faa2-4087-ae35-eb95006f059a",
                        "port_number": 0
                    }
                ],
                "suspend": false
            },
            {
                "filters": {},
                "link_id": "2d939839-a7a4-41f4-ad7f-53abb4fb00d5",
                "link_style": {},
                "nodes": [
                    {
                        "adapter_number": 1,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Gi0/1",
                            "x": -56,
                            "y": -16
                        },
                        "node_id": "b2ce7b1b-faa2-4087-ae35-eb95006f059a",
                        "port_number": 0
                    },
                    {
                        "adapter_number": 0,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Gi0/0",
                            "x": 79,
                            "y": 28
                        },
                        "node_id": "5be3a3ea-aa06-466d-a83a-2d2725b2c6ab",
                        "port_number": 0
                    }
                ],
                "suspend": false
            },
            {
                "filters": {},
                "link_id": "35db52f0-418f-46bc-9db9-32ce90abfb91",
                "link_style": {},
                "nodes": [
                    {
                        "adapter_number": 1,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Gi0/1",
                            "x": 60,
                            "y": 3
                        },
                        "node_id": "8b543623-a673-46cc-9291-235aa99da544",
                        "port_number": 0
                    },
                    {
                        "adapter_number": 0,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Gi0/0",
                            "x": 5,
                            "y": 55
                        },
                        "node_id": "0796e560-feae-417c-a7a8-88afbd75e776",
                        "port_number": 0
                    }
                ],
                "suspend": false
            },
            {
                "filters": {},
                "link_id": "2c7399f5-d033-4912-9a72-e1d68c560d58",
                "link_style": {},
                "nodes": [
                    {
                        "adapter_number": 2,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Gi0/2",
                            "x": 55,
                            "y": 49
                        },
                        "node_id": "8b543623-a673-46cc-9291-235aa99da544",
                        "port_number": 0
                    },
                    {
                        "adapter_number": 0,
                        "label": {
                            "rotation": 0,
                            "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                            "text": "Gi0/0",
                            "x": -43,
                            "y": -27
                        },
                        "node_id": "340846ac-70cb-4e9a-8a1d-716c68ae20ea",
                        "port_number": 0
                    }
                ],
                "suspend": false
            }
        ],
        "nodes": [
            {
                "compute_id": "local",
                "console": null,
                "console_auto_start": false,
                "console_type": "none",
                "custom_adapters": [],
                "first_port_name": null,
                "height": 60,
                "label": {
                    "rotation": 0,
                    "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                    "text": "MGMT",
                    "x": 5,
                    "y": 70
                },
                "locked": false,
                "name": "MGMT",
                "node_id": "5861eb87-977e-4c84-b6c1-161acab661ce",
                "node_type": "cloud",
                "port_name_format": "Ethernet{0}",
                "port_segment_size": 0,
                "properties": {
                    "interfaces": [
                        {
                            "name": "Ethernet",
                            "special": false,
                            "type": "ethernet"
                        },
                        {
                            "name": "Loopback",
                            "special": true,
                            "type": "ethernet"
                        }
                    ],
                    "ports_mapping": [
                        {
                            "interface": "Ethernet",
                            "name": "Ethernet",
                            "port_number": 0,
                            "type": "ethernet"
                        },
                        {
                            "interface": "Loopback",
                            "name": "Loopback",
                            "port_number": 1,
                            "type": "ethernet"
                        }
                    ],
                    "remote_console_host": "",
                    "remote_console_http_path": "/",
                    "remote_console_port": 23,
                    "remote_console_type": "none"
                },
                "symbol": ":/symbols/affinity/circle/red/client.svg",
                "template_id": "39e257dc-8412-3174-b6b3-0ee3ed6a43e9",
                "width": 60,
                "x": -99,
                "y": 97,
                "z": 1
            },
            {
                "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
                "console": 5000,
                "console_auto_start": false,
                "console_type": "telnet",
                "custom_adapters": [],
                "first_port_name": "",
                "height": 50,
                "label": {
                    "rotation": 0,
                    "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                    "text": "FG-1",
                    "x": 17,
                    "y": -25
                },
                "locked": false,
                "name": "FG-1",
                "node_id": "375ab30d-530e-45f8-9de6-897ea2f600d4",
                "node_type": "qemu",
                "port_name_format": "Port{port1}",
                "port_segment_size": 0,
                "properties": {
                    "adapter_type": "e1000",
                    "adapters": 10,
                    "bios_image": "",
                    "bios_image_md5sum": null,
                    "boot_priority": "c",
                    "cdrom_image": "",
                    "cdrom_image_md5sum": null,
                    "cpu_throttling": 0,
                    "cpus": 1,
                    "create_config_disk": false,
                    "hda_disk_image": "FGT6.4.7.qcow2",
                    "hda_disk_image_md5sum": "dcdf7bf5e1ff85c64638c1dfaa48ff65",
                    "hda_disk_interface": "virtio",
                    "hdb_disk_image": "empty30G.qcow2",
                    "hdb_disk_image_md5sum": "3411a599e822f2ac6be560a26405821a",
                    "hdb_disk_interface": "virtio",
                    "hdc_disk_image": "",
                    "hdc_disk_image_md5sum": null,
                    "hdc_disk_interface": "none",
                    "hdd_disk_image": "",
                    "hdd_disk_image_md5sum": null,
                    "hdd_disk_interface": "none",
                    "initrd": "",
                    "initrd_md5sum": null,
                    "kernel_command_line": "",
                    "kernel_image": "",
                    "kernel_image_md5sum": null,
                    "legacy_networking": false,
                    "linked_clone": true,
                    "mac_address": "0c:5a:b3:0d:00:00",
                    "on_close": "power_off",
                    "options": "",
                    "platform": "x86_64",
                    "process_priority": "normal",
                    "qemu_path": "/usr/bin/qemu-system-x86_64",
                    "ram": 1024,
                    "replicate_network_connection_state": true,
                    "usage": "Default username is admin, no password is set."
                },
                "symbol": "fortinet.svg",
                "template_id": "ef90e3b5-4b61-42e3-8396-d807d5a684af",
                "width": 70,
                "x": -104,
                "y": -104,
                "z": 1
            },
            {
                "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
                "console": 5002,
                "console_auto_start": false,
                "console_type": "telnet",
                "custom_adapters": [],
                "first_port_name": "",
                "height": 48,
                "label": {
                    "rotation": 0,
                    "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                    "text": "SW-1",
                    "x": 4,
                    "y": -25
                },
                "locked": false,
                "name": "SW-1",
                "node_id": "b2ce7b1b-faa2-4087-ae35-eb95006f059a",
                "node_type": "qemu",
                "port_name_format": "Gi{1}/{0}",
                "port_segment_size": 4,
                "properties": {
                    "adapter_type": "e1000",
                    "adapters": 16,
                    "bios_image": "",
                    "bios_image_md5sum": null,
                    "boot_priority": "c",
                    "cdrom_image": "",
                    "cdrom_image_md5sum": null,
                    "cpu_throttling": 0,
                    "cpus": 1,
                    "create_config_disk": false,
                    "hda_disk_image": "SW_iosv_2020.qcow2",
                    "hda_disk_image_md5sum": "99ecab32de12410c533e6abd4e9710aa",
                    "hda_disk_interface": "virtio",
                    "hdb_disk_image": "",
                    "hdb_disk_image_md5sum": null,
                    "hdb_disk_interface": "none",
                    "hdc_disk_image": "",
                    "hdc_disk_image_md5sum": null,
                    "hdc_disk_interface": "none",
                    "hdd_disk_image": "",
                    "hdd_disk_image_md5sum": null,
                    "hdd_disk_interface": "none",
                    "initrd": "",
                    "initrd_md5sum": null,
                    "kernel_command_line": "",
                    "kernel_image": "",
                    "kernel_image_md5sum": null,
                    "legacy_networking": false,
                    "linked_clone": true,
                    "mac_address": "0c:ce:7b:1b:00:00",
                    "on_close": "power_off",
                    "options": "",
                    "platform": "x86_64",
                    "process_priority": "normal",
                    "qemu_path": "/usr/bin/qemu-system-x86_64",
                    "ram": 768,
                    "replicate_network_connection_state": true,
                    "usage": "There is no default password and enable password. There is no default configuration present."
                },
                "symbol": ":/symbols/classic/multilayer_switch.svg",
                "template_id": "97bac41e-e09c-490c-8c6f-f433369bd99e",
                "width": 51,
                "x": -547,
                "y": -98,
                "z": 1
            },
            {
                "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
                "console": 5004,
                "console_auto_start": false,
                "console_type": "telnet",
                "custom_adapters": [],
                "first_port_name": "",
                "height": 48,
                "label": {
                    "rotation": 0,
                    "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                    "text": "SW-2",
                    "x": 4,
                    "y": -25
                },
                "locked": false,
                "name": "SW-2",
                "node_id": "8b543623-a673-46cc-9291-235aa99da544",
                "node_type": "qemu",
                "port_name_format": "Gi{1}/{0}",
                "port_segment_size": 4,
                "properties": {
                    "adapter_type": "e1000",
                    "adapters": 16,
                    "bios_image": "",
                    "bios_image_md5sum": null,
                    "boot_priority": "c",
                    "cdrom_image": "",
                    "cdrom_image_md5sum": null,
                    "cpu_throttling": 0,
                    "cpus": 1,
                    "create_config_disk": false,
                    "hda_disk_image": "SW_iosv_2020.qcow2",
                    "hda_disk_image_md5sum": "99ecab32de12410c533e6abd4e9710aa",
                    "hda_disk_interface": "virtio",
                    "hdb_disk_image": "",
                    "hdb_disk_image_md5sum": null,
                    "hdb_disk_interface": "none",
                    "hdc_disk_image": "",
                    "hdc_disk_image_md5sum": null,
                    "hdc_disk_interface": "none",
                    "hdd_disk_image": "",
                    "hdd_disk_image_md5sum": null,
                    "hdd_disk_interface": "none",
                    "initrd": "",
                    "initrd_md5sum": null,
                    "kernel_command_line": "",
                    "kernel_image": "",
                    "kernel_image_md5sum": null,
                    "legacy_networking": false,
                    "linked_clone": true,
                    "mac_address": "0c:54:36:23:00:00",
                    "on_close": "power_off",
                    "options": "",
                    "platform": "x86_64",
                    "process_priority": "normal",
                    "qemu_path": "/usr/bin/qemu-system-x86_64",
                    "ram": 768,
                    "replicate_network_connection_state": true,
                    "usage": "There is no default password and enable password. There is no default configuration present."
                },
                "symbol": ":/symbols/classic/multilayer_switch.svg",
                "template_id": "97bac41e-e09c-490c-8c6f-f433369bd99e",
                "width": 51,
                "x": 416,
                "y": -106,
                "z": 1
            },
            {
                "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
                "console": 5006,
                "console_auto_start": false,
                "console_type": "telnet",
                "custom_adapters": [],
                "first_port_name": "",
                "height": 45,
                "label": {
                    "rotation": 0,
                    "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                    "text": "PC-1",
                    "x": 14,
                    "y": -25
                },
                "locked": false,
                "name": "PC-1",
                "node_id": "5be3a3ea-aa06-466d-a83a-2d2725b2c6ab",
                "node_type": "qemu",
                "port_name_format": "Gi0/{0}",
                "port_segment_size": 0,
                "properties": {
                    "adapter_type": "e1000",
                    "adapters": 4,
                    "bios_image": "",
                    "bios_image_md5sum": null,
                    "boot_priority": "c",
                    "cdrom_image": "",
                    "cdrom_image_md5sum": null,
                    "cpu_throttling": 0,
                    "cpus": 1,
                    "create_config_disk": false,
                    "hda_disk_image": "vios_159-3.m4.qcow2",
                    "hda_disk_image_md5sum": "355b13ab821e64e2939fd7008d6304d7",
                    "hda_disk_interface": "virtio",
                    "hdb_disk_image": "IOSv_startup_config.img",
                    "hdb_disk_image_md5sum": "bc605651c4688276f81fd59dcf5cc786",
                    "hdb_disk_interface": "virtio",
                    "hdc_disk_image": "",
                    "hdc_disk_image_md5sum": null,
                    "hdc_disk_interface": "none",
                    "hdd_disk_image": "",
                    "hdd_disk_image_md5sum": null,
                    "hdd_disk_interface": "none",
                    "initrd": "",
                    "initrd_md5sum": null,
                    "kernel_command_line": "",
                    "kernel_image": "",
                    "kernel_image_md5sum": null,
                    "legacy_networking": false,
                    "linked_clone": true,
                    "mac_address": "0c:e3:a3:ea:00:00",
                    "on_close": "power_off",
                    "options": "",
                    "platform": "x86_64",
                    "process_priority": "normal",
                    "qemu_path": "/usr/bin/qemu-system-x86_64",
                    "ram": 512,
                    "replicate_network_connection_state": true,
                    "usage": "There is no default password and enable password. There is no default configuration present."
                },
                "symbol": ":/symbols/classic/router.svg",
                "template_id": "608e4d23-f20a-426c-bb86-674cb3ffde91",
                "width": 66,
                "x": -685,
                "y": -229,
                "z": 1
            },
            {
                "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
                "console": 5008,
                "console_auto_start": false,
                "console_type": "telnet",
                "custom_adapters": [],
                "first_port_name": "",
                "height": 45,
                "label": {
                    "rotation": 0,
                    "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                    "text": "RT-1",
                    "x": 14,
                    "y": -25
                },
                "locked": false,
                "name": "RT-1",
                "node_id": "0796e560-feae-417c-a7a8-88afbd75e776",
                "node_type": "qemu",
                "port_name_format": "Gi0/{0}",
                "port_segment_size": 0,
                "properties": {
                    "adapter_type": "e1000",
                    "adapters": 4,
                    "bios_image": "",
                    "bios_image_md5sum": null,
                    "boot_priority": "c",
                    "cdrom_image": "",
                    "cdrom_image_md5sum": null,
                    "cpu_throttling": 0,
                    "cpus": 1,
                    "create_config_disk": false,
                    "hda_disk_image": "vios_159-3.m4.qcow2",
                    "hda_disk_image_md5sum": "355b13ab821e64e2939fd7008d6304d7",
                    "hda_disk_interface": "virtio",
                    "hdb_disk_image": "IOSv_startup_config.img",
                    "hdb_disk_image_md5sum": "bc605651c4688276f81fd59dcf5cc786",
                    "hdb_disk_interface": "virtio",
                    "hdc_disk_image": "",
                    "hdc_disk_image_md5sum": null,
                    "hdc_disk_interface": "none",
                    "hdd_disk_image": "",
                    "hdd_disk_image_md5sum": null,
                    "hdd_disk_interface": "none",
                    "initrd": "",
                    "initrd_md5sum": null,
                    "kernel_command_line": "",
                    "kernel_image": "",
                    "kernel_image_md5sum": null,
                    "legacy_networking": false,
                    "linked_clone": true,
                    "mac_address": "0c:96:e5:60:00:00",
                    "on_close": "power_off",
                    "options": "",
                    "platform": "x86_64",
                    "process_priority": "normal",
                    "qemu_path": "/usr/bin/qemu-system-x86_64",
                    "ram": 512,
                    "replicate_network_connection_state": true,
                    "usage": "There is no default password and enable password. There is no default configuration present."
                },
                "symbol": ":/symbols/classic/router.svg",
                "template_id": "608e4d23-f20a-426c-bb86-674cb3ffde91",
                "width": 66,
                "x": 564,
                "y": -244,
                "z": 1
            },
            {
                "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
                "console": 5010,
                "console_auto_start": false,
                "console_type": "telnet",
                "custom_adapters": [],
                "first_port_name": "",
                "height": 45,
                "label": {
                    "rotation": 0,
                    "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                    "text": "RT-2",
                    "x": 1,
                    "y": 51
                },
                "locked": false,
                "name": "RT-2",
                "node_id": "340846ac-70cb-4e9a-8a1d-716c68ae20ea",
                "node_type": "qemu",
                "port_name_format": "Gi0/{0}",
                "port_segment_size": 0,
                "properties": {
                    "adapter_type": "e1000",
                    "adapters": 4,
                    "bios_image": "",
                    "bios_image_md5sum": null,
                    "boot_priority": "c",
                    "cdrom_image": "",
                    "cdrom_image_md5sum": null,
                    "cpu_throttling": 0,
                    "cpus": 1,
                    "create_config_disk": false,
                    "hda_disk_image": "vios_159-3.m4.qcow2",
                    "hda_disk_image_md5sum": "355b13ab821e64e2939fd7008d6304d7",
                    "hda_disk_interface": "virtio",
                    "hdb_disk_image": "IOSv_startup_config.img",
                    "hdb_disk_image_md5sum": "bc605651c4688276f81fd59dcf5cc786",
                    "hdb_disk_interface": "virtio",
                    "hdc_disk_image": "",
                    "hdc_disk_image_md5sum": null,
                    "hdc_disk_interface": "none",
                    "hdd_disk_image": "",
                    "hdd_disk_image_md5sum": null,
                    "hdd_disk_interface": "none",
                    "initrd": "",
                    "initrd_md5sum": null,
                    "kernel_command_line": "",
                    "kernel_image": "",
                    "kernel_image_md5sum": null,
                    "legacy_networking": false,
                    "linked_clone": true,
                    "mac_address": "0c:08:46:ac:00:00",
                    "on_close": "power_off",
                    "options": "",
                    "platform": "x86_64",
                    "process_priority": "normal",
                    "qemu_path": "/usr/bin/qemu-system-x86_64",
                    "ram": 512,
                    "replicate_network_connection_state": true,
                    "usage": "There is no default password and enable password. There is no default configuration present."
                },
                "symbol": ":/symbols/classic/router.svg",
                "template_id": "608e4d23-f20a-426c-bb86-674cb3ffde91",
                "width": 66,
                "x": 583,
                "y": 168,
                "z": 1
            }
        ]
    },
    "type": "topology",
    "variables": null,
    "version": "2.2.32",
    "zoom": 100
}
"@

# Pckg Nuget
# Find-PackageProvider -Name "NuGet" -AllVersions
Install-PackageProvider -Name "NuGet" -RequiredVersion " 2.8.5.208" -Force
# Modules
try{
  Install-Module -Name LoopbackAdapter -MinimumVersion 1.2.0.0 -Force
  # New NIC
  New-LoopbackAdapter -Name $loopbackName -Force

  # NIC_loopback
  $interface_loopback = Get-NetAdapter -Name $loopbackName
  $interface_main = Get-NetAdapter -Name $primary_interface

  # IP
  $loopback_ipv4 = '192.168.3.10'
  # Subnet mask
  $loopback_ipv4_length = '24'

  # Set the IPv4 address
  New-NetIPAddress -InterfaceAlias $loopbackName -IPAddress $loopback_ipv4 `
    -PrefixLength $loopback_ipv4_length -AddressFamily ipv4
  
}catch{
  $Error[0] | out-file d:\ErrorInstallModuleLoopback.txt
}

# UserProfile
cd $pth_usrPrf
'images','configs','projects','symbols' | 
  % {ni -Name ".\GNS3\$_" -ItemType 'Directory' -EA 0}
# QEMU
$pth_QEMU = ni $pth_usrPrf\GNS3\images -Name QEMU -Type Directory
# AppData
$pth_AppData_2_2 = ni $pth_AppData\GNS3 -Name 2.2 -Type Directory
# symbols
$pth_symbols = "$pth_usrPrf\GNS3\symbols"
# projects
$pth_projects = "$pth_usrPrf\GNS3\projects"

# gns3-app
Start-BitsTransfer -Source $URL_gns3 `
  -Destination "d:\gns3.exe" -EA 0

# SW_iosv_2020.qcow2
Start-BitsTransfer -Source $URL_sw_iosv_2020_qcow2 `
  -Destination "$pth_QEMU\SW_iosv_2020.qcow2" -EA 0
# FGT6.4.7.qcow2
Start-BitsTransfer -Source $URL_FGT6_4_7_qcow2 `
  -Destination "$pth_QEMU\FGT6.4.7.qcow2" -EA 0
# vios_159-3.m4.qcow2
Start-BitsTransfer -Source $URL_vios_159_3_m4_qcow2 `
  -Destination "$pth_QEMU\vios_159-3.m4.qcow2" -EA 0
# iosv_startup_config.img
Start-BitsTransfer -Source $URL_iosv_startup_cfg_img `
  -Destination "$pth_QEMU\iosv_startup_config.img" -EA 0
# empty30G.qcow2
Start-BitsTransfer -Source $URL_empty30G_qcow2 `
  -Destination $pth_QEMU\empty30G.qcow2 -EA 0
  
# fortinet.svg
Start-BitsTransfer -Source $URL_fortinet_svg `
  -Destination "$pth_symbols\fortinet.svg" -EA 0
# $URL_firefox.svg
Start-BitsTransfer -Source $URL_firefox_svg `
  -Destination "$pth_symbols\firefox.svg" -EA 0
  
# gns3_server.ini (appData)
Start-BitsTransfer -Source $URL_gns3_server_ini `
  -Destination "$pth_AppData_2_2\gns3_server.ini" -EA 0
# gns3_controller.ini (appData)
Start-BitsTransfer -Source $URL_gns3_controller_ini `
  -Destination "$pth_AppData_2_2\gns3_controller.ini" -EA 0
# gn3_gui.ini
$fil_gns3_gui | out-file "$pth_AppData_2_2\gns3_gui.ini" -Encoding ascii
  
# project files
try{
  $fil_test_gns3 | out-file $pth_usrPrf\GNS3\projects\test.gns3 -Encoding ascii
}catch{
  $Error[0] | out-file d:\ErrorTest.gns3.log
}

# acl.default (Access to the path is denied) ACL: read,execute
$acl = get-acl $pth_OneDriveSetup
# new rule
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("nt authority\system","FullControl","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl $pth_OneDriveSetup

# Block autoInstall OneDrive to a NewUser
try{
  ri $pth_OneDriveSetup -force  
}catch{
  $erro[0] | out-file "d:\ErrorRemoveOneDriveSetup.log"
}

# Turn off the Network Location wizard
ni HKLM:\System\CurrentControlSet\Control\Network\ -Name NewNetworkWindowOff

# Disable Privacy Settings Experience Using 
ni HKLM:\SOFTWARE\Policies\Microsoft\Windows\ -Name OOBE
New-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\OOBE `
  -Name DisablePrivacyExperience -Type DWord -Value 1
  
# Disable First run welcome page Edge
ni HKLM:\SOFTWARE\Policies\Microsoft\ -Name Edge
New-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Edge\ `
  -Name HideFirstRunExperience -Type DWord -Value 1
  
# Remove icons pinned to TaskBar
# try this in futur : Import-StartLayout -MountPath $env:systemdrive\ -LayoutPath "StartLayout.bin"
#ri "C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\*" -EA 0
  
# bypass checkUp gns3 wiht win10Pcap.msi
try{
  Start-BitsTransfer -Source $URL_winPcap_msi `
    -Destination "d:\win10Pcap.msi"
}catch{
  $Error[0] | out-file d:\ErrorInstallWin10Pcap_msi.log
}

# install silent Win10Pcap.msi
try{
  start msiExec -args "/i d:\win10Pcap.msi /q /l* d:\InstallW10Pcap_msi.log"
}catch{
  $Error[0] | out-file d:\ErrorInstallWin10Pcap_msi.log
}

# Install silent gns3.exe
try{
  start d:\gns3.exe -args "/S" -wait
}catch{
  $Error[0] | out-file ErrorInstallGns3.log
}

# uninstall W10Pcap.msi (deprecated files ddl)
try{
  start msiExec -args "/x {B5B58F8A-1984-4F3E-B400-235A6E005002} /q /l* d:\UninstallWin10Pcap_msi.log"
}catch{
  $Error[0] | out-file d:\ErrorUninstallWin10Pcap_msi.log
}

# InstallDir WinPcap
try{
  $pth_winPcap = ni ${env:ProgramFiles(x86)} -Name WinPcap -Type Directory
}catch{
  $Error[0] | out-file d:\ErroInstallDirWinPcap.log
}

# packet.dll x64
try{
  Start-BitsTransfer -Source $URL_packet_x64 `
    -Destination "$pth_ddlX64\Packet.dll"
}catch{
  $Error[0] | out-file d:\ErrorPacket_ddl_x64.log
}
# npf.sys
try{
  Start-BitsTransfer -Source $URL_npf_sys `
   -Destination "$pth_drivers\npf.sys"
}catch{
  $Error[0] | out-file d:\ErrorNpf_drivers_x64.log
}
# wpcap.dll x32
try{
  Start-BitsTransfer -Source $URL_wpcap_x32 `
   -Destination "$pth_ddlX32\wpcap.dll"
}catch{
  $Error[0] | out-file d:\ErrorWpcap_ddl_x32.log
}
# packet.dll x32
try{
  Start-BitsTransfer -Source $URL_packet_x32 `
   -Destination "$pth_ddlX32\Packet.dll"
}catch{
  $Error[0] | out-file d:\ErrorPacket_ddl_x32.log
}
# rpcapd.exe
try{
  Start-BitsTransfer -Source $URL_rpcapd_exe `
   -Destination "$pth_winPcap\rpcapd.exe"
}catch{
  $Error[0] | out-file d:\ErrorRpcapd_exe_InstallDirWinPcap.log
}

# app & 1st service
sc.exe create rpcapd type= own start= demand binPath= "$pth_winPcap\rpcad.exe" DisplayName= "Remote Package Capture Protocol..."
# driver (*.sys - 2e service)
sc.exe create npf binPath= "system32\drivers\npf.sys" type= kernel start= auto error= normal tag= no DisplayName= "NetGroup Packet Filter Driver"
# start-service
try{
  sc.exe start npf  
}catch{
  $Error[0] | out-file d:\Error2StartServiceNpf_sys.log
}

# no eula : ntuser.dat
try{
start-BitsTransfer $URL_ntuser `
  -Destination "$pth_usrPrf\NTUSER.DAT"
}catch{
  $Error[0] | out-file d:\ErrorNTUser.dat.log
}
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

# ospf
config router ospf
set router-id 1.1.1.1
config area
edit 0.0.0.0
next
end
config ospf-interface
edit "WAN"
set interface "port1"
set dead-interval 40
set hello-interval 10
next
end
config network
edit 1
set prefix 1.0.0.0 255.0.0.0
next
edit 2
set prefix 192.168.2.0 255.255.255.0
end
end

# hostname
conf system global
set hostname FG-1
end

````
