# Lab15 - DHCP srv in gns3 web UI

---

## Acronym
* DHCP - Dynamic Host Configuration Protocol
* DMZ - Demilitarized zone
* FG - Fortigate
* NAT - Network Address Translation
* SW - Switch

---

## Diagram
[<img src="https://i.imgur.com/DEZyCJ6.png">](https://i.imgur.com/DEZyCJ6.png)

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
3. Network
  * Name format: Port{port1}
  * Segment size: 0


### SW
1. RAM: 456
2. Qemu binary: /usr/bin/qemu-system-x86_64
