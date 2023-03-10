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
VPN_USER=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
VPN_PASSWORD=123

# Add or update VPN user
cat >> /etc/ppp/chap-secrets <<EOF
"$VPN_USER" l2tpd "$VPN_PASSWORD" *
EOF

VPN_PASSWORD_ENC=$(openssl passwd -1 "$VPN_PASSWORD")
cat >> /etc/ipsec.d/passwd <<EOF
$VPN_USER:$VPN_PASSWORD_ENC:xauth-psk
EOF

# Update file attributes
chmod 600 /etc/ppp/chap-secrets* /etc/ipsec.d/passwd*
echo -e "### $VPN_USER $exp">>"/var/lib/geovpnstore/data-user-l2tp"

clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m       ⇱ Trial L2TP Account ⇲      \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${white}ISP   : $ISP"
echo -e " CITY          : $CITY"
echo -e " COUNTRY       : $COUNTRY"
echo -e " Server IP     : $MYIP"
echo -e " Server Host   : $domain"
echo -e " IPSec PSK     : myvpn"
echo -e " Username      : $VPN_USER"
echo -e " Password      : $VPN_PASSWORD$"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " Aktif Selama : $masaaktif Hari"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e ""
echo -e ""
read -n 1 -s -r -p "Press Any Key To Back On Menu"

menu-trial
