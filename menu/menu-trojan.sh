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
x="ok"
cekray=`cat /root/log-install.txt | grep -ow "XRAY" | sort | uniq`
if [ "$cekray" = "XRAY" ]; then
kjj='xray'
else
kjj='v2ray'
fi
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
chck_pid(){
	PID=`ps -ef |grep -v grep | grep $kjj |awk '{print $2}'`
	if [[ ! -z "${PID}" ]]; then
			echo -e "Current status: ${Green_font_prefix} Installed${Font_color_suffix} & ${Green_font_prefix}Running${Font_color_suffix}"
		else
			echo -e "Current status: ${Green_font_prefix} Installed${Font_color_suffix} but ${Red_font_prefix}Not Running${Font_color_suffix}"
		fi
}

chgck_pid(){
	PID=`ps -ef |grep -v grep | grep trojan-go |awk '{print $2}'`
	if [[ ! -z "${PID}" ]]; then
			echo -e "Current status: ${Green_font_prefix} Installed${Font_color_suffix} & ${Green_font_prefix}Running${Font_color_suffix}"
		else
			echo -e "Current status: ${Green_font_prefix} Installed${Font_color_suffix} but ${Red_font_prefix}Not Running${Font_color_suffix}"
		fi
}

while true $x != "ok"
do

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[41;1;39m                    ⇱ TROJAN MENU ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
chck_pid
echo -e "
[${GREEN}01${NC}] ${color1}•${NC} Create Trojan-GFW Account
[${GREEN}02${NC}] ${color1}•${NC} Deleting Trojan-GFW Account
[${GREEN}03${NC}] ${color1}•${NC} Extending Trojan-GFW Account Active Life
[${GREEN}04${NC}] ${color1}•${NC} Check User Login Trojan-GFW

${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
chgck_pid
echo -e "
[${GREEN}05${NC}] ${color1}•${NC} Create Trojan-GO Account
[${GREEN}06${NC}] ${color1}•${NC} Deleting Trojan-GO Account
[${GREEN}07${NC}] ${color1}•${NC} Extending Trojan-GO Account Active Life
[${GREEN}08${NC}] ${color1}•${NC} Check User Login Trojan-GO

[${GREEN}00${NC}] ${color1}• ${NC}Kembali Ke Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[41;1;39m                  ⇱ GEOVPN PROJECT ⇲            \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -ne "Select menu : "; read x

case "$x" in 
   1 | 01)
   clear
   addtrojan
   break
   ;;
   2 | 02)
   clear
   deltrojan
   break
   ;;
   3 | 03)
   clear
   renewtrojan
   break
   ;;
   4 | 04)
   clear
   cektrojan
   break
   ;;
   5 | 05)
   clear
   addtrgo
   break
   ;;
   6 | 06)
   clear
   deltrgo
   break
   ;;
   7 | 07)
   clear
   renewtrgo
   break
   ;;
   8 | 08)
   clear
   cektrgo
   break
   ;;
   0 | 00)
   clear
   menu
   break
   ;;
   *)
   clear
esac
done
#fim
