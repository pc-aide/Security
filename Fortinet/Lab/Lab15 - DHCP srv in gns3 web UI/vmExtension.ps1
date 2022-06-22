<#
  time: ~8 m 41s
#>

#################
#   VARIABLES   #
#################
$ErrorActionPreference = "stop"

# path
$pth_usrPrf = "C:\Users\Default"
$pth_AppData = "C:\Users\Default\AppData\Roaming"
$pth_OneDriveSetup = "C:\Windows\SysWOW64\OneDriveSetup.exe"
# taskBar
$pth_PinnedTaskBar = "C:\Users\Default\AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

# drivers
$pth_drivers = "$env:winDir\system32\drivers"
# shell:startUp
$pth_StartUp = ni "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\StartUp" -type directory

# empty30G_qcow2 (FG)
$URL_empty30G_qcow2  = "https://cfhcable.dl.sourceforge.net/project/gns-3/Empty%20Qemu%20disk/empty30G.qcow2"
# SW_iosv_2020.qcow2
$URL_sw_iosv_2020_qcow2 = "https://master.dl.sourceforge.net/project/images/SW_iosv_2020.qcow2?viasf=1"
# FGT6.4.7.qcow2
$URL_FGT6_4_7_qcow2 = "https://master.dl.sourceforge.net/project/images/FGT6.4.7.qcow2?viasf=1"
# rt_159-3.m4.qcow
$URL_vios_159_3_m4_qcow2 = "https://master.dl.sourceforge.net/project/images/qcow2/vios_159-3.m4.qcow2?viasf=1"
# iosV_startup_config.img (router)
$URL_iosv_startup_cfg_img = "https://master.dl.sourceforge.net/project/images/qcow2/iosv_startup_config.img?viasf=1"

# Packet dll_x64
$URL_packet_x64 = "https://master.dl.sourceforge.net/project/images/System32/Packet.dll?viasf=1"
# wpcap ddl_x32
$URL_wpcap_x32 = "https://master.dl.sourceforge.net/project/images/SysWOW64/wpcap.dll?viasf=1"
# pthreadVC.dll
$URL_pthreadVC_x32 = "https://master.dl.sourceforge.net/project/images/SysWOW64/pthreadVC.dll?viasf=1"
# Packet ddl_x32
$URL_packet_x32 = "https://master.dl.sourceforge.net/project/images/SysWOW64/Packet.dll?viasf=1"
# npf.sys
$URL_npf_sys = "https://master.dl.sourceforge.net/project/images/drivers/npf.sys?viasf=1"
# rpcapd.exe in InstallDir\WinPcap
$URL_rpcapd_exe = "https://altushost-swe.dl.sourceforge.net/project/images/ProgramFilesX86/rpcapd.exe"

# winPcap (tmp - bypass checkUp from gns3.exe)
$URL_winPcap_msi = "http://www.win10pcap.org/download/Win10Pcap-v10.2-5002.msi"

################
#   LOOPBACK   #
################

# loopback
$loopbackName = "Loopback"
# loopback nic
$primary_interface = "Ethernet"

# Pckg Nuget
# Find-PackageProvider -Name "NuGet" -AllVersions
Install-PackageProvider -Name "NuGet" -RequiredVersion " 2.8.5.208" -Force
# Modules
try{
  Install-Module -Name LoopbackAdapter -MinimumVersion 1.2.0.0 -Force
  # New NIC
  New-LoopbackAdapter -Name $loopbackName -Force

  # NIC_loopback
  $interface_loopback = Get-NetAdapter -Name $loopbackName
  $interface_main = Get-NetAdapter -Name $primary_interface

  # IP
  $loopback_ipv4 = '192.168.3.10'
  # Subnet mask
  $loopback_ipv4_length = '24'

  # Set the IPv4 address
  New-NetIPAddress -InterfaceAlias $loopbackName -IPAddress $loopback_ipv4 `
    -PrefixLength $loopback_ipv4_length -AddressFamily ipv4
  
}catch{
  $Error[0] | out-file d:\ErrorInstallModuleLoopback.txt
}

################
# FIlES in D:\ #
################

$fortnetRed_svg = @"
<?xml version="1.0" standalone="no"?>
        <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
        "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"> <svg style="color: red" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>Fortinet</title><path d="M0 9.785h6.788v4.454H0zm8.666-6.33h6.668v4.453H8.666zm0 12.637h6.668v4.454H8.666zm8.522-6.307H24v4.454h-6.812zM2.792 3.455C1.372 3.814.265 5.404 0 7.425v.506h6.788V3.454zM0 16.091v.554c.24 1.926 1.276 3.466 2.624 3.9h4.188v-4.454zm24-8.184v-.506c-.265-1.998-1.372-3.587-2.792-3.972h-4.02v4.454H24zM21.376 20.57c1.324-.458 2.36-1.974 2.624-3.9v-.554h-6.812v4.454Z" fill="red"></path></svg> 
"@

# fortnet Red icon
$fortnetRed_svg | 
  out-file d:\fortnetRed.svg -Encoding ascii

# qemu
try {
  Start-BitsTransfer $URL_sw_iosv_2020_qcow2 `
   -Destination "d:\SW_iosv_2020.qcow2"
  Start-BitsTransfer $URL_FGT6_4_7_qcow2 `
    -Destination "d:\FGT6.4.7.qcow2"
  Start-BitsTransfer $URL_vios_159_3_m4_qcow2 `
    -Destination "d:\vios_159-3.m4.qcow2"
  Start-BitsTransfer $URL_iosv_startup_cfg_img `
    -Destination "d:\iosv_startup_config.img"
  Start-BitsTransfer $URL_empty30G_qcow2 `
    -Destination d:\empty30G.qcow2
}
catch {
  $Error[0] | d:\ErrorDownloadFiles_Qcow2.log
}

