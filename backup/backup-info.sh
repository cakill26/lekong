#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================

clear
IP=$(curl -sS ipv4.icanhazip.com);
date=$(date +"%Y-%m-%d")

MYIP=$(curl -sS ipv4.icanhazip.com)
#NameUser=$(curl -sS https://${Server_URLL}/validated-registered-license-key.txt | grep $MYIP | awk '{print $2}')
export NameUser=$( curl -s https://${Server_URLL}/validated-registered-license-key.txt | grep -w $Your_License_Key | cut -d ' ' -f 9-100 | awk '{print $1}' );

clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[41;1;39m        • BACKUP HISTORY •         \E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

data=$(curl -sS https://raw.githubusercontent.com/cakill26/backup-full/main/$NameUser/$NameUser-last-backup)
echo
echo -e "[ ${GREEN}INFO${NC} ] • Getting info database backup history..."
sleep 2
echo
echo -e "$data"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo
read -n 1 -s -r -p "Press any key to back on menu"
system-menu
