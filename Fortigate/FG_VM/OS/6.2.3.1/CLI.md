# ClI

---

## pdf
*


---

## Acronym
* SCP - secure copy protocol

---

## Intro
* next - check if correct commands (precedente)

---

## show
|n|name|e.g.|O/P|
|-|----|----|----|
|1|interface brief|show system inter ?|[<img src="https://i.imgur.com/cumaEDq.png">](https://i.imgur.com/cumaEDq.png)|
|2|dhcp server| show system dhcp server|[<img src="https://i.imgur.com/IQxDDWN.png">](https://i.imgur.com/IQxDDWN.png)|
|3|full-config|show full-configuration||

---

## configure
|n|name|e.g.|O/P|
|-|----|----|----|
|1|IP static|config system interfa <br/> edit port2 <br/> set alias LAN <br/> set ip 10.47.0.1 255.255.255.0 <br/> set allowaccess http https ssh ping <br/> next <br/> end | [<img src="https://i.imgur.com/QOe4SWQ.png">](https://i.imgur.com/QOe4SWQ.png) <br/> [<img src="https://i.imgur.com/c0TSFiO.png">](https://i.imgur.com/c0TSFiO.png) |
|2|DHCP Server|config system dhcp server <br/> edit 1 <br/> set dns-service default <br/> set default-gateway 192.168.1.1 <br/> set netmask 255.255.255.0 <br/> set inteface port2 <br/> config ip-range <br/> edit 1 <br/> set start-ip 10.47.0.10 <br/> set end-ip 10.47.0.99 <br/> next <br/> end <br/> next <br/> end ||
|3|show the command output without - more|config system console <br/> set output standard <br/> end||
|4|scp enable|config system global <br/> set admin-scp enble <br/> scp admin@<ipFortigate>:sys_config <destination> |[<img src="https://i.imgur.com/f7jTDYB.png">](https://i.imgur.com/f7jTDYB.png)|

---

## execute
|n|name|e.g.|O/P|
|-|----|----|---|
|1|ping|execute ping 8.8.8.8||
|2|factoryreset|execute factoryreset||
|3|dhcp renew|execute interface dhcpclient-renew port2||

---

## get
|n|name|e.g.|O/P|
|-|----|----|---|
|1|license|get syst status|[<img src="https://i.imgur.com/OdacxuB.png">](https://i.imgur.com/OdacxuB.png)|
