# http-auth

---

## basic
````sh
# -script-args (optional)
nmap -script http-auth -script-args http-auth.path=/gui/web/index.html -p<port> <host>
Starting Nmap 7.80 ( https://nmap.org ) at 2021-07-04 15:49 EDT
Nmap scan report for mkdocs.localdomain (<host>)
Host is up (0.00041s latency).

PORT     STATE SERVICE
8080/tcp open  http-proxy
| http-auth: 
| HTTP/1.1 401 Unauthorized\x0D
|_  Basic realm=uTorrent

Nmap done: 1 IP address (1 host up) scanned in 0.17 seconds
````
