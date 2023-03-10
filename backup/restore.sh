#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================

clear
cd
mimpi=$(curl -sS ipv4.icanhazip.com);
#export NameUser=$( curl -s https://${Server_URLL}/validated-registered-license-key.txt | grep -w $Your_License_Key | cut -d ' ' -f 9-100 | awk '{print $1}' );
#NameUser=$(curl -sS https://${Server_URLL}/validated-registered-license-key.txt | grep -w $Your_License_Key | cut -d ' ' -f 9-100 | awk '{print $1}' );
cekdata=$(curl -sS https://raw.githubusercontent.com/cakill26/backup-full/main/$mimpi/$mimpi.zip | grep 404 | awk '{print $1}' | cut -d: -f1)
[[ "$cekdata" = "404" ]] && {
red "Data not found / you never backup"
exit 0
} || {
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[41;1;39m    ⇱ RESTORE DATA VPS ⇲      \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
#green "Data found for username ${NameUser}"
}
echo -e "[ ${green}INFO${NC} ] • Restore Data..."
read -rp "Password File: " -e InputPass
echo -e "[ ${green}INFO${NC} ] • Downloading data.."
mkdir /root/backup
wget -q -O /root/backup/backup.zip "https://raw.githubusercontent.com/cakill26/backup-full/main/$mimpi/$mimpi.zip" &> /dev/null
echo -e "[ ${green}INFO${NC} ] • Getting your data..."
unzip -P $InputPass /root/backup/backup.zip &> /dev/null
echo -e "[ ${green}INFO${NC} ] • Starting to restore data..."
rm -f /backup.zip &> /dev/null
sleep 1
echo Start Restore
cd /root/backup &> /dev/null
cp passwd /etc/ &> /dev/null
cp group /etc/ &> /dev/null
cp shadow /etc/ &> /dev/null
cp gshadow /etc/ &> /dev/null
cp -r wireguard /etc/ &> /dev/null
cp chap-secrets /etc/ppp/ &> /dev/null
cp passwd1 /etc/ipsec.d/passwd &> /dev/null
cp ss.conf /etc/shadowsocks-libev/ss.conf &> /dev/null
cp -r geovpnstore /var/lib/ &> /dev/null
cp -r sstp /home/ &> /dev/null
cp -r xray /etc/ &> /dev/null
cp -r trojan-go /etc/ &> /dev/null
cp -r shadowsocksr /usr/local/ &> /dev/null
cp -r public_html /home/vps/ &> /dev/null
cp crontab /etc/ &> /dev/null
strt &> /dev/null
rm -rf /root/backup &> /dev/null
rm -f backup.zip &> /dev/null
echo
echo -e "[ ${green}INFO${NC} ] • RESTORE DATA SUKSES..."
echo
read -n 1 -s -r -p "Press any key to back on menu"
system-menu
