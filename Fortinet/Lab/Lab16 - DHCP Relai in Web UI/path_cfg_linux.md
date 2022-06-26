# path_cfg_linux

---

## gns3_controller.conf
* /etc/gns3/gns3_controller.conf
````sh
{
    "computes": [],
    "templates": [
        {
            "adapter_type": "e1000",
            "adapters": 4,
            "bios_image": "",
            "boot_priority": "c",
            "builtin": false,
            "category": "guest",
            "cdrom_image": "",
            "compute_id": "local",
            "console_auto_start": false,
            "console_type": "telnet",
            "cpu_throttling": 0,
            "cpus": 1,
            "custom_adapters": [
                {
                    "adapter_number": 0,
                    "adapter_type": "e1000"
                },
                {
                    "adapter_number": 1,
                    "adapter_type": "e1000"
                },
                {
                    "adapter_number": 2,
                    "adapter_type": "e1000"
                },
                {
                    "adapter_number": 3,
                    "adapter_type": "e1000"
                }
            ],
            "default_name_format": "{name}{0}",
            "first_port_name": "",
            "hda_disk_image": "FGT6.4.7.qcow2",
            "hda_disk_interface": "virtio",
            "hdb_disk_image": "",
            "hdb_disk_interface": "none",
            "hdc_disk_image": "",
            "hdc_disk_interface": "none",
            "hdd_disk_image": "",
            "hdd_disk_interface": "none",
            "initrd": "",
            "kernel_command_line": "",
            "kernel_image": "",
            "legacy_networking": false,
            "linked_clone": true,
            "mac_address": "",
            "name": "serguei",
            "on_close": "power_off",
            "options": "-nographic",
            "platform": "",
            "port_name_format": "Port{1}",
            "port_segment_size": 0,
            "process_priority": "normal",
            "qemu_path": "/usr/bin/qemu-system-x86_64",
            "ram": 1024,
            "symbol": "fortinet-red.svg",
            "template_id": "d907187e-ab72-4de4-afd9-be8ef9034b4a",
            "template_type": "qemu",
            "usage": "",
            "replicate_network_connection_state": true,
            "create_config_disk": false
        }
    ],
    "gns3vm": {
        "vmname": null,
        "when_exit": "stop",
        "headless": false,
        "enable": false,
        "engine": "vmware",
        "allocate_vcpus_ram": true,
        "ram": 2048,
        "vcpus": 1,
        "port": 80
    },
    "iou_license": {
        "iourc_content": "",
        "license_check": true
    },
    "appliances_etag": null,
    "version": "2.2.33.1"
}
````

---

## symbols
* /opt/gns3/GNS3/symbols/fortinet-red.svg

---

## gns3_server.conf
* /etc/gns3/gns3_server.conf
````sh
[Server]
host = 0.0.0.0
port = 3080
images_path = /opt/gns3/images
projects_path = /opt/gns3/projects
appliances_path = /opt/gns3/appliances
configs_path = /opt/gns3/configs
report_errors = True 

[Qemu]
enable_hardware_acceleration = True
require_hardware_acceleration = True
````

---

## images
* /opt/gns3/images/{IOS,IOU,QEMU} - need always *.md5sum
* 
