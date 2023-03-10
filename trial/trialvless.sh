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
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
# Create Expried 
masaaktif="1"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# Make Random Username 
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)

sed -i '/#xray-vless-tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/vless-tls.json
sed -i '/#xray-vless-nontls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/vless-nontls.json
xrayvless1="vless://${uuid}@${domain}:$tls?path=/geovpn/&security=tls&encryption=none&type=ws#${user}"
xrayvless2="vless://${uuid}@${domain}:$nontls?path=/geovpn/&encryption=none&type=ws#${user}"
systemctl restart xray@vless-tls
systemctl restart xray@vless-nontls
service cron restart
clear
echo -e ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m  ⇱ Xray/Vless Account ⇲ \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks     : ${user}"
echo -e "IP/Host     : ${MYIP}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : $tls"
echo -e "Port No TLS : $nontls"
echo -e "User ID     : ${uuid}"
echo -e "Encryption  : none"
echo -e "Network     : ws"
echo -e "Path        : /geovpn/"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link TLS    : ${xrayvless1}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link No TLS : ${xrayvless2}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${green}Aktif Selama   : $masaaktif Hari"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -n 1 -s -r -p "Press Any Key To Back On Menu"

menu-trial

