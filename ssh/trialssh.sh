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
source /var/lib/geovpnstore/ipvps.conf
if [[ "$IP2" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP2
fi
clear
MYIP=$(curl -sS ipinfo.io/ip)
wssl="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
ws="$(cat ~/log-install.txt | grep -w "Websocket None TLS" | cut -d: -f2|sed 's/ //g')"
ohps="$(cat ~/log-install.txt | grep -w "OHP_SSH" | cut -d: -f2|sed 's/ //g')"
ohpd="$(cat ~/log-install.txt | grep -w "OHP_Dropbear" | cut -d: -f2|sed 's/ //g')"
ohpo="$(cat ~/log-install.txt | grep -w "OHP_OpenVPN" | cut -d: -f2|sed 's/ //g')"
open="$(cat ~/log-install.txt | grep -w "OpenSSH" | cut -d: -f2|sed 's/ //g')"
drop="$(cat ~/log-install.txt | grep -w "Dropbear" | cut -d: -f2|sed 's/ //g')"
web="$(cat ~/log-install.txt | grep -w "Websocket Ovpn" | cut -d: -f2|sed 's/ //g')"

ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear
Login=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Thank You For Using Our Services Trial SSH ${off}"
echo -e "OpenVPN & Websocket Account Info${off}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Username      : $Login"
echo -e "Password      : $Pass"
echo -e "Created       : $hariini"
echo -e "Expired       : $expi"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "IP/Host       : ${domain} / $MYIP"
echo -e "OpenSSH       : $open"
echo -e "Dropbear      : $drop"
echo -e "SSL/TLS       :$ssl"
echo -e "Port Squid    :$sqd"
echo -e "Port OHP      : SSH $ohps, Dropbear $ohpd, Ovpn $ohpo"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "SSH WS        : $ws"
echo -e "SSH WS SSL    : $wssl"
echo -e "OpenVPN WS    : $web"
echo -e "\033[0;34m===Payload CDN Websocket===\033[0m"
echo -e "GET / HTTP/1.1[crlf]Host: ${domain}[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]${off}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link Ovpn     : http://$MYIP:89/"
echo -e "badvpn        : 7100-7200-7300"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Enjoy Our Auto Script Service"
echo -e ""
read -n 1 -s -r -p "Press Any Key To Back On Menu"

menu-trial