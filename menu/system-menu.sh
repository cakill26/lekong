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

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[41;1;39m             ⇱ SystemAdmin MENU ⇲               \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "
[${GREEN}01${NC}] ${color1}•${NC} Backup Data VPS
[${GREEN}02${NC}] ${color1}•${NC} Restore Data VPS
[${GREEN}03${NC}] ${color1}•${NC} Webmin Menu
[${GREEN}04${NC}] ${color1}•${NC} Check Ram VPS
[${GREEN}05${NC}] ${color1}•${NC} Reboot VPS
[${GREEN}06${NC}] ${color1}•${NC} Speedtest VPS
[${GREEN}07${NC}] ${color1}•${NC} Backup Info VPS

[${GREEN}00${NC}] ${color1} •${color3}$bd Back to Main Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[41;1;39m               ⇱ GEOVPN PROJECT ⇲               \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo ""
echo -ne "Select menu : "; read x

case "$x" in
   1 | 01)
   clear
   backup
   ;;
   2 | 02)
   clear
   restore
   ;;
   3 | 03)
   clear
   wbmn
   ;;
   4 | 04)
   clear
   ram
   read -n 1 -s -r -p "Press any key to back on menu"
   system-menu
   ;;
   5 | 05)
   clear
   reboot
   ;;
   6 | 06)
   clear
   speedtest
   ;;
   7 | 07)
   clear
   backup-info
   read -n 1 -s -r -p "Press any key to back on menu"
   system-menu
   ;;
   0 | 00)
   clear
   menu
   ;;
   *)
   system-menu
esac

#fim