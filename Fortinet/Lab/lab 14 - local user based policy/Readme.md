# lab 14 - local user based policy

---

## Diagram
[<img src="https://i.imgur.com/aT3EUGO.png">](https://i.imgur.com/aT3EUGO.png)
      
---

## Sinopsis
````md
````

---

## FG-1
````ruby
````

---

## PCs
````ruby
auto eth0
iface eth0 inet static
	address 192.168.1.
	netmask 255.255.255.0
	gateway 192.168.1.100
	up echo nameserver 8.8.8.8 > /etc/resolv.conf
````
