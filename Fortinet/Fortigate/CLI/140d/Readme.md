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

[<img src="https://i.imgur.com/lLtQSPX.png">](https://i.imgur.com/lLtQSPX.png)

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
|3|# dhcp client renew <br/> execute interface dhcpclient-renew port1||


---

### Show
|n|e.g|O/P|
|-|---|---|
|1|show system interface|[<img src="https://i.imgur.com/qzy1zwu.png">](https://i.imgur.com/qzy1zwu.png) <br/> add ? for brief O/P <br/> [<img src="https://i.imgur.com/HsIb6d8.png">](https://i.imgur.com/HsIb6d8.png)|
|2|# show dhcp on srv LAN <br/> config system dhcp server <br/> show|[<img src="https://i.imgur.com/b4e7yvd.png">](https://i.imgur.com/b4e7yvd.png)|
|3|policies|show firewall policy||

---

### configure
|n|e.g.|O/P|
|-|----|---|
|1|# set IP for mgmt <br/>config system interface <br/>edit mgmt <br/> set ip 192.168.1.99 255.255.255.0 <br/> set allowaccess ssh ping https<br/> end|[<img src="https://i.imgur.com/rR3VZBw.png">](https://i.imgur.com/rR3VZBw.png)|
|2|# enable interface up\|down <br/> config system interface <br/><br/> edit wan1 <br/><br/> set status up <br/> end ||
|3|setup DHCP|conf sys int <br/> edit port1 <br/> set mode dhcp <br/> next <br/> end |[<img src="https://i.imgur.com/ZAzFkWp.png">](https://i.imgur.com/ZAzFkWp.png)|
|4| #config DHCP <br/> config system dhcp server <br/> edit 1 <br/> set dns-service default <br/> set default-gateway 192.168.1.2 <br/> set netmask 255.255.255.0 <br/> set interface "port1" <br/> config ip-range <br/> edit 1 <br/> set start-ip 192.168.1.1 <br/> set end-ip 192.168.1.99 <br/> next <br/> end <br/> |[<img src="https://i.imgur.com/gG5i2jf.png">](https://i.imgur.com/gG5i2jf.png)|
|5|#delete IPv4 Policy<br/>config firewall policy<br/>delete \<policyId\>|[<img src="https://i.imgur.com/rW3eqbg.png">](https://i.imgur.com/rW3eqbg.png)|
