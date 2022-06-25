<#
  time: ~15 minutes 41 seconds
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

# ddl-gns3 (93.3M)
$URL_gns3 = "https://github.com/GNS3/gns3-gui/releases/download/v2.2.33.1/GNS3-2.2.33.1-all-in-one.exe"

# Solar-Putty.exe
$URL_solarPutty = "https://master.dl.sourceforge.net/project/images/ProgramFiles_GNS3/Solar-PuTTY.exe?viasf=1"

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

# winXP+IE6.vmdk
$URL_winXP_IE6_vmdk = "https://master.dl.sourceforge.net/project/images/vmdk/IE6%20-%20WinXP-disk1.vmdk?viasf=1"

# fortinet.svg
$URL_fortinet_svg = "https://master.dl.sourceforge.net/project/images/fortinet.svg?viasf=1"
# firefox.svg
$URL_firefox_svg = "https://master.dl.sourceforge.net/project/images/firefox.svg?viasf=1"

# gns3_server.ini (appData)
$URL_gns3_server_ini = "https://master.dl.sourceforge.net/project/images/gns3_server.ini?viasf=1"

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

# NTUSER.DAT
$URL_ntuser = "https://master.dl.sourceforge.net/project/images/NTUSER.DAT/NTUSER.DAT?viasf=1"

# tightVnc2.8.63 - because native client crash always for the WebTerm
$URL_tightVnc = "https://www.tightvnc.com/download/2.8.63/tightvnc-2.8.63-gpl-setup-64bit.msi"

################
# FIlES in D:\ #
################

# winXP_logo_svg
$fil_xp_win_svg = @"
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->


<!-- SVG fragment cleaned by CleanSVG on 2012-09-25 12:29:31 AM -->
<svg xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="173.226" height="152.966" viewBox="0 0 173.226 152.966" id="svg3487" xml:space="preserve" style="overflow:visible">
<g transform="translate(9.1344686e-4,6.3657472e-4)">
<path d="M39.674,133.092" style="fill:none" />
<path d="m170.407,21.106c-32.996,13.644 -48.867,5.999 -63.164,-3.624 0.033,-0.126 0.092,-0.37 -0.004,-0.604 14.297,9.625
 30.486,17.371 63.48,3.729 -0.219,0.201 -0.219,0.301 -0.312,0.499z" style="fill:#83b641" />
<polygon points="88.545,74.152 104.723,18.161 105.901,17.319 89.786,73.298 88.544,74.281 " style="fill:#8aa742;fill-rule:evenodd"
 />
<linearGradient x1="99.227" y1="45.67" x2="97.723" y2="45.239" id="XMLID_39_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#8aa742;stop-opacity:1" offset="0" />
<stop style="stop-color:#8aa742;stop-opacity:1" offset="0.1" />
<stop style="stop-color:#b7ca33;stop-opacity:1" offset="0.25" />
<stop style="stop-color:#b7ca33;stop-opacity:1" offset="0.405" />
<stop style="stop-color:#8aa742;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m91,73.923c-0.502,-0.281 -0.864,-0.847 -1.31,-0.672l16.155,-55.907c0.248,-0.111 0.873,-0.325 1.463,0.14L91,73.923z"
 style="fill:url(#XMLID_39_)" />
<path d="m106.053,16.956 -0.166,0.4 -1.178,0.851c0.1,-0.382 0.998,-1.019 1.275,-1.212 0.052,-0.036 0.069,-0.039
 0.069,-0.039z" style="fill:#8aa742;fill-rule:evenodd" />
