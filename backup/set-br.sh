#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================

clear

apt install rclone -y
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "https://${Server_URL}/backup/rclone.conf" >/dev/null 2>&1
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
echo > /home/limit
apt install msmtp-mta ca-certificates bsd-mailx -y
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user paoandest@gmail.com
from paoandest@gmail.com
password 37373737 
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc
cd /usr/local/sbin
wget -O autobackup "https://${Server_URL}/backup/autobackup.sh" >/dev/null 2>&1
wget -O backup "https://${Server_URL}/backup/backup.sh" >/dev/null 2>&1
wget -O restore "https://${Server_URL}/backup/restore.sh" >/dev/null 2>&1
wget -O strt "https://${Server_URL}/backup/strt.sh" >/dev/null 2>&1
wget -O limitspeed "https://${Server_URL}/backup/limitspeed.sh" >/dev/null 2>&1
wget -O autobackup-setup "https://${Server_URL}/backup/autobackup-setup.sh" >/dev/null 2>&1
wget -O backup-info "https://${Server_URL}/backup/backup-info.sh" >/dev/null 2>&1
wget -O backup2 "https://${Server_URL}/backup/backup2.sh" >/dev/null 2>&1
wget -O restore2 "https://${Server_URL}/backup/restore2.sh" >/dev/null 2>&1
chmod +x autobackup-setup >/dev/null 2>&1
chmod +x backup-info >/dev/null 2>&1
chmod +x autobackup >/dev/null 2>&1
chmod +x backup >/dev/null 2>&1
chmod +x restore >/dev/null 2>&1
chmod +x strt >/dev/null 2>&1
chmod +x limitspeed >/dev/null 2>&1
chmod +x backup2 >/dev/null 2>&1
chmod +x restore2 >/dev/null 2>&1
cd
rm -f /root/set-br.sh