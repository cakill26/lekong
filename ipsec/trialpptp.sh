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
PPTPTrial=trial`</dev/urandom tr -dc A-Z0-9 | head -c4`
Hariii=1
Passss=1
source /var/lib/geovpnstore/ipvps.conf
if [[ "$IP" = "" ]]; then
PUBLIC_IP=$(curl -sS ifconfig.me);
else
PUBLIC_IP=$IP
fi

until [[ $PPTPTrial =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do

		CLIENT_EXISTS=$(grep -w $PPTPTrial /var/lib/geovpnstore/data-user-pptp | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done

exp=`date -d "$Hariii days" +"%Y-%m-%d"`
clear

# Add or update VPN user
cat >> /etc/ppp/chap-secrets <<EOF
"$PPTPTrial" pptpd "$Passss" *
EOF

# Update file attributes
chmod 600 /etc/ppp/chap-secrets*
echo -e "### $PPTPTrial $exp">>"/var/lib/geovpnstore/data-user-pptp"
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"		
echo -e "\E[44;1;39m       ⇱ Trial PPTP Account ⇲      \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"		
echo -e ""
echo -e "Server IP : $PUBLIC_IP"
echo -e "Username : $PPTPTrial"
echo -e "Password : $Passss"
echo -e "Expired On : $exp"
echo -e ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"		
echo ""
read -n 1 -s -r -p "Press any key to back on menu"

ipsec-menu