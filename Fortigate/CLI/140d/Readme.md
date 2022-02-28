# CLI

---

## Acronym
* PAC - Proxy Auto-config

---

## URL
* [downlaod FortiOS (*.out)](https://it-help.tips/en/fortigate-firmware-download/)

---

## ssh
````sh
ssh -oKexAlgorithms=+diffie-hellman-group1 admin<IP>
````

[<img src="https://i.imgur.com/gQRhzxZ.png">](https://i.imgur.com/gQRhzxZ.png)

---

## OS
* FortiOS v5.2.4, Build 688

[<img src="https://i.imgur.com/QSRhEwk.png">](https://i.imgur.com/QSRhEwk.png)

* file *.out

* upgrade 5.2.4 -> 6.2.1 build 1263

[<img src="https://i.imgur.com/RfN8brQ.png">](https://i.imgur.com/RfN8brQ.png)

[<img src="https://i.imgur.com/O1S9JPg.png">](https://i.imgur.com/O1S9JPg.png)

* progress bar:

[<img src="https://i.imgur.com/sOq65Qd.png">](https://i.imgur.com/sOq65Qd.png)

* new GUI:

[<img src="https://i.imgur.com/jjTvLFJ.png">](https://i.imgur.com/jjTvLFJ.png)

---

## Defaul
* USR: admin
* pwd: empty

[<img src="https://i.imgur.com/vM4LF6z.png">](https://i.imgur.com/vM4LF6z.png)

* next : check if command are not bad
* end : save config
* # : comment

---

## Hot key
|n|name|hot key|
|-|----|-------|
|1|exit a mode|ctrl + d|

---

## CLI
### Execute
|n|e.g.|O/P|
|-|----|---|
|1|excute factoryreset|[<img src="https://i.imgur.com/TEcQgIP.png">](https://i.imgur.com/TEcQgIP.png)|
|2|execute ping 192.168.1.1|[<img src="https://i.imgur.com/mG2iPJB.png">](https://i.imgur.com/mG2iPJB.png)|


---

### Show
|n|e.g|O/P|
|-|---|---|
|1|show system interface|[<img src="https://i.imgur.com/qzy1zwu.png">](https://i.imgur.com/qzy1zwu.png) <br/> add ? for brief O/P <br/> [<img src="https://i.imgur.com/HsIb6d8.png">](https://i.imgur.com/HsIb6d8.png)|
|2|# show dhcp on srv LAN <br/> config system dhcp server <br/> show|[<img src="https://i.imgur.com/b4e7yvd.png">](https://i.imgur.com/b4e7yvd.png)|

---

### configure
|n|e.g.|O/P|
|-|----|---|
|1|# set IP for mgmt <br/>config system interface <br/>edit mgmt <br/> set ip 192.168.1.99 255.255.255.0 <br/> set allowaccess ssh ping https<br/> end|[<img src="https://i.imgur.com/rR3VZBw.png">](https://i.imgur.com/rR3VZBw.png)|
|2|# enable interface up\|down <br/> config system interface <br/><br/> edit wan1 <br/><br/> set status up <br/> end ||
|3|setup DHCP|conf sys int <br/> edit port1 <br/> set mode dhcp <br/> next <br/> end |[<img src="https://i.imgur.com/ZAzFkWp.png">](https://i.imgur.com/ZAzFkWp.png)|
