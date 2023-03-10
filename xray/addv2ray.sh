#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================

clear
date
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
echo ""
source /var/lib/geovpnstore/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi

tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo "-----------------------------------------";
echo "---------=[ Add Vmess Account ]=---------";
echo "-----------------------------------------";
read -rp "Bug: " -e bug
read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/v2ray-tls.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear

			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo "-----------------------------------------";
			read -n 1 -s -r -p "Press any key to back on menu"
menu-v2ray
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
exp=`date -d "$masaaktif days" +"%d-%m-%Y"`
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
      "path": "/worryfree/",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF
cat>/etc/xray/v2ray-$user-nontls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${nontls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/worryfree/",
      "type": "none",
      "host": "${bug}",
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
systemctl restart xray
CHATID="$CHATID"
KEY="$KEY"
TIME="$TIME"
URL="$URL"
TEXT="<code>-----------------------</code>
<code>      XRAY/VMESS</code>
<code>-----------------------</code>
<code>Remarks        : ${user}
CITY           : $CITY
ISP            : $ISP
Domain         : ${domain}
Port TLS       : 443
Port none TLS  : 80
id             : ${uuid}
alterId        : 0
Security       : auto
network        : ws
path           : /worryfree/</code>
<code>-----------------------</code>
<code> VMESS WS TLS</code>
<code>-----------------------</code>
<code>${xrayv2ray1}</code>
<code>-----------------------</code>
<code> VMESS WS NO TLS</code>
<code>-----------------------</code>
<code>${xrayv2ray2}</code>
<code>-----------------------</code>
Aktif Selama   : $masaaktif Hari
Dibuat Pada    : $tnggl
Berakhir Pada  : $expe
<code>-----------------------</code>
"

curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "\E[44;1;39m  ⇱ Xray/Vmess Account  ⇲ \E[0m" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Remarks         : ${user}" | tee -a /etc/log-create-user.log
echo -e "Domain          : ${domain}" | tee -a /etc/log-create-user.log
echo -e "Port TLS        : ${tls}" | tee -a /etc/log-create-user.log
echo -e "Port none TLS   : ${nontls}" | tee -a /etc/log-create-user.log
echo -e "id              : ${uuid}" | tee -a /etc/log-create-user.log
echo -e "alterId         : 0" | tee -a /etc/log-create-user.log
echo -e "Security        : auto" | tee -a /etc/log-create-user.log
echo -e "network         : ws" | tee -a /etc/log-create-user.log
echo -e "path            : /worryfree/" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link TLS        : ${xrayv2ray1}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "Link none TLS   : ${xrayv2ray2}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e " Aktif Selama   : $masaaktif Hari" | tee -a /etc/log-create-user.log
echo -e " Dibuat Pada    : $tnggl" | tee -a /etc/log-create-user.log
echo -e " Berakhir Pada  : $expe" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
rm /etc/xray/$user-tls.json > /dev/null 2>&1
rm /etc/xray/$user-nontls.json > /dev/null 2>&1
read -n 1 -s -r -p "Press any key to back on menu"

menu-v2ray
