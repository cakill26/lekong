#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================

clear
date
echo ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m                 ⇱ CHANGE PORT MENU ⇲             \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "
[\033[0;32m01\033[0m] • Change Port OpenVPN
[\033[0;32m02\033[0m] • Change Port Wireguard
[\033[0;32m03\033[0m] • Change Port Vmess
[\033[0;32m04\033[0m] • Change Port Vless
[\033[0;32m05\033[0m] • Change Port Trojan
[\033[0;32m06\033[0m] • Change Port Squid
[\033[0;32m07\033[0m] • Change Port SSTP
[\033[0;32m08\033[0m] • Change Port SSH WS non TLS
[\033[0;32m09\033[0m] • Change Port SSH WS TLS

[00] • Back to Main Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -e ""
read -p "Select menu : " port
echo -e ""
case $port in
1)
portovpn
;;
2)
portwg
;;
3)
portv2ray
;;
4)
portvless
;;
5)
porttrojan
;;
6)
portsquid
;;
7)
portsstp
;;
8)
portwsnon
;;
9)
portwstls
;;
0 | 00)
setting-menu
;;
*)
changeport
;;
esac
