# FAZ

---

## Acronym
* FAZ - FortiAnalyzer

---

## IP address
|n|name|O/P|
|-|----|---|
|1|default MGMT (port1)-> https:192.168.1.99|[<img src="https://i.imgur.com/bYVYzwC.png">](https://i.imgur.com/bYVYzwC.png)<br/>[<img src="https://i.imgur.com/zm0OXPh.png">](https://i.imgur.com/zm0OXPh.png)|

---

## Add device
1. device blade

[<img src="https://i.imgur.com/ihoYyLc.png">](https://i.imgur.com/ihoYyLc.png)

2. properties
    1. IP adress
    2. SN: 
    3. Device name: 
    4. Device model: 
    5. Firmware: 
    6. Desc:

[<img src="https://i.imgur.com/wKMR3bw.png">](https://i.imgur.com/wKMR3bw.png)


3. device\fortigate

[<img src="https://i.imgur.com/mUrbHuQ.png">](https://i.imgur.com/mUrbHuQ.png)

4. fortigate\log & report\log setting
    1. Enabled send logs to FortiAnalyzer/FortiManager

[<img src="https://i.imgur.com/2ddiiGS.png">](https://i.imgur.com/2ddiiGS.png)

* test connectivity : 

[<img src="https://i.imgur.com/oxM6Nwi.png">](https://i.imgur.com/oxM6Nwi.png)

* apply (warning)
````txt
Could not find a valid serial number associated with your FortiAnalyzer certificate.

If you are using a non-Fortinet certificate or an old VM license, you will have to disable certificate
verification and add the FortiGate admin credentials to your FortiAnalyzer. For more information,
please refer to the documentation.
````

* Disabled: verify fortiAnalyzer cert

[<img src="https://i.imgur.com/D9dcd29.png">](https://i.imgur.com/D9dcd29.png)

5. logs\Real time

[<img src="https://i.imgur.com/mHUMnST.png">](https://i.imgur.com/mHUMnST.png)
