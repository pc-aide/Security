# http-auth

---


## Doc
* [File http-auth](https://nmap.org/nsedoc/scripts/http-auth-finder.html)

---

## Intro
* 4x values (authorisation)
  * basic
  * digest
  * ntlm
  * negociate

---

## basic
````sh
# -script-args (optional)
nmap -script http-auth -script-args http-auth.path=/gui/web/index.html -p<port> <host>
Starting Nmap 7.80 ( https://nmap.org ) at 2021-07-04 15:49 EDT
Nmap scan report for mkdocs.localdomain (<host>)
Host is up (0.00041s latency).

PORT     STATE SERVICE
<port>/tcp open  http-proxy
| http-auth: 
| HTTP/1.1 401 Unauthorized\x0D
|_  Basic realm=uTorrent

Nmap done: 1 IP address (1 host up) scanned in 0.17 seconds
````

---

## no 4x values !?
* juste a page with authorisation + security (ssl)
* esxi-7:
````sh
nmap -script http-auth -script-args http-auth.path=/ui/#/login -p443 <host>
Starting Nmap 7.80 ( https://nmap.org ) at 2021-07-04 16:06 EDT
Nmap scan report for <host>
Host is up (0.00048s latency).

PORT    STATE SERVICE
443/tcp open  https

Nmap done: 1 IP address (1 host up) scanned in 0.17 seconds
````

[<img src="https://i.imgur.com/imPMAWa.png">](https://i.imgur.com/imPMAWa.png)
