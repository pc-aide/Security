# CLI

---

## execute
|n|name|eg|O/P|
|-|----|--|---|
|1|ping|`execute ping 192.168.1.1`|<img src="https://i.imgur.com/EreUhLZ.png">|

---

## config
|n|name|eg|O/P|
|-|----|--|---|
|1|ip static|`config system interface`<br/>`edit port2`<br/>`set alias LAN`<br/>`set role lan`<br/>`set ip 10.46.0.1/24`<br/>`set allowaccess http ping https ssh`<br/>`next`<br/>`end`|<img src="https://i.imgur.com/5NJyjXq.png">|
|2|dhcp to static|`show system interface port2`<br/>`config system interface`<br/>`edit port2`<br/>`set mode static`<br/>`set ip 10.46.0.1/24`<br/>`set alias LAN`<br/>`set allowaccess ping http http`<br/>`end`|<img src="https://i.imgur.com/IT6ON6p.png">|

---

## show
|n|name|eg|O/P|
|-|----|--|---|
|1|policy|`show firewall policy`|<img src="https://i.imgur.com/DA0BQrL.png">|

---

## get
|n|name|eg|O/P|
|-|----|--|---|
|1|license expires|`# By default, it is valid for 15 days after a factory reset, and can be renewed for another 15 days, but the configuration will be wiped`<br/>`get system status \| grep -i license`||
