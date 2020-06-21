# Network Mapper (Nmap)

## Nmap Scripting Engine (NSE)

### NSE
* -dns-brute

## Doc
* Nmap: Network Exploration and Security Auditing Cookbook (1591pp)

Other tools
* Ncrak
* Ncat
* Nping
* Zenmap
* dnmap

## InstallDir
%programFiles(x86)%\Nmap\
* nseLib\
* scripts\

## Language
* Lua

## EXP
https://svn.nmap.org/nmap-exp/

## Usage
````Batch
#https://imgur.com/CHFOODZ 
#Apache
#CentOS
#-sn: ping scan - disable port scan
nmap -sn host
````

## Args
* -sn : disables port scanning, sending TCP SYN packet to port 443, TCP ACK packet to port 80 & ICMP ...
* -traceroute
