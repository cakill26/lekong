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
IP=$(curl -sS ifconfig.me);
sstp="$(cat ~/log-install.txt | grep -i SSTP | cut -d: -f2|sed 's/ //g')"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m       ⇱ Add SSTP Account ⇲        \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Usernew: " -e user
		CLIENT_EXISTS=$(grep -w $user /var/lib/geovpnstore/data-user-sstp | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "Password: " pass
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
cat >> /home/sstp/sstp_account <<EOF
$user * $pass *
EOF
echo -e "### $user $exp">>"/var/lib/geovpnstore/data-user-sstp"
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "\E[44;1;39m       ⇱ Add SSTP Account ⇲        \E[0m" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "Server IP : $IP" | tee -a /etc/log-create-user.log
echo -e "Username : $user" | tee -a /etc/log-create-user.log
echo -e "Password : $pass" | tee -a /etc/log-create-user.log
echo -e "Port : $sstp" | tee -a /etc/log-create-user.log
echo -e "Cert : http://$IP:81/server.crt" | tee -a /etc/log-create-user.log
echo -e "Expired On : $exp" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"

sstp-menu