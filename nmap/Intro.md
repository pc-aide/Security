# Intro

## Nmap Scripting Engine (NSE)

### Scripts are divided into the following categories
* auth: This category is for scripts related to user authentication
* broadcast: Use broadcast petitions to gather information
* brute: Conduct brute-froce password auditing
* default: -sC 
* discovery: Related to host & service discovery
* dos: Denial of service attacks
* exploit: Exploit security vulnerabilities
* external: Depend on a third-party service
* fuzzer: Focused on fuzzing
* intrusive: Might crash something or generate a lot of network noise; scripts that system administrators may consider intrusive belong to this catory
* malware: Related to malware detection
* safe: Considered safe in all situations
* version: Used for advanced versioning
* vuln: Related to security vulnerabilities
  * 105 scripts for scanning

### Script arguments
* -script http-title -script-args http.useragent="Mozilla 999"
* -script -p80 -script http-trace -script-args path

### Script selection
* -script \<FileName or path/folder/catory/expression\>

### Script help
* -script-help \<script\>
* -script-help dns-* --Loaded 18 scripts

### Script multiple
* -script \<script1,script2,...\>
* -script dns-*

### All the scripts in the \<vuln\> category
* -sv -script vuln

###  Script in the version or discovery categories
* -sv -script="version,discovery"

### Scripts except for the 1 in the exploit category
* -sV -script "not exploit"

### All HTTP scripts except http-brute & http-slowloris
* -sV -script "(http-*) and not (http-brute or http-slowloris)"

### Debugging NSE script
* -sV -script-trace

## Doc
* Nmap: Network Exploration and Security Auditing Cookbook (1591pp)

## Other tools
* Ncrak
* Ncat
* Nping
* Zenmap
* dnmap

## URL
* https://nmap.org/cgi-bin/submit.cgi?
* https://svn.nmap.org/nmap-exp/

## Acronym
* CPE : Common Platform Enumeration
* CSRF : Cross Site Request Forgery
* XSS : Cross site scripting
* Nmap : Network Mapper 

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
* -dns-servers 
* -n (reverse DNS query) if you wish to skip
* -d --Debug
  * -d[1-9]
* -open --only open ports
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
  * --version-intensity [0-9]
* -O --OS detection (privileged user: raw packets)
  * sendig several probes using the TCP,UDP, ICMP protocols against opened & closed ports
  * -oscan-guess --force to guess OS
  * -oscan-limit --scan conditions are ideal
* -A --Aggressive detection (equivalent -O -sV -sC -traceroute)
* -v --verbose
* -sC --equivalent to --script=default
  * results included the O/P of the ssh-hostkey & http-title scripts
  * script scan mode, which tells Nmap to select the default sripts & execute them if the hsot or port rule matches

## Clock-skey
