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
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
COUNTRY=$(curl -s ipinfo.io/country )

MYIP=$(wget -qO- ipinfo.io/ip);
clear
source /var/lib/geovpnstore/ipvps.conf
if [[ "$IP2" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP2
fi
# Create Expried 
masaaktif="1"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# Make Random Username 
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
pass=123

cat >> /home/sstp/sstp_account <<EOF
$user * $pass *
EOF
echo -e "### $user $exp">>"/var/lib/geovpnstore/data-user-sstp"
clear
echo -e ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m  ⇱ Trial SSTP Account ⇲ \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${white}ISP    : $ISP"
echo -e " CITY           : $CITY"
echo -e " COUNTRY        : $COUNTRY"
echo -e " Server IP      : $MYIP"
echo -e " Server Host    : $domain"
echo -e " Port           : 444"
echo -e " Username       : $user"
echo -e " Password       : $pass"
echo -e " Cert           : http://$MYIP:89/server.crt"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${white}Aktif Selama   : $masaaktif Hari"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -n 1 -s -r -p "Press Any Key To Back On Menu"

menu-trial


