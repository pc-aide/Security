# Lab15 - DHCP srv in gns3 web UI

---

## Acronym
* FG - Fortigate
* S - Switch
* R - Router

---

## Diagram

---

## qemu
### FG
1. General settings
  * RAM: 856
  * Qemu binary: /usr/bin/qemu-system-x86_64
2. HDD
  * HDA: 
    * Disk image: FGT6.4.7.qcow2 & 
    * Disk interface: virtio
  * HDB:
    * Disk image: empty30G.qcow2
    * disk int: virtio
3. Network
  * Name format: Port{port1}
  * Segment size: 0


### S
1. RAM: 456
2. Qemu binary: /usr/bin/qemu-system-x86_64

### R
1. RAM: 456
2. Qemu binary: /usr/bin/qemu-system-x86_64
