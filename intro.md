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

## 2 default scanning methods used
* SYN Stealth Scan
* TCP Connect Scan

## Privileged VS Unprivileged
* nmap host - privileged launches a SYN Stealth Scan
* Unprivileged can't create raw packets use the TCP Connect Scan technique

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
* -dns-servers or -n (reverse DNS query) if you wish to skip
* -Pn: treat all hosts as online -- skip host discovery
* Specific port ranges
  * -p80,443 (Port list)
  * -p1-100 (Port range)
  * -p- (all ports 65 534)
  * -pT:25,U:53 (ports by protocols)
  * -p smtp (service name)
  * -p smtp* (service name wildcards)
  * -p[1-65535] (Only ports registered)
* -e -- selecting a network interface (-e InterfaceName)
* -sV --Sevice detection
  * sending different probes defined in the nmap-service-probes fil to the list of suspected open ports
* -O --OS detection (privileged user)