<linearGradient x1="107.31" y1="17.111" x2="105.865" y2="17.01" id="XMLID_40_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#83b641;stop-opacity:1" offset="0" />
<stop style="stop-color:#b7ca33;stop-opacity:1" offset="0.2" />
<stop style="stop-color:#b7ca33;stop-opacity:1" offset="0.525" />
<stop style="stop-color:#8aa742;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m107.252,17.444c-0.611,-0.377 -1.162,-0.194 -1.412,-0.086 0.039,-0.119 0.145,-0.363 0.145,-0.363 0.531,-0.336
 0.762,-0.352 1.258,-0.115 0.064,0.185 0.091,0.363 0.009,0.564z" style="fill:url(#XMLID_40_)" />
<linearGradient x1="170.769" y1="20.577" x2="171.415" y2="21.652" id="XMLID_41_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#83b641;stop-opacity:1" offset="0" />
<stop style="stop-color:#595e48;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m171.631,21.522c0,0 -0.369,-0.509 -1.252,-0.346 0.078,-0.209 0.078,-0.405 0.34,-0.57 0.531,-0.08 0.789,0.06
 0.902,0.169 0.063,0.062 0.082,0.113 0.082,0.113 0.071,0.312 -0.072,0.634 -0.072,0.634z" style="fill:url(#XMLID_41_);fill-rule:evenodd"
 />
<linearGradient x1="172.434" y1="21.409" x2="172.026" y2="21.895" id="XMLID_42_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#8aa742;stop-opacity:1" offset="0" />
<stop style="stop-color:#595e48;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m171.622,20.775 1.305,1.047c0.078,0.35 -0.09,0.705 -0.09,0.705l-1.309,-1.051c0,0 0.164,-0.39 0.094,-0.701z"
 style="fill:url(#XMLID_42_);fill-rule:evenodd" />
<polygon points="171.555,21.402 172.887,22.461 156.481,78.712 155.243,77.619 " style="fill:#595e48;fill-rule:evenodd" />
<path d="m156.801,79.119c0.035,-0.321 -0.307,-0.586 -0.307,-0.586L172.87,22.41c0,0 0.26,0.234 0.33,0.403l-16.399,56.306z"
 style="fill:#767e47;fill-rule:evenodd" />
<linearGradient x1="173.042" y1="21.805" x2="173.042" y2="22.834" id="XMLID_43_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#8aa742;stop-opacity:1" offset="0" />
<stop style="stop-color:#767e47;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m 173.196,22.834 c 0,0 -0.059,-0.161 -0.338,-0.396 0.127,-0.528 0.043,-0.634 0.043,-0.634 l 0.025,0.017
 c 0,10e-4 0.41,0.374 0.27,1.013 z" style="fill:url(#XMLID_43_);fill-rule:evenodd" />
<path d="m156.254,79.643c-8.818,4.004 -17.164,6.07 -24.914,6.746 -13.383,1.52 -24.205,-1.391 -33.047,-5.734 -3.438,-1.578
 -6.551,-3.364 -9.305,-5.219l0.149,-0.129c2.792,1.879 5.835,3.715 9.155,5.348 8.984,4.125 20.195,6.848 33.047,5.734
 7.32,-0.828 15.406,-2.988 24.355,-6.957 0.252,0.203 0.56,0.211 0.56,0.211z" style="fill:#595e48;fill-rule:evenodd"
 />
<linearGradient x1="155.32" y1="77.938" x2="153.91" y2="77.839" id="XMLID_44_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#767e47;stop-opacity:1" offset="0" />
<stop style="stop-color:#8aa742;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m154.473,78.599c0,0 -0.631,-0.566 -0.516,-1.395 0.848,-0.217 1.391,0.32 1.391,0.32 0,0 -0.156,0.763 -0.875,1.075z"
 style="fill:url(#XMLID_44_)" />
<linearGradient x1="155.982" y1="78.063" x2="155.071" y2="79.075" id="XMLID_45_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#767e47;stop-opacity:1" offset="0" />
<stop style="stop-color:#595e48;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m155.348,77.525 1.186,1.035c0,0 -0.182,0.649 -0.902,0.965l-1.205,-1.032c0.722,-0.316 0.921,-0.968 0.921,-0.968z"
 style="fill:url(#XMLID_45_);fill-rule:evenodd" />
<linearGradient x1="90.361" y1="79.839" x2="154.649" y2="79.839" id="XMLID_46_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#8aa742;stop-opacity:1" offset="0" />
<stop style="stop-color:#b7ca33;stop-opacity:1" offset="0.4" />
<stop style="stop-color:#8aa742;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m154.153,77.187c-0.115,0.83 0.496,1.436 0.496,1.436 -33.002,13.645 -50.004,5.61 -64.288,-4.066 0.251,-0.184
 0.29,-0.182 0.453,-0.764 14.282,9.678 35.87,16.459 63.339,3.394z" style="fill:url(#XMLID_46_)" />
<path d="m89.144,75.365 1.227,-0.82c14.29,9.2 31.169,17.157 64.136,3.91l1.193,1.036c-31.653,13.964 -51.903,6.187
 -66.556,-4.126z" style="fill:#767e47;fill-rule:evenodd" />
<path d="m156.801,79.119c-0.164,0.301 -0.451,0.473 -0.547,0.523 -0.02,0.012 -0.033,0.012 -0.033,0.012 0,0 -0.225,0.031
 -0.525,-0.164 0.645,-0.352 0.832,-1.055 0.832,-1.055 0,0 0.375,0.313 0.273,0.684z" style="fill:#767e47;fill-rule:evenodd"
 />
<path d="m89.189,75.349 -0.147,0.121c0,0 -0.804,-0.434 -0.496,-1.318 0.072,0.869 0.643,1.197 0.643,1.197z" style="fill:#767e47;fill-rule:evenodd"
 />
<linearGradient x1="89.969" y1="74.917" x2="88.951" y2="73.786" id="XMLID_47_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#767e47;stop-opacity:1" offset="0" />
<stop style="stop-color:#767e47;stop-opacity:1" offset="0.1" />
<stop style="stop-color:#83b641;stop-opacity:1" offset="0.65" />
<stop style="stop-color:#8aa742;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m88.545,74.152 1.184,-0.936c-0.069,0.902 0.711,1.277 0.711,1.277l-1.204,0.926c0,0 -0.759,-0.363 -0.691,-1.267z"
 style="fill:url(#XMLID_47_)" />
<linearGradient x1="89.936" y1="73.087" x2="90.676" y2="74.424" id="XMLID_48_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#8aa742;stop-opacity:1" offset="0" />
<stop style="stop-color:#83b641;stop-opacity:1" offset="0.405" />
<stop style="stop-color:#8aa742;stop-opacity:1" offset="0.8" />
<stop style="stop-color:#8aa742;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m89.703,73.216c0.405,-0.123 0.771,0.297 1.267,0.682 -0.161,0.584 -0.303,0.484 -0.554,0.67 -0.294,-0.176
 -0.788,-0.61 -0.713,-1.352z" style="fill:url(#XMLID_48_)" />
<linearGradient x1="163.585" y1="49.529" x2="162.087" y2="49.1" id="XMLID_49_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#595e48;stop-opacity:1" offset="0" />
<stop style="stop-color:#83b641;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m 153.997,77.314 16.332,-56.189 c 0.883,-0.163 1.305,0.337 1.305,0.337 l -16.285,56.063 c -10e-4,0 -0.653,-0.5
 -1.352,-0.211 z" style="fill:url(#XMLID_49_)" />
<defs>
<path d="m107.254,17.442c14.297,9.621 30.156,17.29 63.152,3.648L154.15,77.255c-27.541,12.922 -49.002,6.278 -63.283,-3.398l16.387,-56.415z"
 id="XMLID_12_" />
</defs>
<clipPath>
<use x="0" y="0" width="812.044" height="152.966" xlink:href="#XMLID_12_" />
</clipPath>
<linearGradient x1="159.869" y1="57.84" x2="100.46" y2="40.804" id="XMLID_51_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#6fbc48;stop-opacity:1" offset="0" />
<stop style="stop-color:#98c74f;stop-opacity:1" offset="0.333" />
<stop style="stop-color:#80c046;stop-opacity:1" offset="0.667" />
<stop style="stop-color:#607d3a;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m170.407,21.09c-32.996,13.642 -48.861,5.973 -63.16,-3.65L90.969,73.902c14.285,9.678 31.531,17.635 63.188,3.463l16.25,-56.275z"
 style="fill:url(#XMLID_51_)" />
<path d="m1.36,132.346c0.108,0.016 0.307,-0.078 0.307,-0.078 0.229,0.156 0.411,0.266 0.411,0.266 0,0 -0.358,0.085
 -0.718,-0.188z" style="fill:#313c7e;fill-rule:evenodd" />
<path d="m62.57,135.236c0,0 0.219,0.203 0.471,0.133l-0.989,0.586c-0.316,0.141 -0.641,-0.082 -0.641,-0.082l1.159,-0.637z"
 style="fill:#313c7e" />
<path d="m1.68,132.275c0,0 -0.193,0.098 -0.302,0.082l-1.085,-0.828 -0.025,-0.023c0.157,0.055 0.338,0.027 0.411,0.012l1.001,0.757z"
 style="fill:#313c7e" />
<path d="m63.125,134.428c0.113,0.082 0.232,0.172 0.344,0.398 -0.063,0.297 -0.311,0.449 -0.451,0.559 -0.202,0.047
 -0.485,-0.145 -0.485,-0.145 0.158,-0.133 0.428,-0.324 0.592,-0.812z" style="fill:#2e499e" />
<rect width="0.324" height="0.018" x="16.084" y="74.603" style="fill:#2e499e;fill-rule:evenodd" />
<polygon points="16.267,74.611 0.207,130.799 0.023,130.752 16.086,74.56 " style="fill:#2e499e;fill-rule:evenodd" />
<path d="m0.293,131.529c-0.208,-0.18 -0.352,-0.488 -0.271,-0.777l0.193,-0.074c-0.081,0.418 0.226,0.719 0.45,0.848
 0.002,-0.001 -0.162,0.081 -0.372,0.003z" style="fill:#2e499e;fill-rule:evenodd" />
<linearGradient x1="0.187" y1="129.191" x2="63.144" y2="129.191" id="XMLID_52_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#76a5d8;stop-opacity:1" offset="0" />
<stop style="stop-color:#dae3ec;stop-opacity:1" offset="0.45" />
<stop style="stop-color:#3f87c7;stop-opacity:1" offset="1" />
</linearGradient>
<path d="M62.56,135.275C48.228,125.63 33.375,118.263 0.686,131.545 0.461,131.412 0.119,131.092 0.199,130.67c33.192,-14.129
 48.613,-5.875 62.945,3.773 -0.146,0.512 -0.426,0.703 -0.584,0.832z" style="fill:url(#XMLID_52_)" />
<path d="m 1.615,132.232 c 31.464,-12.301 45.567,-5.602 59.892,3.621 -8.58,-5.523 -17.41,-9.945 -29.594,-10.02
 -8.154,-0.047 -17.791,2.023 -29.851,6.699 0,10e-4 -0.249,-0.093 -0.447,-0.3 z" style="fill:#313c7e;fill-rule:evenodd"
 />
<path d="m62.577,135.271 -1.159,0.605C47.093,126.653 32.595,120.278 1.681,132.274l-1.022,-0.746c32.689,-13.284
 47.587,-5.905 61.918,3.743z" style="fill:#2e499e;fill-rule:evenodd" />
<path d="M63.115,134.459 79.642,77.892c0.177,0.123 0.271,0.219 0.363,0.324l-16.542,56.637c-0.093,-0.238 -0.348,-0.394
 -0.348,-0.394z" style="fill:#313c7e;fill-rule:evenodd" />
<path d="M79.635,77.919C65.317,68.215 49.168,61.191 16.232,74.634 16.314,74.353 16.381,74.22 16.381,74.22 49.462,60.542
 65.437,67.804 79.754,77.509l-0.119,0.41z" style="fill:#3f87c7;fill-rule:evenodd" />
<defs>
<path d="M63.135,134.475C48.804,124.827 33.267,117.01 0.193,130.682L16.238,74.603c33.079,-13.68 49.107,-6.4 63.426,3.303l-16.529,56.569z"
 id="XMLID_16_" />
</defs>
<clipPath id="XMLID_53_">
<use x="0" y="0" width="812.044" height="152.966" xlink:href="#XMLID_16_" />
</clipPath>
<g clip-path="url(#XMLID_53_)">
<linearGradient x1="70.161" y1="110.956" x2="10.682" y2="93.901" id="XMLID_54_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#2e499e;stop-opacity:1" offset="0" />
<stop style="stop-color:#4496d1;stop-opacity:1" offset="0.4" />
<stop style="stop-color:#a5cded;stop-opacity:1" offset="0.725" />
<stop style="stop-color:#007fc4;stop-opacity:1" offset="1" />
</linearGradient>
<path d="M63.141,134.596C48.81,124.951 33.231,117.018 0.157,130.694L16.352,74.127c33.081,-13.678 48.973,-5.938
 63.29,3.766l-16.501,56.703z" style="fill:url(#XMLID_54_)" />
<path d="M63.141,134.596C48.81,124.951 33.231,117.018 0.157,130.694L16.352,74.127c33.081,-13.678 48.973,-5.938
 63.29,3.766l-16.501,56.703z" style="fill:none" />
</g>
<path d="m79.749,77.505 0.027,0.016c0.204,0.145 0.287,0.426 0.229,0.695l-0.012,0.035c-0.091,-0.104 -0.186,-0.203
 -0.362,-0.326l0.118,-0.42z" style="fill:#313c7e;fill-rule:evenodd" />
<linearGradient x1="16.247" y1="74.212" x2="16.247" y2="74.621" id="XMLID_55_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#76a5d8;stop-opacity:1" offset="0" />
<stop style="stop-color:#2e499e;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m 16.265,74.621 -0.181,-0.053 c 0.069,-0.238 0.232,-0.32 0.297,-0.348 l 0.027,-0.008 c 10e-4,0 -0.06,0.125
 -0.143,0.409 z" style="fill:url(#XMLID_55_);fill-rule:evenodd" />
<path d="M81.828,68.497C66.43,57.811 47.556,51.1 19.527,65.029l1.146,0.809C51.3,53.321 67.278,60.096 80.714,68.946l1.114,-0.449z"
 style="fill:#d75329;fill-rule:evenodd" />
<path d="m82.368,67.668 16.27,-56.174c0.176,0.12 0.262,0.236 0.355,0.34L82.716,68.056C82.623,67.82 82.368,67.668
 82.368,67.668z" style="fill:#ab4533;fill-rule:evenodd" />
<path d="m20.683,65.82c5.212,-2.138 10.039,-3.725 14.518,-4.814 1.086,-0.263 2.051,-0.501 3.197,-0.722 1.055,-0.21
 2.097,-0.415 3.116,-0.565 1.597,-0.244 3.146,-0.445 4.654,-0.561 1.29,-0.102 2.545,-0.177 3.774,-0.188 1.188,-0.014
 2.349,0.002 3.483,0.067 1.01,0.058 1.998,0.131 2.971,0.246 0.822,0.096 1.626,0.197 2.421,0.334 1.679,0.288 3.301,0.642
 4.869,1.087 6.332,1.791 11.956,4.844 17.127,8.292 -0.034,0.016 -0.158,-0.036 -0.212,-0.065 -0.05,-0.024 -0.073,-0.026
 -0.117,-0.056 -6.991,-4.432 -14.502,-8.286 -23.77,-9.423 -9.486,-1.166 -20.54,0.467 -35.433,6.378 0,0 -0.347,0.147
 -0.479,0.171 -0.119,0.019 -0.097,-0.072 -0.119,-0.181z" style="fill:#ab4533;fill-rule:evenodd" />
<path d="m81.802,68.487c0,0 0.221,0.155 0.471,0.098l-1.027,0.453c-0.277,0.081 -0.606,-0.09 -0.606,-0.09l1.162,-0.461z"
 style="fill:#ab4533" />
<path d="m20.697,65.83c0,0 0.063,0.105 0.105,0.173 -0.101,0.014 -0.113,0.04 -0.362,-0.071 -0.033,-0.013 -0.083,-0.054
 -0.124,-0.072l-1.063,-0.836 -0.096,-0.079c0.145,-0.01 0.256,0.06 0.329,0.046l1.211,0.839z" style="fill:#ab4533"
 />
<path d="m82.379,67.67c0.114,0.076 0.25,0.121 0.345,0.357 -0.063,0.299 -0.317,0.449 -0.459,0.559 -0.252,0.071 -0.501,-0.123
 -0.501,-0.123 0.159,-0.127 0.451,-0.307 0.615,-0.793z" style="fill:#d75329" />
<path d="m98.747,11.129 0.02,0.012c0.201,0.144 0.285,0.426 0.227,0.693l-0.01,0.036C98.89,11.765 98.83,11.661 98.646,11.522l0.101,-0.393z"
 style="fill:#d75329;fill-rule:evenodd" />
<path d="M 19.179,64.975 C 19.025,64.854 18.87,64.381 18.95,64.093 l 0.216,-0.075 c -0.08,0.417 0.178,0.892 0.402,1.021
 10e-4,0 -0.157,0.089 -0.389,-0.064 z" style="fill:#d75329;fill-rule:evenodd" />
<defs>
<path d="M 35.432,7.781 35.25,7.729 c 0.07,-0.238 0.234,-0.323 0.298,-0.35 l 0.027,-0.008 c 10e-4,10e-4 -0.06,0.126
 -0.143,0.41 z" id="XMLID_20_" />
</defs>
<clipPath id="XMLID_56_">
<use x="0" y="0" width="812.044" height="152.966" xlink:href="#XMLID_20_" />
</clipPath>
<rect width="0.325" height="0.024" x="35.25" y="7.372" clip-path="url(#XMLID_56_)" style="fill:#faaa4f;fill-rule:evenodd" />
<rect width="0.325" height="0.027" x="35.25" y="7.396" clip-path="url(#XMLID_56_)" style="fill:#f6a34c;fill-rule:evenodd" />
<rect width="0.325" height="0.024" x="35.25" y="7.423" clip-path="url(#XMLID_56_)" style="fill:#f39d48;fill-rule:evenodd" />
<rect width="0.325" height="0.027" x="35.25" y="7.448" clip-path="url(#XMLID_56_)" style="fill:#f09745;fill-rule:evenodd" />
<rect width="0.325" height="0.025" x="35.25" y="7.475" clip-path="url(#XMLID_56_)" style="fill:#ed9142;fill-rule:evenodd" />
<rect width="0.325" height="0.024" x="35.25" y="7.5" clip-path="url(#XMLID_56_)" style="fill:#eb8c3f;fill-rule:evenodd" />
<rect width="0.325" height="0.025" x="35.25" y="7.525" clip-path="url(#XMLID_56_)" style="fill:#e8863c;fill-rule:evenodd" />
<rect width="0.325" height="0.024" x="35.25" y="7.55" clip-path="url(#XMLID_56_)" style="fill:#e68139;fill-rule:evenodd" />
<rect width="0.325" height="0.025" x="35.25" y="7.575" clip-path="url(#XMLID_56_)" style="fill:#e57b37;fill-rule:evenodd" />
<rect width="0.325" height="0.025" x="35.25" y="7.6" clip-path="url(#XMLID_56_)" style="fill:#e27634;fill-rule:evenodd" />
<rect width="0.325" height="0.026" x="35.25" y="7.625" clip-path="url(#XMLID_56_)" style="fill:#e07132;fill-rule:evenodd" />
<rect width="0.325" height="0.025" x="35.25" y="7.652" clip-path="url(#XMLID_56_)" style="fill:#df6b30;fill-rule:evenodd" />
<rect width="0.325" height="0.024" x="35.25" y="7.677" clip-path="url(#XMLID_56_)" style="fill:#dc662e;fill-rule:evenodd" />
<rect width="0.325" height="0.027" x="35.25" y="7.702" clip-path="url(#XMLID_56_)" style="fill:#db602c;fill-rule:evenodd" />
<rect width="0.325" height="0.024" x="35.25" y="7.729" clip-path="url(#XMLID_56_)" style="fill:#d95a2a;fill-rule:evenodd" />
<rect width="0.325" height="0.027" x="35.25" y="7.753" clip-path="url(#XMLID_56_)" style="fill:#d75329;fill-rule:evenodd" />
<linearGradient x1="19.111" y1="62.354" x2="82.387" y2="62.354" id="XMLID_57_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#faab4f;stop-opacity:1" offset="0" />
<stop style="stop-color:#faab4f;stop-opacity:1" offset="0.25" />
<stop style="stop-color:#fcc193;stop-opacity:1" offset="0.475" />
<stop style="stop-color:#fcc193;stop-opacity:1" offset="0.525" />
<stop style="stop-color:#f89c3e;stop-opacity:1" offset="0.75" />
<stop style="stop-color:#f89c3e;stop-opacity:1" offset="1" />
</linearGradient>
<path d="M81.798,68.491C72.984,62.729 64.733,57.959 51.668,57.583 42.114,57.772 34.79,58.989 19.555,65.04c-0.225,-0.128
 -0.51,-0.447 -0.431,-0.866 13.191,-5.617 23.663,-8.04 32.354,-7.955 13.16,0.131 22.283,5.637 30.909,11.44 -0.146,0.508
 -0.43,0.703 -0.589,0.832z" style="fill:url(#XMLID_57_)" />
<path d="m35.255,7.719 0.151,0.048 -16.245,56.388c-0.037,-0.016 -0.21,-0.062 -0.21,-0.062L35.255,7.719z" style="fill:#d75329;fill-rule:evenodd"
 />
<path d="M98.641,11.559C84.333,1.864 68.303,-5.622 35.39,7.811 35.474,7.529 35.548,7.379 35.548,7.379 68.607,-6.288
 84.455,1.442 98.766,11.141l-0.125,0.418z" style="fill:#f89c3e;fill-rule:evenodd" />
<linearGradient x1="89.187" y1="44.529" x2="29.654" y2="27.458" id="XMLID_58_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#cd2b2b;stop-opacity:1" offset="0" />
<stop style="stop-color:#f2692a;stop-opacity:1" offset="0.4" />
<stop style="stop-color:#fcb544;stop-opacity:1" offset="0.725" />
<stop style="stop-color:#f37237;stop-opacity:1" offset="1" />
</linearGradient>
<path d="M82.392,67.68C73.764,61.87 64.485,56.447 51.307,56.347 42.612,56.28 32.262,58.75 19.123,64.183L35.406,7.761C68.465,-5.908
 84.344,1.828 98.651,11.525L82.392,67.68z" style="fill:url(#XMLID_58_)" />
<linearGradient x1="137.679" y1="144.478" x2="137.342" y2="145.736" id="XMLID_59_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="0" />
<stop style="stop-color:#a87c3c;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m137.993,145.178c-0.16,0.297 -0.449,0.473 -0.545,0.523 -0.021,0.012 -0.035,0.012 -0.035,0.012 0,0 -0.275,0.035
 -0.525,-0.164 0.645,-0.352 0.836,-1.059 0.836,-1.059 0,0 0.372,0.317 0.269,0.688z" style="fill:url(#XMLID_59_);fill-rule:evenodd"
 />
<path d="m137.993,145.178c0.039,-0.32 -0.305,-0.59 -0.305,-0.59l15.668,-54.613c0,0 0.262,0.23 0.334,0.402l-15.697,54.801z"
 style="fill:#d4a52e;fill-rule:evenodd" />
<linearGradient x1="153.529" y1="89.365" x2="153.529" y2="90.4" id="XMLID_60_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#c19236;stop-opacity:1" offset="0.006" />
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m153.68,90.4c0,0 -0.051,-0.156 -0.332,-0.391 0.129,-0.531 0.039,-0.645 0.039,-0.645l0.025,0.016c0.001,0.001
 0.413,0.38 0.268,1.02z" style="fill:url(#XMLID_60_);fill-rule:evenodd" />
<linearGradient x1="151.23" y1="88.142" x2="151.881" y2="89.226" id="XMLID_61_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#ffcd02;stop-opacity:1" offset="0.006" />
<stop style="stop-color:#a87c3c;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m152.118,89.084c0,0 -0.434,-0.527 -1.316,-0.363 0.047,-0.199 0.121,-0.441 0.402,-0.555 0.533,-0.082 0.789,0.059
 0.902,0.168 0.064,0.066 0.082,0.113 0.082,0.113 0.07,0.313 -0.07,0.637 -0.07,0.637z" style="fill:url(#XMLID_61_);fill-rule:evenodd"
 />
<linearGradient x1="152.927" y1="88.973" x2="152.528" y2="89.448" id="XMLID_62_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#ffcd02;stop-opacity:1" offset="0.006" />
<stop style="stop-color:#a87c3c;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m152.106,88.334 1.307,1.047c0.076,0.355 -0.064,0.707 -0.064,0.707l-1.301,-1.043c-0.001,0 0.128,-0.399
 0.058,-0.711z" style="fill:url(#XMLID_62_);fill-rule:evenodd" />
<polygon points="137.661,144.768 136.288,143.584 152.042,88.963 153.372,90.025 137.723,144.619 " style="fill:#a87c3c;fill-rule:evenodd"
 />
<linearGradient x1="136.367" y1="143.903" x2="134.954" y2="143.805" id="XMLID_63_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#c19236;stop-opacity:1" offset="0" />
<stop style="stop-color:#ffcd02;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m135.516,144.564c0,0 -0.629,-0.563 -0.516,-1.395 0.848,-0.215 1.395,0.32 1.395,0.32 0,0 -0.156,0.759 -0.879,1.075z"
 style="fill:url(#XMLID_63_)" />
<path d="m150.856,88.775c-33.176,11.301 -48.441,4.547 -62.754,-5.086 0.034,-0.129 0.122,-0.34 0.025,-0.578 14.313,9.633
 30.143,16.211 63.076,5.055 -0.249,0.172 -0.281,0.406 -0.347,0.609z" style="fill:#ffcd02" />
<polygon points="69.516,140.111 85.601,84.389 86.778,83.533 70.757,139.26 69.513,140.244 " style="fill:#d4a52e;fill-rule:evenodd"
 />
<linearGradient x1="80.171" y1="111.635" x2="78.693" y2="111.211" id="XMLID_64_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="0" />
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="0.1" />
<stop style="stop-color:#ffc222;stop-opacity:1" offset="0.2" />
<stop style="stop-color:#ffc222;stop-opacity:1" offset="0.35" />
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m72.12,139.525c-0.467,-0.277 -1.011,-0.488 -1.457,-0.309l16.063,-55.66c0.25,-0.105 0.844,-0.27 1.453,0.156L72.12,139.525z"
 style="fill:url(#XMLID_64_)" />
<linearGradient x1="144.299" y1="116.277" x2="142.898" y2="115.876" id="XMLID_65_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#a87c3c;stop-opacity:1" offset="0" />
<stop style="stop-color:#ffd200;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m135.04,143.283 15.758,-54.582c0.029,-0.008 0.068,-0.047 0.094,-0.051 0.838,-0.086 1.227,0.359 1.227,0.359l-15.715,54.496c-0.001,0.001
 -0.665,-0.515 -1.364,-0.222z" style="fill:url(#XMLID_65_)" />
<path d="m137.448,145.701c-32.396,13.848 -53.176,5.332 -67.489,-4.305l0.15,-0.125c14.313,9.633 36.339,17.656 66.778,4.219
 0.252,0.199 0.561,0.211 0.561,0.211z" style="fill:#a87c3c;fill-rule:evenodd" />
<linearGradient x1="136.955" y1="143.748" x2="136.251" y2="145.329" id="XMLID_66_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#c19236;stop-opacity:1" offset="0" />
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m136.393,143.498 1.334,1.121c0,0 -0.18,0.648 -0.902,0.965l-1.355,-1.125c0.722,-0.316 0.923,-0.961 0.923,-0.961z"
 style="fill:url(#XMLID_66_);fill-rule:evenodd" />
<linearGradient x1="71.437" y1="145.625" x2="135.694" y2="145.625" id="XMLID_67_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="0" />
<stop style="stop-color:#ffd200;stop-opacity:1" offset="0.4" />
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m135.196,143.154c-0.113,0.832 0.498,1.434 0.498,1.434 -33.037,13.664 -49.957,5.473 -64.257,-4.219 0.252,-0.184
 0.375,-0.344 0.536,-0.922 0.021,0.012 0.221,-0.02 0.241,-0.008 14.761,9.09 33.654,16.274 62.982,3.715z" style="fill:url(#XMLID_67_)"
 />
<path d="m70.115,141.326 1.322,-0.957c13.117,8.18 31.501,17.141 64.114,4.055l1.348,1.125c-30.313,13.426 -52.471,5.414
 -66.784,-4.223z" style="fill:#c19236;fill-rule:evenodd" />
<path d="m70.227,141.369 -0.15,0.105c0,0 -0.87,-0.48 -0.561,-1.363 0.071,0.871 0.711,1.258 0.711,1.258z" style="fill:#d4a52e;fill-rule:evenodd"
 />
<linearGradient x1="70.992" y1="140.863" x2="69.957" y2="139.714" id="XMLID_68_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="0" />
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="0.1" />
<stop style="stop-color:#ffd200;stop-opacity:1" offset="0.7" />
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m69.516,140.111 1.242,-1.016c-0.068,0.91 0.813,1.246 0.813,1.246l-1.364,1.043c0.001,0.001 -0.76,-0.366
 -0.691,-1.273z" style="fill:url(#XMLID_68_)" />
<linearGradient x1="71.022" y1="138.934" x2="71.755" y2="140.255" id="XMLID_69_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="0" />
<stop style="stop-color:#ffc222;stop-opacity:1" offset="0.4" />
<stop style="stop-color:#ffcd02;stop-opacity:1" offset="0.8" />
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m70.666,139.131c0.445,-0.18 0.862,0.031 1.331,0.305 -0.163,0.582 -0.261,0.785 -0.513,0.969 -0.294,-0.176
 -0.893,-0.536 -0.818,-1.274z" style="fill:url(#XMLID_69_)" />
<defs>
<path d="m88.131,83.682c14.313,9.633 29.822,16.309 62.76,4.969l-15.703,54.578c-28.98,12.742 -48.541,5.09 -63.201,-3.77L88.131,83.682z"
 id="XMLID_35_" />
</defs>
<clipPath id="XMLID_70_">
<use x="0" y="0" width="812.044" height="152.966" xlink:href="#XMLID_35_" />
</clipPath>
<linearGradient x1="140.966" y1="123.625" x2="81.423" y2="106.551" id="XMLID_71_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#ffc907;stop-opacity:1" offset="0" />
<stop style="stop-color:#ffd200;stop-opacity:1" offset="0.167" />
<stop style="stop-color:#ffd952;stop-opacity:1" offset="0.333" />
<stop style="stop-color:#ffcd02;stop-opacity:1" offset="0.625" />
<stop style="stop-color:#b77a36;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m88.226,83.334c14.313,9.637 30.212,17.313 63.243,3.66l-16.281,56.234c-33.037,13.664 -48.903,5.926 -63.201,-3.77L88.226,83.334z"
 clip-path="url(#XMLID_70_)" style="fill:url(#XMLID_71_)" />
<path d="m88.226,83.334c14.313,9.637 30.212,17.313 63.243,3.66l-16.281,56.234c-33.037,13.664 -48.903,5.926 -63.201,-3.77L88.226,83.334z"
 clip-path="url(#XMLID_70_)" style="fill:none" />
<path d="m86.933,83.182 -0.17,0.398 -1.178,0.852c0.076,-0.355 0.984,-1.012 1.264,-1.207 0.037,-0.028 0.084,-0.043
 0.084,-0.043z" style="fill:#ffcd02;fill-rule:evenodd" />
<linearGradient x1="88.188" y1="83.368" x2="86.717" y2="83.265" id="XMLID_72_" gradientUnits="userSpaceOnUse">
<stop style="stop-color:#ffc222;stop-opacity:1" offset="0" />
<stop style="stop-color:#ffc222;stop-opacity:1" offset="0.2" />
<stop style="stop-color:#ffd200;stop-opacity:1" offset="0.525" />
<stop style="stop-color:#d4a52e;stop-opacity:1" offset="1" />
</linearGradient>
<path d="m88.133,83.686c-0.657,-0.383 -1.193,-0.152 -1.443,-0.043 0.039,-0.121 0.174,-0.426 0.174,-0.426 0.532,-0.34
 0.774,-0.34 1.271,-0.102 0.096,0.235 0.033,0.422 -0.002,0.571z" style="fill:url(#XMLID_72_)" />
</g>
</svg>
"@

# gns3_controller.ini
$fil_gns3_controller = @"
{
  "computes": [
      {
          "host": "gns3",
          "name": "gns3",
          "port": 3080,
          "protocol": "http",
          "user": null,
          "password": null,
          "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426"
      }
  ],
  "templates": [
      {
          "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
          "name": "FG",
          "usage": "Default username is admin, no password is set.",
          "category": "firewall",
          "symbol": "fortinet.svg",
          "template_type": "qemu",
          "adapter_type": "e1000",
          "adapters": 10,
          "boot_priority": "c",
          "console_type": "telnet",
          "hda_disk_interface": "virtio",
          "hdb_disk_interface": "virtio",
          "ram": 1024,
          "options": "",
          "hda_disk_image": "FGT6.4.7.qcow2",
          "hdb_disk_image": "empty30G.qcow2",
          "qemu_path": "/usr/bin/qemu-system-x86_64",
          "port_name_format": "Port{port1}",
          "template_id": "ef90e3b5-4b61-42e3-8396-d807d5a684af",
          "builtin": false,
          "platform": "i386",
          "linked_clone": true,
          "cpus": 1,
          "mac_address": null,
          "first_port_name": "",
          "port_segment_size": 0,
          "console_auto_start": false,
          "hdc_disk_image": "",
          "hdc_disk_interface": "none",
          "hdd_disk_image": "",
          "hdd_disk_interface": "none",
          "cdrom_image": "",
          "initrd": "",
          "kernel_image": "",
          "bios_image": "",
          "kernel_command_line": "",
          "legacy_networking": false,
          "replicate_network_connection_state": true,
          "create_config_disk": false,
          "on_close": "power_off",
          "cpu_throttling": 0,
          "process_priority": "normal",
          "custom_adapters": [],
          "default_name_format": "{name}{0}"
      },
      {
          "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
          "name": "SW",
          "usage": "There is no default password and enable password. There is no default configuration present.",
          "category": "switch",
          "symbol": ":/symbols/classic/multilayer_switch.svg",
          "template_type": "qemu",
          "adapter_type": "e1000",
          "adapters": 16,
          "console_type": "telnet",
          "hda_disk_interface": "virtio",
          "ram": 768,
          "options": "",
          "hda_disk_image": "SW_iosv_2020.qcow2",
          "qemu_path": "/usr/bin/qemu-system-x86_64",
          "port_name_format": "Gi{1}/{0}",
          "port_segment_size": 4,
          "template_id": "97bac41e-e09c-490c-8c6f-f433369bd99e",
          "builtin": false,
          "platform": "i386",
          "linked_clone": true,
          "cpus": 1,
          "mac_address": null,
          "first_port_name": "",
          "console_auto_start": false,
          "boot_priority": "c",
          "hdb_disk_image": "",
          "hdb_disk_interface": "none",
          "hdc_disk_image": "",
          "hdc_disk_interface": "none",
          "hdd_disk_image": "",
          "hdd_disk_interface": "none",
          "cdrom_image": "",
          "initrd": "",
          "kernel_image": "",
          "bios_image": "",
          "kernel_command_line": "",
          "legacy_networking": false,
          "replicate_network_connection_state": true,
          "create_config_disk": false,
          "on_close": "power_off",
          "cpu_throttling": 0,
          "process_priority": "normal",
          "custom_adapters": [],
          "default_name_format": "{name}{0}"
      },
      {
          "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
          "name": "PC",
          "usage": "The /root directory is persistent.",
          "category": "guest",
          "symbol": "firefox.svg",
          "template_type": "docker",
          "adapters": 1,
          "console_type": "vnc",
          "image": "gns3/webterm:latest",
          "template_id": "43dd6253-13d7-48bb-8cf3-866a1c540f7c",
          "builtin": false,
          "start_command": "",
          "environment": "",
          "console_auto_start": false,
          "console_http_port": 80,
          "console_http_path": "/",
          "console_resolution": "1024x768",
          "extra_hosts": "",
          "extra_volumes": [],
          "custom_adapters": [],
          "default_name_format": "{name}{0}"
      },
      {
          "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
          "name": "RT",
          "usage": "There is no default password and enable password. There is no default configuration present.",
          "category": "router",
          "symbol": ":/symbols/classic/router.svg",
          "template_type": "qemu",
          "adapter_type": "e1000",
          "adapters": 4,
          "console_type": "telnet",
          "hda_disk_interface": "virtio",
          "hdb_disk_interface": "virtio",
          "ram": 512,
          "options": "",
          "hda_disk_image": "vios_159-3.m4.qcow2",
          "hdb_disk_image": "IOSv_startup_config.img",
          "qemu_path": "/usr/bin/qemu-system-x86_64",
          "port_name_format": "Gi0/{0}",
          "template_id": "608e4d23-f20a-426c-bb86-674cb3ffde91",
          "builtin": false,
          "platform": "i386",
          "linked_clone": true,
          "cpus": 1,
          "mac_address": null,
          "first_port_name": "",
          "port_segment_size": 0,
          "console_auto_start": false,
          "boot_priority": "c",
          "hdc_disk_image": "",
          "hdc_disk_interface": "none",
          "hdd_disk_image": "",
          "hdd_disk_interface": "none",
          "cdrom_image": "",
          "initrd": "",
          "kernel_image": "",
          "bios_image": "",
          "kernel_command_line": "",
          "legacy_networking": false,
          "replicate_network_connection_state": true,
          "create_config_disk": false,
          "on_close": "power_off",
          "cpu_throttling": 0,
          "process_priority": "normal",
          "custom_adapters": [],
          "default_name_format": "{name}{0}"
      },
      {
          "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
          "name": "WinXP",
          "category": "guest",
          "symbol": "xp_win.svg",
          "template_type": "qemu",
          "adapter_type": "pcnet",
          "adapters": 2,
          "console_type": "vnc",
          "options": "-nographic -usbdevice tablet -vga std -nodefaults",
          "ram": 512,
          "hda_disk_image": "WinXP-disk1.vmdk",
          "qemu_path": "/usr/bin/qemu-system-i386",
          "template_id": "b7cf6c6f-0f6d-4e2b-969d-c2aaea06e973",
          "builtin": false,
          "usage": "",
          "platform": "i386",
          "linked_clone": true,
          "cpus": 1,
          "mac_address": null,
          "first_port_name": "",
          "port_name_format": "Ethernet{0}",
          "port_segment_size": 0,
          "console_auto_start": false,
          "boot_priority": "c",
          "hda_disk_interface": "none",
          "hdb_disk_image": "",
          "hdb_disk_interface": "none",
          "hdc_disk_image": "",
          "hdc_disk_interface": "none",
          "hdd_disk_image": "",
          "hdd_disk_interface": "none",
          "cdrom_image": "",
          "initrd": "",
          "kernel_image": "",
          "bios_image": "",
          "kernel_command_line": "",
          "legacy_networking": false,
          "replicate_network_connection_state": true,
          "create_config_disk": false,
          "on_close": "power_off",
          "cpu_throttling": 0,
          "process_priority": "normal",
          "custom_adapters": [],
          "default_name_format": "{name}{0}"
      }
  ],
  "gns3vm": {
      "vmname": null,
      "when_exit": "stop",
      "headless": false,
      "enable": false,
      "engine": "vmware",
      "allocate_vcpus_ram": true,
      "ram": 2048,
      "vcpus": 1,
      "port": 80
  },
  "iou_license": {
      "iourc_content": "",
      "license_check": true
  },
  "appliances_etag": null,
  "version": "2.2.33.1"
}
"@

# gns3_gui.ini
$fil_gns3_gui = @"
{
    "Builtin": {
        "default_nat_interface": "vmnet8"
    },
    "Docker": {
        "containers": []
    },
    "Dynamips": {
        "allocate_aux_console_ports": false,
        "dynamips_path": "",
        "ghost_ios_support": true,
        "mmap_support": true,
        "sparse_memory_support": true
    },
    "GraphicsView": {
        "default_label_color": "#000000",
        "default_label_font": "TypeWriter,10,-1,5,75,0,0,0,0,0",
        "default_note_color": "#000000",
        "default_note_font": "TypeWriter,10,-1,5,75,0,0,0,0,0",
        "draw_link_status_points": true,
        "draw_rectangle_selected_item": false,
        "drawing_grid_size": 25,
        "grid_size": 75,
        "limit_size_node_symbols": true,
        "scene_height": 1000,
        "scene_width": 2000,
        "show_grid": false,
        "show_grid_on_new_project": false,
        "show_interface_labels": false,
        "show_interface_labels_on_new_project": false,
        "show_layers": false,
        "snap_to_grid": false,
        "snap_to_grid_on_new_project": false,
        "zoom": null
    },
    "IOU": {
        "iourc_content": "",
        "license_check": true
    },
    "MainWindow": {
        "check_for_update": false,
        "debug_level": 0,
        "delay_console_all": 1500,
        "direct_file_upload": false,
        "experimental_features": false,
        "geometry": "AdnQywADAAAAAAHSAAAAgwAABa0AAANuAAAB0wAAAKIAAAWsAAADbQAAAAAAAAAAB4AAAAHTAAAAogAABawAAANt",
        "hdpi": true,
        "hide_getting_started_dialog": false,
        "hide_new_template_button": false,
        "hide_setup_wizard": true,
        "last_check_for_update": 0,
        "multi_profiles": false,
        "overlay_notifications": true,
        "recent_files": [],
        "recent_projects": [],
        "send_stats": true,
        "spice_console_command": "\"C:\\Program Files\\VirtViewer v7.0-256\\bin\\remote-viewer.exe\" spice://%h:%p",
        "state": "AAAA/wAAAAD9AAAAAwAAAAAAAAAAAAAAAPwCAAAAAfsAAAAiAHUAaQBOAG8AZABlAHMARABvAGMAawBXAGkAZABnAGUAdAAAAAAA/////wAAAIcA////AAAAAQAAAQAAAAGT/AIAAAAC+wAAADYAdQBpAFQAbwBwAG8AbABvAGcAeQBTAHUAbQBtAGEAcgB5AEQAbwBjAGsAVwBpAGQAZwBlAHQBAAAAQwAAAMcAAABZAP////sAAAA0AHUAaQBDAG8AbQBwAHUAdABlAFMAdQBtAG0AYQByAHkARABvAGMAawBXAGkAZABnAGUAdAEAAAEQAAAAxgAAAFkA////AAAAAwAAA5oAAADT/AEAAAAB+wAAACYAdQBpAEMAbwBuAHMAbwBsAGUARABvAGMAawBXAGkAZABnAGUAdAEAAABAAAADmgAAAEYAB///AAAClAAAAZMAAAAEAAAABAAAAAgAAAAI/AAAAAIAAAAAAAAAAQAAACIAdQBpAEIAcgBvAHcAcwBlAHIAcwBUAG8AbwBsAEIAYQByAwAAAAD/////AAAAAAAAAAAAAAACAAAAAwAAACAAdQBpAEcAZQBuAGUAcgBhAGwAVABvAG8AbABCAGEAcgEAAAAA/////wAAAAAAAAAAAAAAIAB1AGkAQwBvAG4AdAByAG8AbABUAG8AbwBsAEIAYQByAQAAAGL/////AAAAAAAAAAAAAAAmAHUAaQBBAG4AbgBvAHQAYQB0AGkAbwBuAFQAbwBvAGwAQgBhAHIBAAABmP////8AAAAAAAAAAA==",
        "stats_visitor_id": "bdde99d6-7b08-4a90-9d18-144f902e683a",
        "style": "Charcoal",
        "symbol_theme": "Classic",
        "telnet_console_command": "Solar-PuTTY.exe --telnet --hostname %h --port %p  --name \"%d\"",
        "vnc_console_command": "C:\\Program Files\\TightVNC\\tvnviewer.exe %h:%p"
    },
    "NodesView": {
        "nodes_view_filter": 0
    },
    "Qemu": {
        "enable_hardware_acceleration": true,
        "require_hardware_acceleration": true
    },
    "VMware": {
        "block_host_traffic": true,
        "host_type": "ws",
        "vmnet_end_range": 19,
        "vmnet_start_range": 2,
        "vmrun_path": ""
    },
    "VPCS": {
        "vpcs_path": ""
    },
    "VirtualBox": {
        "vboxmanage_path": ""
    },
    "type": "settings",
    "version": "2.2.32"
}
"@

# test.gns3 
$fil_test_gns3 = @"
{
  "auto_close": true,
  "auto_open": false,
  "auto_start": false,
  "drawing_grid_size": 25,
  "grid_size": 75,
  "name": "test",
  "project_id": "a755b1fc-5c72-4a35-aae9-b1ff3cf7092c",
  "revision": 9,
  "scene_height": 1000,
  "scene_width": 2000,
  "show_grid": false,
  "show_interface_labels": true,
  "show_layers": false,
  "snap_to_grid": false,
  "supplier": null,
  "topology": {
      "computes": [
          {
              "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
              "host": "gns3",
              "name": "gns3",
              "port": 3080,
              "protocol": "http"
          }
      ],
      "drawings": [
          {
              "drawing_id": "f1675736-35fb-437a-8c17-7138eda57109",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"24\" width=\"125\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">Lab15 - DHCP SRV</text></svg>",
              "x": -34,
              "y": -392,
              "z": 2
          },
          {
              "drawing_id": "33831838-6288-4037-8227-b5c01e805d4f",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"100\" width=\"200\"><rect fill=\"#ffff7f\" fill-opacity=\"1.0\" height=\"100\" stroke=\"#000000\" stroke-width=\"2\" width=\"200\" /></svg>",
              "x": -304,
              "y": -152,
              "z": 1
          },
          {
              "drawing_id": "78a03cfc-c573-4797-abf9-f27ff1ef2eb7",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"24\" width=\"35\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">DMZ</text></svg>",
              "x": -226,
              "y": -143,
              "z": 2
          },
          {
              "drawing_id": "0b6db0d2-5117-4267-ac6f-0234873cbf52",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"24\" width=\"108\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">192.168.2.0/24</text></svg>",
              "x": -258,
              "y": -124,
              "z": 2
          },
          {
              "drawing_id": "f7397686-e4fc-4813-b5c2-1f004737b3e0",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"0\" width=\"281\"><line stroke=\"#000000\" stroke-width=\"2\" x1=\"0\" x2=\"281\" y1=\"0\" y2=\"0\" /></svg>",
              "x": -109,
              "y": -368,
              "z": 1
          },
          {
              "drawing_id": "9b571787-a860-496d-ba61-3b8ead76e73c",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"100\" width=\"200\"><rect fill=\"#aaffff\" fill-opacity=\"1.0\" height=\"100\" stroke=\"#000000\" stroke-width=\"2\" width=\"200\" /></svg>",
              "x": 163,
              "y": -141,
              "z": 1
          },
          {
              "drawing_id": "22b8aec3-0ac4-45de-bd21-d9590c3d4de9",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"24\" width=\"21\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">IN</text></svg>",
              "x": 253,
              "y": -136,
              "z": 2
          },
          {
              "drawing_id": "49eb25dd-562d-4b17-b3ba-ba0fac09a100",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"24\" width=\"45\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">(LAN)</text></svg>",
              "x": 242,
              "y": -117,
              "z": 2
          },
          {
              "drawing_id": "8e76b876-f73c-4463-a90c-4ca03298c8ba",
              "locked": false,
              "rotation": 0,
              "svg": "<svg height=\"24\" width=\"108\"><text fill=\"#000000\" fill-opacity=\"1.0\" font-family=\"TypeWriter\" font-size=\"10.0\" font-weight=\"bold\">192.168.1.0/24</text></svg>",
              "x": 213,
              "y": -95,
              "z": 2
          }
      ],
      "links": [
          {
              "filters": {},
              "link_id": "d6606bf2-cb56-46d5-b3ba-c704417c7c1c",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 2,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Port3",
                          "x": 42,
                          "y": 55
                      },
                      "node_id": "ba842437-7113-4dae-b5e9-ba285d97967a",
                      "port_number": 0
                  },
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Loopback",
                          "x": 40,
                          "y": -26
                      },
                      "node_id": "5861eb87-977e-4c84-b6c1-161acab661ce",
                      "port_number": 1
                  }
              ],
              "suspend": false
          },
          {
              "filters": {},
              "link_id": "82f0ee47-60ec-44d3-a4f7-12578cb6f325",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 1,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Port2 \n(.100)",
                          "x": -62,
                          "y": -31
                      },
                      "node_id": "ba842437-7113-4dae-b5e9-ba285d97967a",
                      "port_number": 0
                  },
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Gi0/0",
                          "x": 65,
                          "y": 24
                      },
                      "node_id": "a88e5535-5118-4bbd-a199-ba95f0a3971f",
                      "port_number": 0
                  }
              ],
              "suspend": false
          },
          {
              "filters": {},
              "link_id": "2109c7b7-e269-4abb-b4f7-d6fd83f64eb9",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Port1",
                          "x": 52,
                          "y": -30
                      },
                      "node_id": "ba842437-7113-4dae-b5e9-ba285d97967a",
                      "port_number": 0
                  },
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "nat0",
                          "x": 77,
                          "y": 74
                      },
                      "node_id": "a9a33d60-d5b5-4f07-9b2f-7097753d3e60",
                      "port_number": 0
                  }
              ],
              "suspend": false
          },
          {
              "filters": {},
              "link_id": "79da8b4a-857d-4c54-ba53-e0d3cf3ae799",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 3,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Port4",
                          "x": 74,
                          "y": 25
                      },
                      "node_id": "ba842437-7113-4dae-b5e9-ba285d97967a",
                      "port_number": 0
                  },
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Gi0/0",
                          "x": -55,
                          "y": 1
                      },
                      "node_id": "e3e4420f-9962-450f-945d-e9fff591c819",
                      "port_number": 0
                  }
              ],
              "suspend": false
          },
          {
              "filters": {},
              "link_id": "3a2a9b4a-59c9-433e-b702-c932de233849",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 1,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Gi0/1",
                          "x": -49,
                          "y": 40
                      },
                      "node_id": "a88e5535-5118-4bbd-a199-ba95f0a3971f",
                      "port_number": 0
                  },
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "e0",
                          "x": 52,
                          "y": -29
                      },
                      "node_id": "7ff58578-9399-454e-84bd-97476909ab32",
                      "port_number": 0
                  }
              ],
              "suspend": false
          },
          {
              "filters": {},
              "link_id": "635badbe-07f4-40ec-b2fd-716a64ffad3b",
              "link_style": {},
              "nodes": [
                  {
                      "adapter_number": 2,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "Gi0/2",
                          "x": -63,
                          "y": -11
                      },
                      "node_id": "a88e5535-5118-4bbd-a199-ba95f0a3971f",
                      "port_number": 0
                  },
                  {
                      "adapter_number": 0,
                      "label": {
                          "rotation": 0,
                          "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                          "text": "e0",
                          "x": 56,
                          "y": 61
                      },
                      "node_id": "0206d4ee-71f8-452d-bfbf-6fd2c813c336",
                      "port_number": 0
                  }
              ],
              "suspend": false
          }
      ],
      "nodes": [
          {
              "compute_id": "local",
              "console": null,
              "console_auto_start": false,
              "console_type": "none",
              "custom_adapters": [],
              "first_port_name": null,
              "height": 60,
              "label": {
                  "rotation": 0,
                  "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                  "text": "MGMT",
                  "x": 5,
                  "y": 70
              },
              "locked": false,
              "name": "MGMT",
              "node_id": "5861eb87-977e-4c84-b6c1-161acab661ce",
              "node_type": "cloud",
              "port_name_format": "Ethernet{0}",
              "port_segment_size": 0,
              "properties": {
                  "interfaces": [
                      {
                          "name": "Ethernet",
                          "special": false,
                          "type": "ethernet"
                      },
                      {
                          "name": "Loopback",
                          "special": true,
                          "type": "ethernet"
                      }
                  ],
                  "ports_mapping": [
                      {
                          "interface": "Ethernet",
                          "name": "Ethernet",
                          "port_number": 0,
                          "type": "ethernet"
                      },
                      {
                          "interface": "Loopback",
                          "name": "Loopback",
                          "port_number": 1,
                          "type": "ethernet"
                      }
                  ],
                  "remote_console_host": "",
                  "remote_console_http_path": "/",
                  "remote_console_port": 23,
                  "remote_console_type": "none"
              },
              "symbol": ":/symbols/affinity/circle/red/client.svg",
              "template_id": "39e257dc-8412-3174-b6b3-0ee3ed6a43e9",
              "width": 60,
              "x": -6,
              "y": 59,
              "z": 1
          },
          {
              "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
              "console": 5002,
              "console_auto_start": false,
              "console_type": "telnet",
              "custom_adapters": [],
              "first_port_name": "",
              "height": 48,
              "label": {
                  "rotation": 0,
                  "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                  "text": "SW1",
                  "x": 14,
                  "y": -20
              },
              "locked": false,
              "name": "SW1",
              "node_id": "a88e5535-5118-4bbd-a199-ba95f0a3971f",
              "node_type": "qemu",
              "port_name_format": "Gi{1}/{0}",
              "port_segment_size": 4,
              "properties": {
                  "adapter_type": "e1000",
                  "adapters": 16,
                  "bios_image": "",
                  "bios_image_md5sum": null,
                  "boot_priority": "c",
                  "cdrom_image": "",
                  "cdrom_image_md5sum": null,
                  "cpu_throttling": 0,
                  "cpus": 1,
                  "create_config_disk": false,
                  "hda_disk_image": "SW_iosv_2020.qcow2",
                  "hda_disk_image_md5sum": "99ecab32de12410c533e6abd4e9710aa",
                  "hda_disk_interface": "virtio",
                  "hdb_disk_image": "",
                  "hdb_disk_image_md5sum": null,
                  "hdb_disk_interface": "none",
                  "hdc_disk_image": "",
                  "hdc_disk_image_md5sum": null,
                  "hdc_disk_interface": "none",
                  "hdd_disk_image": "",
                  "hdd_disk_image_md5sum": null,
                  "hdd_disk_interface": "none",
                  "initrd": "",
                  "initrd_md5sum": null,
                  "kernel_command_line": "",
                  "kernel_image": "",
                  "kernel_image_md5sum": null,
                  "legacy_networking": false,
                  "linked_clone": true,
                  "mac_address": "0c:8e:55:35:00:00",
                  "on_close": "power_off",
                  "options": "",
                  "platform": "x86_64",
                  "process_priority": "normal",
                  "qemu_path": "/usr/bin/qemu-system-x86_64",
                  "ram": 768,
                  "replicate_network_connection_state": true,
                  "usage": "There is no default password and enable password. There is no default configuration present."
              },
              "symbol": ":/symbols/classic/multilayer_switch.svg",
              "template_id": "97bac41e-e09c-490c-8c6f-f433369bd99e",
              "width": 51,
              "x": -464,
              "y": -134,
              "z": 1
          },
          {
              "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
              "console": 5004,
              "console_auto_start": false,
              "console_type": "telnet",
              "custom_adapters": [],
              "first_port_name": "",
              "height": 50,
              "label": {
                  "rotation": 0,
                  "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                  "text": "FG1",
                  "x": 21,
                  "y": 11
              },
              "locked": false,
              "name": "FG1",
              "node_id": "ba842437-7113-4dae-b5e9-ba285d97967a",
              "node_type": "qemu",
              "port_name_format": "Port{port1}",
              "port_segment_size": 0,
              "properties": {
                  "adapter_type": "e1000",
                  "adapters": 10,
                  "bios_image": "",
                  "bios_image_md5sum": null,
                  "boot_priority": "c",
                  "cdrom_image": "",
                  "cdrom_image_md5sum": null,
                  "cpu_throttling": 0,
                  "cpus": 1,
                  "create_config_disk": false,
                  "hda_disk_image": "FGT6.4.7.qcow2",
                  "hda_disk_image_md5sum": "dcdf7bf5e1ff85c64638c1dfaa48ff65",
                  "hda_disk_interface": "virtio",
                  "hdb_disk_image": "empty30G.qcow2",
                  "hdb_disk_image_md5sum": "3411a599e822f2ac6be560a26405821a",
                  "hdb_disk_interface": "virtio",
                  "hdc_disk_image": "",
                  "hdc_disk_image_md5sum": null,
                  "hdc_disk_interface": "none",
                  "hdd_disk_image": "",
                  "hdd_disk_image_md5sum": null,
                  "hdd_disk_interface": "none",
                  "initrd": "",
                  "initrd_md5sum": null,
                  "kernel_command_line": "",
                  "kernel_image": "",
                  "kernel_image_md5sum": null,
                  "legacy_networking": false,
                  "linked_clone": true,
                  "mac_address": "0c:84:24:37:00:00",
                  "on_close": "power_off",
                  "options": "",
                  "platform": "x86_64",
                  "process_priority": "normal",
                  "qemu_path": "/usr/bin/qemu-system-x86_64",
                  "ram": 1024,
                  "replicate_network_connection_state": true,
                  "usage": "Default username is admin, no password is set."
              },
              "symbol": "fortinet.svg",
              "template_id": "ef90e3b5-4b61-42e3-8396-d807d5a684af",
              "width": 70,
              "x": -13,
              "y": -105,
              "z": 1
          },
          {
              "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
              "console": null,
              "console_auto_start": false,
              "console_type": "none",
              "custom_adapters": [],
              "first_port_name": null,
              "height": 71,
              "label": {
                  "rotation": 0,
                  "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                  "text": "WAN(NAT)",
                  "x": 41,
                  "y": -25
              },
              "locked": false,
              "name": "WAN(NAT)",
              "node_id": "a9a33d60-d5b5-4f07-9b2f-7097753d3e60",
              "node_type": "nat",
              "port_name_format": "Ethernet{0}",
              "port_segment_size": 0,
              "properties": {
                  "ports_mapping": [
                      {
                          "interface": "virbr0",
                          "name": "nat0",
                          "port_number": 0,
                          "type": "ethernet"
                      }
                  ]
              },
              "symbol": ":/symbols/cloud.svg",
              "template_id": "df8f4ea9-33b7-3e96-86a2-c39bc9bb649c",
              "width": 159,
              "x": -48,
              "y": -297,
              "z": 1
          },
          {
              "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
              "console": 5007,
              "console_auto_start": false,
              "console_type": "telnet",
              "custom_adapters": [],
              "first_port_name": "",
              "height": 48,
              "label": {
                  "rotation": 0,
                  "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                  "text": "SW2",
                  "x": 7,
                  "y": -25
              },
              "locked": false,
              "name": "SW2",
              "node_id": "e3e4420f-9962-450f-945d-e9fff591c819",
              "node_type": "qemu",
              "port_name_format": "Gi{1}/{0}",
              "port_segment_size": 4,
              "properties": {
                  "adapter_type": "e1000",
                  "adapters": 16,
                  "bios_image": "",
                  "bios_image_md5sum": null,
                  "boot_priority": "c",
                  "cdrom_image": "",
                  "cdrom_image_md5sum": null,
                  "cpu_throttling": 0,
                  "cpus": 1,
                  "create_config_disk": false,
                  "hda_disk_image": "SW_iosv_2020.qcow2",
                  "hda_disk_image_md5sum": "99ecab32de12410c533e6abd4e9710aa",
                  "hda_disk_interface": "virtio",
                  "hdb_disk_image": "",
                  "hdb_disk_image_md5sum": null,
                  "hdb_disk_interface": "none",
                  "hdc_disk_image": "",
                  "hdc_disk_image_md5sum": null,
                  "hdc_disk_interface": "none",
                  "hdd_disk_image": "",
                  "hdd_disk_image_md5sum": null,
                  "hdd_disk_interface": "none",
                  "initrd": "",
                  "initrd_md5sum": null,
                  "kernel_command_line": "",
                  "kernel_image": "",
                  "kernel_image_md5sum": null,
                  "legacy_networking": false,
                  "linked_clone": true,
                  "mac_address": "0c:e4:42:0f:00:00",
                  "on_close": "power_off",
                  "options": "",
                  "platform": "x86_64",
                  "process_priority": "normal",
                  "qemu_path": "/usr/bin/qemu-system-x86_64",
                  "ram": 768,
                  "replicate_network_connection_state": true,
                  "usage": "There is no default password and enable password. There is no default configuration present."
              },
              "symbol": ":/symbols/classic/multilayer_switch.svg",
              "template_id": "97bac41e-e09c-490c-8c6f-f433369bd99e",
              "width": 51,
              "x": 487,
              "y": -109,
              "z": 1
          },
          {
              "compute_id": "2e0d1578-d11f-46cf-b22b-d02aa3a5d426",
              "console": 5900,
              "console_auto_start": false,
              "console_type": "vnc",
              "custom_adapters": [],
              "first_port_name": "",
              "height": 153,
              "label": {
                  "rotation": 0,
                  "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                  "text": "WinXP1",
                  "x": -7,
                  "y": 91
              },
              "locked": false,
              "name": "WinXP1",
              "node_id": "7ff58578-9399-454e-84bd-97476909ab32",
              "node_type": "qemu",
              "port_name_format": "Ethernet{0}",
              "port_segment_size": 0,
              "properties": {
                  "adapter_type": "pcnet",
                  "adapters": 2,
                  "bios_image": "",
                  "bios_image_md5sum": null,
                  "boot_priority": "c",
                  "cdrom_image": "",
                  "cdrom_image_md5sum": null,
                  "cpu_throttling": 0,
                  "cpus": 1,
                  "create_config_disk": false,
                  "hda_disk_image": "WinXP-disk1.vmdk",
                  "hda_disk_image_md5sum": "f7fc1948749f0a62c3cccf0775d74f05",
                  "hda_disk_interface": "none",
                  "hdb_disk_image": "",
                  "hdb_disk_image_md5sum": null,
                  "hdb_disk_interface": "none",
                  "hdc_disk_image": "",
                  "hdc_disk_image_md5sum": null,
                  "hdc_disk_interface": "none",
                  "hdd_disk_image": "",
                  "hdd_disk_image_md5sum": null,
                  "hdd_disk_interface": "none",
                  "initrd": "",
                  "initrd_md5sum": null,
                  "kernel_command_line": "",
                  "kernel_image": "",
                  "kernel_image_md5sum": null,
                  "legacy_networking": false,
                  "linked_clone": true,
                  "mac_address": "0c:f5:85:78:00:00",
                  "on_close": "power_off",
                  "options": "-nographic -usbdevice tablet -vga std -nodefaults",
                  "platform": "i386",
                  "process_priority": "normal",
                  "qemu_path": "/usr/bin/qemu-system-i386",
                  "ram": 512,
                  "replicate_network_connection_state": true,
                  "usage": ""
              },
              "symbol": "xp_win.svg",
              "template_id": "b7cf6c6f-0f6d-4e2b-969d-c2aaea06e973",
              "width": 173,
              "x": -626,
              "y": 41,
              "z": 1
          },
          {
              "compute_id": "local",
              "console": 5001,
              "console_auto_start": false,
              "console_type": "telnet",
              "custom_adapters": [],
              "first_port_name": null,
              "height": 59,
              "label": {
                  "rotation": 0,
                  "style": "font-family: TypeWriter;font-size: 10.0;font-weight: bold;fill: #000000;fill-opacity: 1.0;",
                  "text": "VPC2",
                  "x": 16,
                  "y": -25
              },
              "locked": false,
              "name": "VPC2",
              "node_id": "0206d4ee-71f8-452d-bfbf-6fd2c813c336",
              "node_type": "vpcs",
              "port_name_format": "Ethernet{0}",
              "port_segment_size": 0,
              "properties": {},
              "symbol": ":/symbols/vpcs_guest.svg",
              "template_id": "19021f99-e36f-394d-b4a1-8aaa902ab9cc",
              "width": 65,
              "x": -652,
              "y": -304,
              "z": 1
          }
      ]
  },
  "type": "topology",
  "variables": null,
  "version": "2.2.33.1",
  "zoom": 100
}
"@

