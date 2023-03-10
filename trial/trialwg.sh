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
# Load params
source /etc/wireguard/params
source /var/lib/geovpnstore/ipvps.conf
if [[ "$IP" = "" ]]; then
SERVER_PUB_IP=$(cat /etc/xray/domain);
else
SERVER_PUB_IP=$IP
fi

# Create Expried 
masaaktif="1"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# Make Random Username 
CLIENT_NAME=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`

ENDPOINT="$SERVER_PUB_IP:$SERVER_PORT"
WG_CONFIG="/etc/wireguard/wg0.conf"
LASTIP=$( grep "/32" $WG_CONFIG | tail -n1 | awk '{print $3}' | cut -d "/" -f 1 | cut -d "." -f 4 )
if [[ "$LASTIP" = "" ]]; then
CLIENT_ADDRESS="10.66.66.2"
else
CLIENT_ADDRESS="10.66.66.$((LASTIP+1))"
fi

# Adguard DNS by default
CLIENT_DNS_1="176.103.130.130"

CLIENT_DNS_2="176.103.130.131"


# Generate key pair for the client
CLIENT_PRIV_KEY=$(wg genkey)
CLIENT_PUB_KEY=$(echo "$CLIENT_PRIV_KEY" | wg pubkey)
CLIENT_PRE_SHARED_KEY=$(wg genpsk)

# Create client file and add the server as a peer
echo "[Interface]
PrivateKey = $CLIENT_PRIV_KEY
Address = $CLIENT_ADDRESS/24
DNS = $CLIENT_DNS_1,$CLIENT_DNS_2

[Peer]
PublicKey = $SERVER_PUB_KEY
PresharedKey = $CLIENT_PRE_SHARED_KEY
Endpoint = $ENDPOINT
AllowedIPs = 0.0.0.0/0,::/0" >>"$HOME/$SERVER_WG_NIC-client-$CLIENT_NAME.conf"

# Add the client as a peer to the server
echo -e "### Client $CLIENT_NAME $exp
[Peer]
PublicKey = $CLIENT_PUB_KEY
PresharedKey = $CLIENT_PRE_SHARED_KEY
AllowedIPs = $CLIENT_ADDRESS/32" >>"/etc/wireguard/$SERVER_WG_NIC.conf"
systemctl restart "wg-quick@$SERVER_WG_NIC"
cp $HOME/$SERVER_WG_NIC-client-$CLIENT_NAME.conf /home/vps/public_html/$CLIENT_NAME.conf
clear
sleep 1
echo -e ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m  ⇱ TRIAL WG ACCOUNT ⇲ \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ISP            : ${ISP}"
echo -e " CITY           : ${CITY}"
echo -e " COUNTRY        : ${COUNTRY}"
echo -e " Server IP      : ${MYIP}"
echo -e " Server Host    : ${SERVER_PUB_IP}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " WireGuard URL  : "
echo -e " http://$SERVER_PUB_IP:89/$CLIENT_NAME.conf${off}"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " Aktif Selama   : $masaaktif Hari"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━\033[0m"
rm -f /root/wg0-client-$CLIENT_NAME.conf
echo -e ""
read -n 1 -s -r -p "Press Any Key To Back On Menu"

menu-trial

