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
# Create Expried 
masaaktif="1"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

read -rp "Bug: " -e bug
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
# Make Random Username 
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
created=`date -d "0 days" +"%d-%m-%Y"`
sed -i '/#xray-v2ray-tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/v2ray-tls.json
sed -i '/#xray-v2ray-nontls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/v2ray-nontls.json
cat>/etc/xray/v2ray-$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/geovpn/",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF
cat>/etc/xray/v2ray-$user-nontls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${bug}",
      "port": "${nontls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/geovpn/",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
xrayv2ray1="vmess://$(base64 -w 0 /etc/xray/v2ray-$user-tls.json)"
xrayv2ray2="vmess://$(base64 -w 0 /etc/xray/v2ray-$user-nontls.json)"
systemctl restart xray@v2ray-tls
systemctl restart xray@v2ray-nontls
service cron restart
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m🔸 Xray/Vmess Account🔸\E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks : ${user}"
echo -e "Domain : ${domain}"
echo -e "port TLS : ${tls}"
echo -e "port none TLS : ${nontls}"
echo -e "id : ${uuid}"
echo -e "alterId : 0"
echo -e "Security : auto"
echo -e "network : ws"
echo -e "path : /geovpn/"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link TLS : ${xrayv2ray1}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Link none TLS : ${xrayv2ray2}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Expired On : $masaaktif Hari"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"

menu-trial
