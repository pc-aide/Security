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
|4|static route|show router static|[<img src="https://i.imgur.com/zWSKCpz.png">](https://i.imgur.com/zWSKCpz.png)|
|5|firewall policy|show firewall policy|[<img src="https://i.imgur.com/bMXmioM.png">](https://i.imgur.com/bMXmioM.png)|

---

## configure
|n|name|e.g.|O/P|
|-|----|----|----|
|1|IP static|config system interfa <br/> edit port2 <br/> set alias LAN <br/> set ip 10.47.0.1 255.255.255.0 <br/> set allowaccess http https ssh ping <br/> next <br/> end | [<img src="https://i.imgur.com/QOe4SWQ.png">](https://i.imgur.com/QOe4SWQ.png) <br/> [<img src="https://i.imgur.com/c0TSFiO.png">](https://i.imgur.com/c0TSFiO.png) |
|2|DHCP Server|config system dhcp server <br/> edit 1 <br/> set dns-service default <br/> set default-gateway 192.168.1.1 <br/> set netmask 255.255.255.0 <br/> set inteface port2 <br/> config ip-range <br/> edit 1 <br/> set start-ip 10.47.0.10 <br/> set end-ip 10.47.0.99 <br/> next <br/> end <br/> next <br/> end ||
|3|show the command output without - more|config system console <br/> set output standard <br/> end||
|4|scp enable|config system global <br/> set admin-scp enble <br/> scp admin@<ipFortigate>:sys_config <destination> |[<img src="https://i.imgur.com/f7jTDYB.png">](https://i.imgur.com/f7jTDYB.png)|
|5|the idle timeout(sec)|config system global<br/>set admin-lockout-duration 600<br/>end|[<img src="https://i.imgur.com/2lF9tox.png">](https://i.imgur.com/2lF9tox.png)|
|6|static route|configure router static <br/> edit 1 <br/> set device port1 <br/> set gateway 192.168.122.1 <br/> end | [<img src="https://i.imgur.com/mXDqUaJ.png">](https://i.imgur.com/mXDqUaJ.png) <br/> Σroute: <br/> [<img src="https://i.imgur.com/ZivIB96.png">](https://i.imgur.com/ZivIB96.png) <br> interface: <br/> [<img src="https://i.imgur.com/gk2q9YW.png">](https://i.imgur.com/gk2q9YW.png) <br/> gateway: <br/> [<img src="https://i.imgur.com/DHnC1DO.png">](https://i.imgur.com/DHnC1DO.png) <br/> checkUp: <br/> [<img src="https://i.imgur.com/otrjSMu.png">](https://i.imgur.com/otrjSMu.png) <br/> test: <br/> [<img src="https://i.imgur.com/YhEq9xg.png">](https://i.imgur.com/YhEq9xg.png) |
|7|hostname|config sys global <br/><br/> set hostname FG <br/><br/> end|[<img src="https://i.imgur.com/jLbvA0p.png">](https://i.imgur.com/jLbvA0p.png)|
|8|loopback|config sys inter <br/> edit loopback1 <br/> set vdom root <br/> set ip 1.1.1.1/8 set allow ping <br/> set type loopback <br/> next|[<img src="https://i.imgur.com/V5F7kAH.png">](https://i.imgur.com/V5F7kAH.png)|
  
---
  
### firewall
|n|name|e.g.|O/P|
|-|----|----|---|
|1|policy|config firewall policy <br/> edt 1 <br/> set name "WAN2LAN" <br/> set srcintf "port1" <br/>  set dstintf "port2" <br/>  set srcaddr "all" <br/> set dstaddr "all" <br/> set action accept <br/> set schedule "always" <br/> set service "PING" "TRACEROUTE" <br/> set logtraffic all <br/> next |[<img src="https://i.imgur.com/WcoUjGI.png">](https://i.imgur.com/WcoUjGI.png)|

---

## execute
|n|name|e.g.|O/P|
|-|----|----|---|
|1|ping|execute ping 8.8.8.8||
|2|factoryreset|execute factoryreset||
|3|dhcp renew|execute interface dhcpclient-renew port2||
|4|disk|#check ref<br/>#warning needReboot<br/>execute disk list<br/>disk scan refInteger|[<img src="https://i.imgur.com/bZt7hBo.png">](https://i.imgur.com/bZt7hBo.png)|
|5|format|execute formatLogDisk|[<img src="https://i.imgur.com/N0ybVVA.png">](https://i.imgur.com/N0ybVVA.png)|
  
---

## get
|n|name|e.g.|O/P|
|-|----|----|---|
|1|license|get syst status|[<img src="https://i.imgur.com/OdacxuB.png">](https://i.imgur.com/OdacxuB.png)|
|2|static|get router info routing-table static|[<img src="https://i.imgur.com/nr0AQjL.png">](https://i.imgur.com/nr0AQjL.png)|
|3|rip|get router info routing-tabgle rip|[<img src="https://i.imgur.com/ZyXfoqt.png">](https://i.imgur.com/ZyXfoqt.png)|  