# gns3 Web UI desktop url
$new_object = New-Object -ComObject WScript.Shell
$destination = $new_object.SpecialFolders.Item("AllUsersDesktop")
$source_path = Join-Path -Path $destination -ChildPath "gns3 Web UI.url"
$source = $new_object.CreateShortcut($source_path)
$source.TargetPath = "http://gns3:3080"
$source.Save()

################
#  CUSTOM OS   #
################

# acl.default (Access to the path is denied) ACL: read,execute
$acl = get-acl $pth_OneDriveSetup
# new rule
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("nt authority\system","FullControl","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl $pth_OneDriveSetup

# Block autoInstall OneDrive to a NewUser
try{
  ri $pth_OneDriveSetup -force  
}catch{
  $erro[0] | out-file "d:\ErrorRemoveOneDriveSetup.log"
}

# Turn off the Network Location wizard
ni HKLM:\System\CurrentControlSet\Control\Network\ -Name NewNetworkWindowOff

# Disable Privacy Settings Experience Using 
ni HKLM:\SOFTWARE\Policies\Microsoft\Windows\ -Name OOBE
New-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\OOBE `
  -Name DisablePrivacyExperience -Type DWord -Value 1
  
# Disable First run welcome page Edge
ni HKLM:\SOFTWARE\Policies\Microsoft\ -Name Edge
New-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Edge\ `
  -Name HideFirstRunExperience -Type DWord -Value 1
  
# Remove icons pinned to TaskBar
# try this in futur : Import-StartLayout -MountPath $env:systemdrive\ -LayoutPath "StartLayout.bin"
#ri "C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\*" -EA 0

# InstallDir WinPcap
try{
  $pth_winPcap = ni ${env:ProgramFiles(x86)} -Name WinPcap -Type Directory
}catch{
  $Error[0] | out-file d:\ErroInstallDirWinPcap.log
}

# npf.sys x64
try{
  Start-BitsTransfer $URL_npf_sys `
   -Destination "$pth_drivers\npf.sys"
}catch{
  $Error[0] | out-file d:\ErrorNpf_drivers_x64.log
}
# wpcap.dll x32
try{
  Start-BitsTransfer $URL_wpcap_x32 `
  -Destination "d:\wpcap.dll"
  move-item "d:\wpcap.dll" "C:\Windows\SysWOW64\wpcap.dll"
}catch{
  $Error[0] | out-file d:\ErrorWpcap_ddl_x32.log
}
# packet.dll x64
try {
  Start-BitsTransfer $URL_packet_x64 `
  -Destination "$env:winDir\system32\packet.dll"
}
catch {
  $Error[0] | out-file d:\ErrorPacket_ddl_x64.log
}
# packet.dll x32
try{
  Start-BitsTransfer -Source $URL_packet_x32 `
   -Destination "$env:winDir\SysWOW64\Packet.dll"
}catch{
  $Error[0] | out-file d:\ErrorPacket_ddl_x32.log
}
# rpcapd.exe
try{
  Start-BitsTransfer -Source $URL_rpcapd_exe `
   -Destination "$pth_winPcap\rpcapd.exe"
}catch{
  $Error[0] | out-file d:\ErrorRpcapd_exe_InstallDirWinPcap.log
} 

# app & 1st service
sc.exe create rpcapd type= own start= demand binPath= "$pth_winPcap\rpcad.exe" DisplayName= "Remote Package Capture Protocol..."
# driver (*.sys - 2e service)
sc.exe create npf binPath= "system32\drivers\npf.sys" type= kernel start= auto error= normal tag= no DisplayName= "NetGroup Packet Filter Driver"
# start-service
try{
  sc.exe start npf  
}catch{
  $Error[0] | out-file d:\Error2StartServiceNpf_sys.log
}

# Mount SMB
$user = ""
$Username = "localhost\$user"
$pwd = ""
$password = ConvertTo-SecureString -String $pwd -AsPlainText -Force
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username,$password
try {
  New-SmbGlobalMapping -LocalPath Z: -RemotePath "\\$user.file.core.windows.net\$user" -Credential $Cred  
}
catch {
  $Error[0] | out-file d:\ErrorMountSMB.log
}
