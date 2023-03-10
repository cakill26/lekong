#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================

clear
#echo -n /var/log/xray/access.log
echo -n > /tmp/other.txt
data=( `cat /etc/xray/v2ray-tls.json | grep '^###' | cut -d ' ' -f 2`);

#echo -e "\033[0;34m┌─────────────────────────┐${NC}"
#echo -e "\033[0;34m│$NC\E[41;1;39m     VMESS USER LOGIN    \E[0m\033[0;34m│"
#echo -e "\033[0;34m└─────────────────────────┘${NC}"
echo "-----------------------------------------";
echo "---------=[ Vmess User Login ]=----------";
echo "-----------------------------------------";

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/v2ray-login.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/v2ray-login.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo ""
echo "user : "
#echo -e "\033[0;34m┌─────────────────────────┐${NC}"
echo -e "     $GREEN $akun $NC"
echo -e "$jum2";
#echo -e "\033[0;34m└─────────────────────────┘${NC}"
echo "-----------------------------------------";
fi
rm -rf /tmp/ipvmess.txt
done

rm -rf /tmp/other.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"

menu-v2ray
