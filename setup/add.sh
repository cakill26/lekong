#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
Lyellow='\e[93m'
bd='\e[1m'
clear
git clone https://github.com/geovpn/perizinan.git 
chmod +x /root/perizinan/main/allow
clear
rm -f /root/add
rm -f /root/add.1
rm -f /root/add.2
rm -f /root/add.3
rm -f /root/add.4
rm -f /root/add.5
rm -f /root/add.6
rm -f /root/add.7
rm -f /root/add.8
rm -f /root/add.9
rm -f /root/add.10
echo -e "${GREEN}Input IP${NC} "
echo -e ""
read -e -p "( IP VPS ):" user
CLIENT_EXISTS=$(grep -w $user /root/perizinan/main/allow | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
echo ""
echo -e "\e[33m VPS SUDAH TERDAFTAR SAYANG.\033[0m"
exit 1
fi
echo -e ""
read -p "User Client : " client
echo -e ""
read -p "Expired (days): " masaaktif
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
#exp=`date -d "$masaaktif days" +"%d-%m-%Y"`
cd /root/perizinan
echo -e "\n"| $client &> /dev/null
subb=""$(</dev/urandom tr -dc 0-9 | head -c3)
echo -e "### $client$subb $exp $user" >> /root/perizinan/main/allow
git config --global user.email "geogabut1981@gmail.com" &> /dev/null
git config --global user.name "geovpn" &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
git add . &> /dev/null
git commit -m m &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/geovpn/perizinan.git
git push -f https://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@github.com/geovpn/perizinan.git &> /dev/null
clear
echo -e ""
rm -f -r /root/perizinan
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[41;1;39m • Your IP Has Been Registered •\E[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "Client     : $client$subb"
echo "IP         : $user"
echo "CREATE ON  : $masaaktif Hari"
echo "Expired ON : $exp"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e ""