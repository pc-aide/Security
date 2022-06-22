<#
  time: ~9 minutes 41 seconds
#>

# Variables
$ErrorActionPreference = "stop"

# path
$pth_usrPrf = "C:\Users\Default"
$pth_AppData = "C:\Users\Default\AppData\Roaming"
$pth_OneDriveSetup = "C:\Windows\SysWOW64\OneDriveSetup.exe"
# taskBar
$pth_PinnedTaskBar = "C:\Users\Default\AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

# drivers
$pth_drivers = "$env:winDir\system32\drivers"
# shell:startUp
$pth_StartUp = ni "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\StartUp" -type directory

# ddl-gns3 (93.3M)
$URL_gns3 = "https://github.com/GNS3/gns3-gui/releases/download/v2.2.33.1/GNS3-2.2.33.1-all-in-one.exe"

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

# tightVnc2.8.63 - because native client crash always for the WebTerm
$URL_tightVnc = "https://www.tightvnc.com/download/2.8.63/tightvnc-2.8.63-gpl-setup-64bit.msi"

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
        "check_for_update": false,
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
        "vnc_console_command": "C:\\Program Files\\TightVNC\\tvnviewer.exe %h:%p"
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
              "drawing_id": "f1675736-35fb-437a-8c17-7138eda57109",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"24\" width=\"207\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">Lab14 -Local user based policy</text></svg>",
              "x": -68,
              "y": -399,
              "z": 2
          },
          {
              "drawing_id": "33831838-6288-4037-8227-b5c01e805d4f",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"100\" width=\"200\"><rect fill=\"#ffff7f\" fill-opacity=\"1.0\" height=\"100\" stroke=\"#000000\" stroke-width=\"2\" width=\"200\" /></svg>",
              "x": -304,
              "y": -152,
              "z": 1
          },
          {
              "drawing_id": "78a03cfc-c573-4797-abf9-f27ff1ef2eb7",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"24\" width=\"33\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">LAN</text></svg>",
              "x": -226,
              "y": -143,
              "z": 2
          },
          {
              "drawing_id": "0b6db0d2-5117-4267-ac6f-0234873cbf52",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"24\" width=\"108\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">192.168.1.0/24</text></svg>",
              "x": -258,
              "y": -124,
              "z": 2
          },
          {
              "drawing_id": "f7397686-e4fc-4813-b5c2-1f004737b3e0",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"0\" width=\"281\"><line stroke=\"#000000\" stroke-width=\"2\" x1=\"0\" x2=\"281\" y1=\"0\" y2=\"0\" /></svg>",
              "x": -109,
              "y": -368,
              "z": 1
          }
      ],
      "links": [
          {
              "filters": {},
              "link_id": "d6606bf2-cb56-46d5-b3ba-c704417c7c1c",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 2,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Port3",
                          "x": 35,
                          "y": 64
                      },
                      "node_id": "ba842437-7113-4dae-b5e9-ba285d97967a",
                      "port_number": 0
                  },
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Loopback",
                          "x": 52,
                          "y": -22
                      },
                      "node_id": "5861eb87-977e-4c84-b6c1-161acab661ce",
                      "port_number": 1
                  }
              ],
              "suspend": false
          },
          {
              "filters": {},
              "link_id": "262c93fe-918d-4373-a666-75f2c8fd8b58",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Port1",
                          "x": 74,
                          "y": 27
                      },
                      "node_id": "ba842437-7113-4dae-b5e9-ba285d97967a",
                      "port_number": 0
                  },
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "nat0",
                          "x": -43,
                          "y": -5
                      },
                      "node_id": "a9a33d60-d5b5-4f07-9b2f-7097753d3e60",
                      "port_number": 0
                  }
              ],
              "suspend": false
          },
          {
              "filters": {},
              "link_id": "82f0ee47-60ec-44d3-a4f7-12578cb6f325",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 1,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Port2 \n(.100)",
                          "x": -61,
                          "y": -35
                      },
                      "node_id": "ba842437-7113-4dae-b5e9-ba285d97967a",
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
                      "node_id": "a88e5535-5118-4bbd-a199-ba95f0a3971f",
                      "port_number": 0
                  }
              ],
              "suspend": false
          },
          {
              "filters": {},
              "link_id": "1857249b-203a-4d5b-b02f-55a6b61fa32e",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 1,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Gi0/1",
                          "x": -51,
                          "y": -15
                      },
                      "node_id": "a88e5535-5118-4bbd-a199-ba95f0a3971f",
                      "port_number": 0
                  },
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "eth0\n(.1)",
                          "x": 84,
                          "y": 16
                      },
                      "node_id": "c4418b36-3f3f-4e29-8b47-931bd7fce68d",
                      "port_number": 0
                  }
              ],
              "suspend": false
          },
          {
              "filters": {},
              "link_id": "f620ef96-5616-43cd-a0ce-5ffd3aa76c3e",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 2,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Gi0/2",
                          "x": -10,
                          "y": 40
                      },
                      "node_id": "a88e5535-5118-4bbd-a199-ba95f0a3971f",
                      "port_number": 0
                  },
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "eth0\n(.2)",
                          "x": 80,
                          "y": 18
                      },
                      "node_id": "f794a1f0-8bc4-425e-87ba-51edc6d1a392",
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
              "x": -6,
              "y": 59,
              "z": 1
          },
          {
              "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
              "console": 5900,
              "console_auto_start": false,
              "console_type": "vnc",
              "custom_adapters": [],
              "first_port_name": null,
              "height": 70,
              "label": {
                  "rotation": 0,
                  "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                  "text": "PC-1",
                  "x": 14,
                  "y": -25
              },
              "locked": false,
              "name": "PC-1",
              "node_id": "c4418b36-3f3f-4e29-8b47-931bd7fce68d",
              "node_type": "docker",
              "port_name_format": "Ethernet{0}",
              "port_segment_size": 0,
              "properties": {
                  "adapters": 1,
                  "aux": 5000,
                  "console_http_path": "/",
                  "console_http_port": 80,
                  "console_resolution": "1024x768",
                  "container_id": "58007e8c6f5679fc51cefc64bbec3a610732c4c1fb3ee0d82feb86fd7f9ab925",
                  "environment": null,
                  "extra_hosts": null,
                  "extra_volumes": [],
                  "image": "gns3/webterm:latest",
                  "start_command": null,
                  "usage": "The /root directory is persistent."
              },
              "symbol": "firefox.svg",
              "template_id": "43dd6253-13d7-48bb-8cf3-866a1c540f7c",
              "width": 68,
              "x": -653,
              "y": -288,
              "z": 1
          },
          {
              "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
              "console": 5901,
              "console_auto_start": false,
              "console_type": "vnc",
              "custom_adapters": [],
              "first_port_name": null,
              "height": 70,
              "label": {
                  "rotation": 0,
                  "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                  "text": "PC-2",
                  "x": 21,
                  "y": 76
              },
              "locked": false,
              "name": "PC-2",
              "node_id": "f794a1f0-8bc4-425e-87ba-51edc6d1a392",
              "node_type": "docker",
              "port_name_format": "Ethernet{0}",
              "port_segment_size": 0,
              "properties": {
                  "adapters": 1,
                  "aux": 5001,
                  "console_http_path": "/",
                  "console_http_port": 80,
                  "console_resolution": "1024x768",
                  "container_id": "d1c5bd403ceee547b363dca80df59a2285323d63cec3a8a6a30345809a9bcb3d",
                  "environment": null,
                  "extra_hosts": null,
                  "extra_volumes": [],
                  "image": "gns3/webterm:latest",
                  "start_command": null,
                  "usage": "The /root directory is persistent."
              },
              "symbol": "firefox.svg",
              "template_id": "43dd6253-13d7-48bb-8cf3-866a1c540f7c",
              "width": 68,
              "x": -650,
              "y": -34,
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
              "node_id": "a88e5535-5118-4bbd-a199-ba95f0a3971f",
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
                  "mac_address": "0c:8e:55:35:00:00",
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
              "x": -440,
              "y": -129,
              "z": 1
          },
          {
              "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
              "console": 5004,
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
              "node_id": "ba842437-7113-4dae-b5e9-ba285d97967a",
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
                  "mac_address": "0c:84:24:37:00:00",
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
              "x": -12,
              "y": -118,
              "z": 1
          },
          {
              "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
              "console": null,
              "console_auto_start": false,
              "console_type": "none",
              "custom_adapters": [],
              "first_port_name": null,
              "height": 71,
              "label": {
                  "rotation": 0,
                  "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                  "text": "NAT-Internet",
                  "x": 32,
                  "y": -25
              },
              "locked": false,
              "name": "NAT-Internet",
              "node_id": "a9a33d60-d5b5-4f07-9b2f-7097753d3e60",
              "node_type": "nat",
              "port_name_format": "Ethernet{0}",
              "port_segment_size": 0,
              "properties": {
                  "ports_mapping": [
                      {
                          "interface": "virbr0",
                          "name": "nat0",
                          "port_number": 0,
                          "type": "ethernet"
                      }
                  ]
              },
              "symbol": ":/symbols/cloud.svg",
              "template_id": "df8f4ea9-33b7-3e96-86a2-c39bc9bb649c",
              "width": 159,
              "x": 409,
              "y": -134,
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
# tightVnc viewer
  try {
  Start-BitsTransfer -Source $URL_tightVnc `
  -Destination "d:\tightVnc.msi"
}
catch {
  $Error[0] | out-file d:\ErrorTightVnc.log
}

# gn3_gui.ini
try {
  $fil_gns3_gui |
  out-file "$pth_AppData_2_2\gns3_gui.ini" -Encoding ascii
}
catch {
  $Error[0] | out-file d:\ErrorAppdata_gns3_gui_ini.log
}
  
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

# InstallDir WinPcap
try{
  $pth_winPcap = ni ${env:ProgramFiles(x86)} -Name WinPcap -Type Directory
}catch{
  $Error[0] | out-file d:\ErroInstallDirWinPcap.log
}

# npf.sys x64
try{
  Start-BitsTransfer -Source $URL_npf_sys `
   -Destination "$pth_drivers\npf.sys"
}catch{
  $Error[0] | out-file d:\ErrorNpf_drivers_x64.log
}
# wpcap.dll x32
try{
  Start-BitsTransfer -Source $URL_wpcap_x32 `
  -Destination "d:\wpcap.dll"
  move-item "d:\wpcap.dll" "C:\Windows\SysWOW64\wpcap.dll"
}catch{
  $Error[0] | out-file d:\ErrorWpcap_ddl_x32.log
}
# packet.dll x64
try {
  Start-BitsTransfer $URL_packet_x64 `
  -Destination "$env:winDir\system32\packet.dll"
}
catch {
  $Error[0] | out-file d:\ErrorPacket_ddl_x64.log
}
# packet.dll x32
try{
  Start-BitsTransfer -Source $URL_packet_x32 `
   -Destination "$env:winDir\SysWOW64\Packet.dll"
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

# Install tightVnc.msi
try {
  start msiExec -args "/i d:\tightVnc.msi /q /l* d:\InstalltightVnc.log"
}
catch {
  $Error[0] | out-file d:\ErrorInstallTightVnc.log
}

# gns3\ubrige.exe depend wpcap.dll 32 in winPcap
# sometime files dll not present
if (!(Test-Path C:\Windows\system32\packet.dll)){
  "packet.dll x64 absent"  | out-file d:\ErrorAbsentPacket_dll_x64.log
  # checkup
  ls c:\windows\system32\pac* | out-file d:\checkUp_via_list_AbsentPacket_ddl_x64.log
  # Try with choco 
  choco install winpcap -y --log-file=d:\Install_via_choco_WinPcap.log
}
# packet.dll x64 present
try {
  start d:\gns3.exe -args "/S" -wait
}
catch {
  $Error[0] | out-file d:\ErrorInstallGns3.log
}

# no eula : ntuser.dat
try{
start-BitsTransfer $URL_ntuser `
  -Destination "$pth_usrPrf\NTUSER.DAT"
}catch{
  $Error[0] | out-file d:\ErrorNTUser.dat.log
}

# mount smb 
$user = ""
$Username = "localhost\$user"
$pwd = ""
$password = ConvertTo-SecureString -String $pwd -AsPlainText -Force
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username,$password
try {
  New-SmbGlobalMapping -LocalPath Z: -RemotePath "\\$user.file.core.windows.net\$user" -Credential $Cred  
}
catch {
  $Error[0] | out-file d:\ErrorMountSMB.log
}
