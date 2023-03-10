#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================

clear
source /var/lib/geovpn/ipvps.conf
if [[ "$IP2" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP2
fi
clear
clear && clear && clear
clear;clear;clear

# // Input Data
echo "-----------------------------------------";
echo "---------=[ Add SSH Account ]=-----------";
echo "-----------------------------------------";
read -p "Username : " Username
Username="$(echo ${Username} | sed 's/ //g' | tr -d '\r' | tr -d '\r\n' )"

# // Validate Input
if [[ $Username == "" ]]; then
    echo -e "${EROR} Please Input an Username !"
    exit 1
fi

# // Validate User Exists
if [[ $( cat /etc/shadow | cut -d: -f1,8 | sed /:$/d | grep -w $Username ) == "" ]]; then
    Skip="true"
else
    clear
    clear && clear && clear
    clear;clear;clear
    echo -e "${EROR} User ( ${YELLOW}$Username${NC} ) Already Exists !"
    exit 1
fi

read -p "Password : " Password
read -p "Expired  : " Jumlah_Hari

# // String For IP & Port
domen=$(cat /etc/xray/domain)
MYIP=$(curl -sS ipinfo.io/ip)
#NS=$( cat /etc/xray/ns.txt )
#PUB=$( cat /etc/slowdns/server.pub )
wssl="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
ws="$(cat ~/log-install.txt | grep -w "Websocket None TLS" | cut -d: -f2|sed 's/ //g')"
wso="$(cat ~/log-install.txt | grep -w "Websocket Ovpn" | cut -d: -f2|sed 's/ //g')"
ohps="$(cat ~/log-install.txt | grep -w "OHP_SSH" | cut -d: -f2|sed 's/ //g')"
ohpd="$(cat ~/log-install.txt | grep -w "OHP_Dropbear" | cut -d: -f2|sed 's/ //g')"
ohpo="$(cat ~/log-install.txt | grep -w "OHP_OpenVPN" | cut -d: -f2|sed 's/ //g')"
open="$(cat ~/log-install.txt | grep -w "OpenSSH" | cut -d: -f2|sed 's/ //g')"
drop="$(cat ~/log-install.txt | grep -w "Dropbear" | cut -d: -f2|sed 's/ //g')"
web="$(cat ~/log-install.txt | grep -w "Websocket Ovpn" | cut -d: -f2|sed 's/ //g')"

ssl="$(cat ~/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
today=`date -d "0 days" +"%Y-%m-%d"`

# // Adding User To Server
useradd -e `date -d "$Jumlah_Hari days" +"%Y-%m-%d"` -s /bin/false -M $Username
echo -e "$Password\n$Password\n"|passwd $Username &> /dev/null
exp=`date -d "$Jumlah_Hari days" +"%Y-%m-%d"`

CHATID="$CHATID"
KEY="$KEY"
TIME="$TIME"
URL="$URL"
TEXT="<code>-----------------------</code>
<code>Your Premium VPN Details</code>
<code>-----------------------</code>
<code>IP Address    =</code> <code>$IP</code>
<code>Hostname      =</code> <code>$domen</code>
<code>Username      =</code> <code>$Username</code>
<code>Password      =</code> <code>$Password</code>
<code>-----------------------</code>
<code>OpenSSH       = ${open}
Dropbear      = ${drop}
Stunnel       =${ssl}
SSH WS TLS    = ${wssl}
SSH WS NTLS   = ${ws}
OVPN WS       = ${wso}
Squid Proxy   =${sqd} 
BadVPN UDP    = 7100-7200-7300</code>
<code>-----------------------</code>
Link OVPN CONFIG = http://${domen}:89
<code>-----------------------</code>
<code>Created = $today
Expired = $exp</code>
<code>-----------------------</code>
"

curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
# // Success
sleep 1
clear
clear && clear && clear
clear;clear;clear
echo -e "" | tee -a /etc/log-create-user.log
echo -e " ====================" | tee -a /etc/log-create-user.log
echo -e " Your Premium VPN Details" | tee -a /etc/log-create-user.log
echo -e " ====================" | tee -a /etc/log-create-user.log
echo -e " IP Address       = ${IP}" | tee -a /etc/log-create-user.log
echo -e " Hostname         = ${domen}" | tee -a /etc/log-create-user.log
echo -e " Username         = ${Username}" | tee -a /etc/log-create-user.log
echo -e " Password         = ${Password}" | tee -a /etc/log-create-user.log
echo -e " ====================" | tee -a /etc/log-create-user.log
echo -e " OpenSSH          = ${open}" | tee -a /etc/log-create-user.log
echo -e " Dropbear         = ${drop}" | tee -a /etc/log-create-user.log
echo -e " Stunnel          =${ssl}" | tee -a /etc/log-create-user.log
echo -e " SSH WS TLS       = ${wssl}" | tee -a /etc/log-create-user.log
echo -e " SSH WS NTLS      = ${ws}" | tee -a /etc/log-create-user.log
echo -e " OVPN WS          = ${wso}" | tee -a /etc/log-create-user.log
echo -e " Squid Proxy      =${sqd} " | tee -a /etc/log-create-user.log
echo -e " OHP              = SSH $ohps, Dropbear $ohpd, Ovpn $ohpo"
echo -e " BadVPN UDP       = 7100-7200-7300" | tee -a /etc/log-create-user.log
echo -e " ====================" | tee -a /etc/log-create-user.log
echo -e " Link OVPN CONFIG = http://${domen}:89/" | tee -a /etc/log-create-user.log
echo -e " ====================" | tee -a /etc/log-create-user.log
echo -e " Created = $today" | tee -a /etc/log-create-user.log
echo -e " Expired = $exp" | tee -a /etc/log-create-user.log
echo -e " ====================" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"

menu-ssh
