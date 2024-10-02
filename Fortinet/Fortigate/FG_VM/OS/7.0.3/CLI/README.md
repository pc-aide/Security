# CLI

---

## execute
|n|name|eg|O/P|
|-|----|--|---|
|1|ping|`execute ping 192.168.1.1`|<img src="https://i.imgur.com/EreUhLZ.png">|
|2|factory reset|`execute factoryreset`|<img src="https://i.imgur.com/3SILhpx.png">|
|3|dhcp lease-list|`execute dhcp lease-list`||
|4|dhcp renew|`execute interface dhcpclient-renew port1`|<img src="https://i.imgur.com/3HQ4rf6.png">|

---

## config
|n|name|eg|O/P|
|-|----|--|---|
|1|ip static|`config system interface`<br/>`edit port2`<br/>`set alias LAN`<br/>`set role lan`<br/>`set ip 10.46.0.1/24`<br/>`set allowaccess http ping https ssh`<br/>`next`<br/>`end`|<img src="https://i.imgur.com/5NJyjXq.png">|
|2|dhcp to static|`show system interface port2`<br/>`config system interface`<br/>`edit port2`<br/>`set mode static`<br/>`set ip 10.46.0.1/24`<br/>`set alias LAN`<br/>`set allowaccess ping http https`<br/>`end`|<img src="https://i.imgur.com/IT6ON6p.png">|
|3|dhcp|`config system dhcp server`<br/>`edit 2`<br/>`set dns-service default`<br/>`set default-gateway 10.46.0.1`<br/>`set netmask 255.255.255.0`<br/>`set interface "port2"`<br/>`config ip-range`<br/>`edit 1`<br/>`set start-ip 10.46.0.2`<br/>`set end-ip 10.46.0.99`<br/>`next`<br/>`end`<br/>`next`<br/>`end`|<img src="https://i.imgur.com/wCLtMBA.png">|
|4|Allow Internet-To-Lan|`config firewall policy`<br/>`edit 1`<br/>`set name "Allow Internet-To-LAN`<br/>`set srcintf "port2"`<br/>`set dstintf "port1"`<br/>`set action accept`<br/>`set srcaddr "all"`<br/>`set dstaddr "all"`<br/>`set schedule "always"`<br/>`set service "Web Access"`<br/>`set logtraffic all`<br/>`set nat enable`<br/>`next`<br/>`end`|<img src="https://i.imgur.com/w4pXmxo.png">|

---

## show
|n|name|eg|O/P|
|-|----|--|---|
|1|policy|`show firewall policy`|<img src="https://i.imgur.com/DA0BQrL.png">|
|2|dhcp server|`show system dhcp server`|<img src="https://i.imgur.com/guk22Ta.png">|

---

## get
|n|name|eg|O/P|
|-|----|--|---|
|1|license expires|`# By default, it is valid for 15 days after a factory reset, and can be renewed for another 15 days, but the configuration will be wiped`<br/>`get system status \| grep -i license`|<img src="https://i.imgur.com/ZjCSuJR.png">|
|2|version firmware|`get system status \| grep -i version`|<img src="https://i.imgur.com/ugfilEj.png">|
