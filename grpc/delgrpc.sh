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
MYIP=$(curl -sS ipinfo.io/ip)
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/geo-vmessgrpc.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi
	
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/geo-vlessgrpc.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi
	
	clear
	echo ""
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^### " "/etc/xray/geo-vmessgrpc.json" | cut -d ' ' -f 2-3 | nl -s ') '
	grep -E "^### " "/etc/xray/geo-vlessgrpc.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^### " "/etc/xray/geo-vmessgrpc.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/geo-vmessgrpc.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
user=$(grep -E "^### " "/etc/xray/geo-vlessgrpc.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/geo-vlessgrpc.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/geo-vmessgrpc.json
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/geo-vlessgrpc.json
rm -f /etc/xray/$user-tls.json
systemctl restart geo-vmess-grpc.service
systemctl restart geo-vless-grpc.service
clear
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "  XRAY GRPC VMESS VLESS Account Deleted  "
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "Username  : $user"
echo "Expired   : $exp"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
