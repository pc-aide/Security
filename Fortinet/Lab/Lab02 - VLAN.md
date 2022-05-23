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

## webTerm
* config (eth0)
````sh
````