#################
#   LOOPBACK   #
#################

# name
$loopbackName = "Loopback"
# nic
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

# UserProfile
cd $pth_usrPrf
'images','configs','projects','symbols' | 
  % {ni -Name ".\GNS3\$_" -ItemType 'Directory' -EA 0}
# QEMU
$pth_QEMU = ni $pth_usrPrf\GNS3\images -Name QEMU -Type Directory
# images
$pth_images = "$pth_usrPrf\GNS3\images"
# sybols
$pth_symbols = "$pth_usrPrf\GNS3\symbols"
# AppData
$pth_AppData_2_2 = ni $pth_AppData\GNS3 -Name 2.2 -Type Directory
# projects
$pth_projects = "$pth_usrPrf\GNS3\projects"

# gns3-app
Start-BitsTransfer -Source $URL_gns3 `
  -Destination "d:\gns3.exe" -EA 0

# SW_iosv_2020.qcow2
Start-BitsTransfer -Source $URL_sw_iosv_2020_qcow2 `
  -Destination "$pth_QEMU\SW_iosv_2020.qcow2" -EA 0
# FGT6.4.7.qcow2
Start-BitsTransfer -Source $URL_FGT6_4_7_qcow2 `
  -Destination "$pth_QEMU\FGT6.4.7.qcow2" -EA 0
# vios_159-3.m4.qcow2
Start-BitsTransfer -Source $URL_vios_159_3_m4_qcow2 `
  -Destination "$pth_QEMU\vios_159-3.m4.qcow2" -EA 0
