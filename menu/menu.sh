#!/bin/bash
# Menu For Script
# Edition : Stable Edition V3.0
# =========================================

# // Clear
clear
clear && clear && clear
clear;clear;clear

clear
# TOTAL ACC CREATE VMESS WS
vmess=$(grep -c -E "^### " "/etc/xray/v2ray-tls.json")
# TOTAL ACC CREATE  VLESS WS
vless=$(grep -c -E "^### " "/etc/xray/vless-tls.json")
# TOTAL ACC CREATE  TROJAN WS TLS
trws=$(grep -c -E "^### " "/etc/xray/trojan.json")
shadow=$(grep -c -E "^### " "/etc/shadowsocks-libev/akun.conf")
# TOTAL ACC CREATE OVPN SSH
total_ssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo""
echo -e "${YELLOW}--------------------------------------------------------------${NC}"
echo -e "  Welcome To ${GREEN}Geo Project ${NC}Script Installer ${YELLOW}(${NC}${GREEN} Stable Edition ${NC}${YELLOW})${NC}"
echo -e "     This Will Quick Setup VPN Server On Your Server"
echo -e "         Auther : ${GREEN}MUHAMMAD AMIN ${NC}${YELLOW}(${NC} ${GREEN}Geo Project ${NC}${YELLOW})${NC}"
echo -e "       © Copyright By Geo Project ${YELLOW}(${NC} 2021-2022 ${YELLOW})${NC}"
echo -e "${YELLOW}-------------------------------------------------------------${NC}"
echo ""
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│$NC\E[41;1;39m                 VPS / System Information                  \E[0m\033[0;34m│"
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│$NC Sever Uptime         ${RED} •${NC} $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "\033[0;34m│$NC Current Time         ${RED} •${NC} $( date -d "0 days" +"%d-%m-%Y | %X" )"
echo -e "\033[0;34m│$NC Operating System     ${RED} •${NC} $( cat /etc/os-release | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) )"
echo -e "\033[0;34m│$NC Total Amount Of Ram  ${RED} •${NC} $tram MB"
echo -e "\033[0;34m│$NC Current Domain       ${RED} •${NC} $( cat /etc/xray/domain )"
echo -e "\033[0;34m│$NC Server IP            ${RED} •${NC} ${IP}"
echo -e "\033[0;34m│$NC License Key Status   ${RED} •${NC} ${Status_License}"
#echo -e "\033[0;34m│$NC License Type         ${RED} •${NC} ${License_Mode} Edition"
echo -e "\033[0;34m│$NC License Issued to    ${RED} •${NC} ${Issue_License}"
echo -e "\033[0;34m│$NC License Start        ${RED} •${NC} ${Start_License}"
echo -e "\033[0;34m│$NC License Limit        ${RED} •${NC} ${Limit_License} VPS"
echo -e "\033[0;34m│$NC License Expired      ${RED} •${NC} ${End_License} (${GREEN} $(if [[ ${Sisa_Hari_Masa_Aktif} -lt 5 ]]; then
echo -e "\033[0;34m│$NC ${RED}${Sisa_Hari_Masa_Aktif} Days Left ${NC}"; else
echo -e "\033[0;34m$NC${GREEN}${Sisa_Hari_Masa_Aktif} Days Left"; fi
)${NC} )"
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│     $NC${YELLOW} Ssh/Ovpn   V2ray   Vless   Shadwsock   Trojan $NC "    
echo -e "\033[0;34m│        $NC${BIWhite} $total_ssh         $vmess       $vless        $shadow         $trws    \e[0m "
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│$NC\E[41;1;39m                   ⇱ DASHBOARD MENU ⇲                      \E[0m\033[0;34m│"
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│$NC[${GREEN}01${NC}]${RED} •${NC} SSH & OPENVPN (${GREEN}menu-ssh${NC})$NC"
echo -e "\033[0;34m│$NC[${GREEN}02${NC}]${RED} •${NC} SSTP - L2TP - PPTP - WIREGUARD (${GREEN}menu-vpn${NC})$NC"
echo -e "\033[0;34m│$NC[${GREEN}03${NC}]${RED} •${NC} SHADOWSOCKS & SHADOWSOCKSR (${GREEN}menu-shadowsocks${NC})$NC"
echo -e "\033[0;34m│$NC[${GREEN}04${NC}]${RED} •${NC} V2RAY VMESS & V2RAY VLESS (${GREEN}menu-v2ray${NC})$NC"
echo -e "\033[0;34m│$NC[${GREEN}05${NC}]${RED} •${NC} TROJAN & TROJANGO (${GREEN}menu-trojan${NC})$NC"
echo -e "\033[0;34m│$NC[${GREEN}06${NC}]${RED} •${NC} TRIAL ACCOUNT (${GREEN}menu-trial${NC})$NC"
echo -e "\033[0;34m│$NC[${GREEN}07${NC}]${RED} •${NC} SHOW LOG CREATE ACCOUNT (${GREEN}Show Log${NC}) $NC"
echo -e "\033[0;34m│$NC[${GREEN}08${NC}]${RED} •${NC} STATUS RUNNING SERVICE (${GREEN}running${NC}) $NC"
echo -e "\033[0;34m│$NC[${GREEN}09${NC}]${RED} •${NC} SETTING MENU (${GREEN}setting-menu${NC}) $NC"
echo -e "\033[0;34m│$NC[${GREEN}10${NC}]${RED} •${NC} SYSTEM MENU (${GREEN}system-menu${NC}) $NC"
echo -e "\033[0;34m│$NC"
echo -e "\033[0;34m│$NC[${GREEN}00${NC}]${RED} •${NC} BACK TO EXIT MENU \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│$NC\E[41;1;39m                   ⇱ GEOVPN PROJECT ⇲                      \E[0m\033[0;34m│"
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e  ""
read -p "Select menu :  " menu
echo -e   ""
case $menu in
1 | 01)
menu-ssh
;;
2 | 02)
menu-vpn
;;
3 | 03)
menu-shadowsocks
;;
4 | 04)
menu-v2ray
;;
5 | 05)
menu-trojan
;;
6 | 06)
menu-trial
;;
7 | 07)
cat /etc/log-create-user.log
;;
8 | 08)
running
;;
9 | 09)
setting-menu
;;
10)
system-menu
;;
0 | 00)
exit
;;
*)
menu
;;
esac
