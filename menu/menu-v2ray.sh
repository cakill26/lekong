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
echo -e "\E[41;1;39m                     ⇱ XRAY MENU ⇲              \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
rekk='Xray'
echo -e "
[${GREEN}01${NC}] ${color1}•${NC} Create $rekk Vmess Websocket Account
[${GREEN}02${NC}] ${color1}•${NC} Deleting $rekk Vmess Websocket Account
[${GREEN}03${NC}] ${color1}•${NC} Extending $rekk Vmess Account Active Life
[${GREEN}04${NC}] ${color1}•${NC} Check User Login $rekk

${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}

[${GREEN}05${NC}] ${color1}•${NC} Create $rekk Vless Websocket Account
[${GREEN}06${NC}] ${color1}•${NC} Deleting $rekk Vless Websocket Account
[${GREEN}07${NC}] ${color1}•${NC} Extending $rekk Vless Account Active Life
[${GREEN}08${NC}] ${color1}•${NC} Check User Login $rekk

${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}

[${GREEN}09${NC}] ${color1}•${NC} Create $rekk Grpc Account
[${GREEN}10${NC}] ${color1}•${NC} Deleting $rekk Grpc Account
[${GREEN}11${NC}] ${color1}•${NC} Extending $rekk Grpc Account
[${GREEN}12${NC}] ${color1}•${NC} Chek User Login Grpc

[${GREEN}00${NC}] ${color1}• ${NC}Kembali Ke Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[41;1;39m                  ⇱ GEOVPN PROJECT ⇲            \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e""
read -p " Select menu :  "  v2ray
echo -e ""
case $v2ray in
1 |01)
addv2ray
;;
2 |02)
delv2ray
;;
3 |03)
renewv2ray
;;
4 |04)
cekv2ray
;;
5 |05)
addvless
;;
6 |06)
delvless
;;
7 |07)
renewvless
;;
8 |08)
cekvless
;;
9 | 09)
addgrpc
;;
10 |10)
delgrpc
;;
11 |11)
renewgrpc
;;
12 | 12)
cekgrpc
;;
0 | 00)
menu
;;
*)
menu-v2ray
;;
esac
