# Network Mapper (Nmap)

## Nmap Scripting Engine (NSE)

### script
* dns-brute
* broadcast-ping : Discovering live hosts in networks

## Doc
* Nmap: Network Exploration and Security Auditing Cookbook (1591pp)

Other tools
* Ncrak
* Ncat
* Nping
* Zenmap
* dnmap

## Categoriezes ports
* Open
* Closed
* Filtered
* Unfiltered
* Open/Filtered
* Close/Filtered

## Ping scanning techniques
* -PS/PA/PU/PY [portList]: TCP SYN/ACK, UDP or SCTP discovery to given ports
* -PE/PP/PM: ICMP echo, timestamp, & netmak request discovry probes
* -PO [protocol list]: IP protocol ping

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
* -dns-server or -n if you wish to skip
