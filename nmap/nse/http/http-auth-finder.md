# http-auth-finder

---

## no auth-scheme !?
* pfsense
````sh
nmap -script http-auth-finder -p443 <host>
Starting Nmap 7.80 ( https://nmap.org ) at 2021-07-04 16:30 EDT
Nmap scan report for pfSense-01.localdomain (<host>)
Host is up (0.00024s latency).

PORT    STATE SERVICE
443/tcp open  https
| http-auth-finder: 
| Spidering limited to: maxdepth=3; maxpagecount=20; withinhost=pfsense-01.localdomain
|   url                                  method
|_  https://pfsense-01.localdomain:443/  FORM

Nmap done: 1 IP address (1 host up) scanned in 0.26 seconds
````