# iosv_startup_config.img
Start-BitsTransfer -Source $URL_iosv_startup_cfg_img `
  -Destination "$pth_QEMU\iosv_startup_config.img" -EA 0
# empty30G.qcow2
Start-BitsTransfer -Source $URL_empty30G_qcow2 `
  -Destination $pth_QEMU\empty30G.qcow2 -EA 0
# IE6 - WinXP-disk1.vmdk
Start-BitsTransfer -Source $URL_winXP_IE6_vmdk `
  -Destination "$pth_QEMU\WinXP-disk1.vmdk" -EA 0

# gns3_server.ini (appData)
Start-BitsTransfer -Source $URL_gns3_server_ini `
  -Destination "$pth_AppData_2_2\gns3_server.ini" -EA 0
# gns3_controller.ini (appData)
$fil_gns3_controller |
 out-file "$pth_AppData_2_2\gns3_controller.ini" -Encoding ascii


# TightVnc viewer
try {
  Start-BitsTransfer -Source $URL_tightVnc `
  -Destination "d:\tightVnc.msi"
}
catch {
  $Error[0] | out-file d:\ErrorTightVnc.log
}

# gn3_gui.ini
try {
  $fil_gns3_gui |
  out-file "$pth_AppData_2_2\gns3_gui.ini" -Encoding ascii
}
catch {
  $Error[0] | out-file d:\ErrorAppdata_gns3_gui_ini.log
}
  
# project files
try{
  $fil_test_gns3 | out-file $pth_usrPrf\GNS3\projects\test.gns3 -Encoding ascii
}catch{
  $Error[0] | out-file d:\ErrorTest.gns3.log
}

################
#  LIBRARY DDL #
################

# InstallDir WinPcap
try{
  $pth_winPcap = ni ${env:ProgramFiles(x86)} -Name WinPcap -Type Directory
}catch{
  $Error[0] | out-file d:\ErroInstallDirWinPcap.log
}

# npf.sys x64
try{
  Start-BitsTransfer -Source $URL_npf_sys `
   -Destination "$pth_drivers\npf.sys"
}catch{
  $Error[0] | out-file d:\ErrorNpf_drivers_x64.log
}
# wpcap.dll x32
try{
  Start-BitsTransfer -Source $URL_wpcap_x32 `
  -Destination "C:\Windows\SysWOW64\wpcap.dll"
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

################
# INSTALL APPS #
################

# fortinet.svg
Start-BitsTransfer -Source $URL_fortinet_svg `
  -Destination "$pth_symbols\fortinet.svg" -EA 0
# firefox.svg
Start-BitsTransfer -Source $URL_firefox_svg `
  -Destination "$pth_symbols\firefox.svg" -EA 0
# xp_win.svg
$fil_xp_win_svg | 
  out-file "$pth_symbols\xp_win.svg" -Encoding ascii

# Install tightVnc.msi
try {
  start msiExec -args "/i d:\tightVnc.msi /q /l* d:\InstalltightVnc.log"
}
catch {
  $Error[0] | out-file d:\ErrorInstallTightVnc.log
}

# gns3
try {
  start d:\gns3.exe -args "/S" -wait
}
catch {
  $Error[0] | out-file d:\ErrorInstallGns3.log
}

# solar-putty.exe in gns3 because missing newVer 2.2.33.1
try {
  start-BitsTransfer $URL_solarPutty `
  -Destination "C:\Program Files\GNS3\Solar-PuTTY.exe"
}
catch {
  $Error[0] | out-file d:\ErrorSolarPutty.log
}

# no eula : ntuser.dat
try{
start-BitsTransfer $URL_ntuser `
  -Destination "$pth_usrPrf\NTUSER.DAT"
}catch{
  $Error[0] | out-file d:\ErrorNTUser.dat.log
}

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
