# nse
Nmap Script Engine

## URL
* [nmap/External script library](https://secwiki.org/w/Nmap/External_Script_Library)

## Location
* Script :  c:\progra~2\nmpa\scripts\*.nse
* Lib : c:\pogra~2\nmap\nseLib\*.lua

## Scripts
* dns-brute
* broadcast-ping : Discovering live hosts in networks
* scrip-trace -- show all data sent & received
  * User-Agent: Mozilla/5.0 compatible !?\
* whois-domain --(E.g. O/P: Domain name record, Admin Name, Admin Organization, Admin Country, Name Server,NetRange, OrgName, etc)
* -script-updatedb --adding new scripts
  * Location : Scripts\script.db
  * E.g: 
    * nmap -script ip-geolocation-ip2location rds.ca -script-args ip-geolocation-ip2location.ip2location_db=c:\pogra~2\nmap\db\ip2location-lite-db1.bin
    [<img src="https://i.imgur.com/81OQEXYg.png">](https://i.imgur.com/81OQEXYg.png)
*
