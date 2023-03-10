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
IP=$(curl -sS ipinfo.io/ip);
date=$(date +"%Y-%m-%d")
export NameUser=$( curl -s https://${Server_URLL}/validated-registered-license-key.txt | grep -w $Your_License_Key | cut -d ' ' -f 9-100 | awk '{print $1}' );
rsleep=$((1 + $RANDOM % 10))

echo -e "[ ${green}INFO${NC} ] Wait $rsleep minutes "
sleep ${rsleep}m
cp -r /root/.acme.sh /root/backup/ &> /dev/null
cp /etc/passwd /root/backup/ &> /dev/null
cp /etc/group /root/backup/ &> /dev/null
cp /etc/shadow /root/backup/ &> /dev/null
cp /etc/gshadow /root/backup/ &> /dev/null
cp -r /etc/wireguard /root/backup/wireguard &> /dev/null
cp /etc/ppp/chap-secrets /root/backup/chap-secrets &> /dev/null
cp /etc/ipsec.d/passwd /root/backup/passwd1 &> /dev/null
cp /etc/shadowsocks-libev/akun.conf /root/backup/ss.conf &> /dev/null
cp -r /var/lib/geovpnstore/ /root/backup/geovpnstore &> /dev/null
cp -r /home/sstp /root/backup/sstp &> /dev/null
cp -r /etc/v2ray /root/backup/v2ray &> /dev/null
cp -r /etc/xray /root/backup/xray &> /dev/null
cp -r /etc/trojan-go /root/backup/trojan-go &> /dev/null
cp -r /usr/local/shadowsocksr/ /root/backup/shadowsocksr &> /dev/null
cp -r /home/vps/public_html /root/backup/public_html &> /dev/null
cp -r /etc/cron.d /root/backup/cron.d &> /dev/null
cp /etc/crontab /root/backup/crontab &> /dev/null
cd /root
source /root/zippass
password=$password
zip -rP $password $NameUser.zip backup > /dev/null 2>&1

##############++++++++++++++++++++++++#############
LLatest=`date`
Get_Data () {
git clone https://github.com/cakill26/backup-full.git /root/backup-full/ &> /dev/null
}

Mkdir_Data () {
mkdir -p /root/GEO-PROJECT-BACKUP/$NameUser
}

Input_Data_Append () {
if [ ! -f "/root/backup-full/$NameUser/$NameUser-last-backup" ]; then
touch /root/backup-full/$NameUser/$NameUser-last-backup
fi
echo -e "User         : $NameUser
last-backup : $LLatest
" >> /root/backup-full/$NameUser/$NameUser-last-backup
mv /root/$NameUser.zip /root/backup-full/$NameUser/
}

Save_And_Exit () {
    cd /root/backup-full
    git config --global user.email "ambebalong@gmail.com" &> /dev/null
    git config --global user.name "cakill26" &> /dev/null
    rm -rf .git &> /dev/null
    git init &> /dev/null
    git add . &> /dev/null
    git commit -m m &> /dev/null
    git branch -M main &> /dev/null
    git remote add origin https://github.com/cakill26/backup-full.git
    git push -f https://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@github.com/cakill26/backup-full.git &> /dev/null
}

if [ ! -d "/root/backup-full/" ]; then
sleep 1
echo -e "[ ${green}INFO${NC} ] Getting database... "
Get_Data
Mkdir_Data
sleep 1
echo -e "[ ${green}INFO${NC} ] Getting info server... "
Input_Data_Append
sleep 1
echo -e "[ ${green}INFO${NC} ] Processing updating server...... "
Save_And_Exit
fi
link="https://raw.githubusercontent.com/cakill26/backup-full/main/$NameUser/$NameUser.zip"
sleep 1
echo -e "[ ${green}INFO${NC} ] Backup done "
sleep 1
echo -e "[ ${green}INFO${NC} ] Generete Link Backup "
echo
sleep 2
rm /root/linkbackup &> /dev/null
echo -e "$link" >> /root/linkbackup
echo -e "The following is a link to your vps data backup file.
Your VPS IP $IP

$link
save the link pliss!

If you want to restore data, go to vps menu system
select Restore Data VPS. Enter you backup password $password .
Thank You For Using Our Services"

rm -rf /root/backup &> /dev/null
rm -rf /root/backup-full &> /dev/null
rm -f /root/$NameUser.zip &> /dev/null
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"