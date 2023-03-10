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
GREEN_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && GREEN_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
chck_pid(){
	PID=`ps -ef |grep -v grep | grep xl2tpd |awk '{print $2}'`
	if [[ ! -z "${PID}" ]]; then
			echo -e "Current status: ${GREEN_font_prefix} Installed${Font_color_suffix} & ${GREEN_font_prefix}Running${Font_color_suffix}"
		else
			echo -e "Current status: ${GREEN_font_prefix} Installed${Font_color_suffix} but ${Red_font_prefix}Not Running${Font_color_suffix}"
		fi
}
check_pid(){
	PID=`ps -ef |grep -v grep | grep pptpd |awk '{print $2}'`
	if [[ ! -z "${PID}" ]]; then
			echo -e "Current status: ${GREEN_font_prefix} Installed${Font_color_suffix} & ${GREEN_font_prefix}Running${Font_color_suffix}"
		else
			echo -e "Current status: ${GREEN_font_prefix} Installed${Font_color_suffix} but ${Red_font_prefix}Not Running${Font_color_suffix}"
		fi
}
while true $x != "ok"
do
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[41;1;39m                  ⇱ VPN MENU ⇲                  \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
chck_pid
echo -e "
[\033[0;32m01\033[0m] • Create L2TP Account
[\033[0;32m02\033[0m] • Deleting L2TP Account
[\033[0;32m03\033[0m] • Extending L2TP Account Active Life

$CYAN ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
check_pid
echo -e "
[\033[0;32m04\033[0m] • Create PPTP Account
[\033[0;32m05\033[0m] • Deleting PPTP Account
[\033[0;32m06\033[0m] • Extending PPTP Account Active Life
[\033[0;32m07\033[0m] • Check User Login PPTP

[${GREEN}00${NC}] ${RED} •${color3}$bd Back to Main Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[41;1;39m               ⇱ GEOVPN PROJECT ⇲               \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -ne "Select menu : "; read x

case "$x" in 
   1 | 01)
   clear
   addl2tp
   break
   ;;
   2 | 02)
   clear
   dell2tp 
   break
   ;;
   3 | 03)
   clear
   renewl2tp
   break
   ;;
   4 | 04)
   clear
   addpptp
   break
   ;;
   5 | 05)
   clear
   delpptp
   break
   ;;
   6 | 06)
   clear
   renewpptp
   break
   ;;
   7 | 07)
   clear
   cekpptp
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