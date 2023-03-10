#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

BURIQ () {
    curl -sS https://raw.githubusercontent.com/geovpn/perizinan/main/main/allow > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipinfo.io/ip)
Name=$(curl -sS https://raw.githubusercontent.com/geovpn/perizinan/main/main/allow | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipinfo.io/ip)
    IZIN=$(curl -sS https://raw.githubusercontent.com/geovpn/perizinan/main/main/allow | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[1;32m'
yl='\033[1;33m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION

if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi

cekray=`cat /root/log-install.txt | grep -ow "XRAY" | sort | uniq`
if [ "$cekray" = "XRAY" ]; then
raycheck='xray'
fi

systemctl is-active --quiet ssh && stsssh="${green}Running${NC}" || stsssh="${red}Not Running${NC}"
systemctl is-active --quiet stunnel5 && stsstn="${green}Running${NC}" || stsstn="${red}Not Running${NC}"
systemctl is-active --quiet dropbear && stsdb="${green}Running${NC}" || stsdb="${red}Not Running${NC}"
systemctl is-active --quiet xray@v2ray-tls && stsray="${green}Running${NC}" || stsray="${red}Not Running${NC}"
systemctl is-active --quiet xray@v2ray-nontls && sstsray="${green}Running${NC}" || sstsray="${red}Not Running${NC}"
systemctl is-active --quiet trojan-go && ststrgo="${green}Running${NC}" || ststrgo="${red}Not Running${NC}"
systemctl is-active --quiet wg-quick@wg0 && stswg="${green}Running${NC}" || stswg="${red}Not Running${NC}"
systemctl is-active --quiet shadowsocks-libev && stsss="${green}Running${NC}" || stsss="${red}Not Running${NC}"
systemctl is-active --quiet ssrmu && stsssr="${green}Running${NC}" || stsssr="${red}Not Running${NC}"
systemctl is-active --quiet accel-ppp && stssstp="${green}Running${NC}" || stssstp="${red}Not Running${NC}"
systemctl is-active --quiet pptpd && stspptp="${green}Running${NC}" || stspptp="${red}Not Running${NC}"
systemctl is-active --quiet xl2tpd && stsl2tp="${green}Running${NC}" || stsl2tp="${red}Not Running${NC}"
systemctl is-active --quiet ws-tls && swstls="${green}Running${NC}" || swstls="${red}Not Running${NC}"
systemctl is-active --quiet ws-nontls && swsnontls="${green}Running${NC}" || swsnontls="${red}Not Running${NC}"
systemctl is-active --quiet ws-ovpn && swsovpn="${green}Running${NC}" || swsovpn="${red}Not Running${NC}"

stop() {
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "
[${green} 1${NC}] Stop Stunnel
[${green} 2${NC}] Stop Wireguard
[${green} 3${NC}] Stop L2TP
[${green} 4${NC}] Stop PPTP
[${green} 5${NC}] Stop SSTP
[${green} 6${NC}] Stop SSR
[${green} 7${NC}] Stop ShadowSocks
[${green} 8${NC}] Stop Xray Vmess TLS
[${green} 9${NC}] Stop Xray Vmess non TLS
[${green}10${NC}] Stop TrojanGo
[${green}11${NC}] Stop SSH ws TLS
[${green}12${NC}] Stop SSH ws non TLS
[${green}13${NC}] Stop SSH ws OpenVPN
"
read -rp "Input Number : " -e num
if [[ "$num" = "1" ]]; then
systemctl disable stunnel4 >/dev/null 2>&1
systemctl stop stunnel4 >/dev/null 2>&1
elif [[ "$num" = "2" ]]; then
systemctl disable wg-quick@wg0 >/dev/null 2>&1
systemctl stop wg-quick@wg0 >/dev/null 2>&1
elif [[ "$num" = "3" ]]; then
systemctl disable xl2tpd >/dev/null 2>&1
systemctl stop xl2tpd >/dev/null 2>&1
elif [[ "$num" = "4" ]]; then
systemctl disable pptpd >/dev/null 2>&1
systemctl stop pptpd >/dev/null 2>&1
elif [[ "$num" = "5" ]]; then
systemctl disable accel-ppp >/dev/null 2>&1
systemctl stop accel-ppp >/dev/null 2>&1
elif [[ "$num" = "6" ]]; then
systemctl disable ssrmu >/dev/null 2>&1
systemctl stop ssrmu >/dev/null 2>&1
elif [[ "$num" = "7" ]]; then
systemctl disable shadowsocks-libev >/dev/null 2>&1
systemctl stop shadowsocks-libev >/dev/null 2>&1
elif [[ "$num" = "8" ]]; then
systemctl disable xray@v2ray-tls >/dev/null 2>&1
systemctl stop xray@v2ray-tls >/dev/null 2>&1
elif [[ "$num" = "9" ]]; then
systemctl disable xray@v2ray-nontls >/dev/null 2>&1
systemctl stop xray@v2ray-nontls >/dev/null 2>&1
elif [[ "$num" = "10" ]]; then
systemctl disable trojan-go >/dev/null 2>&1
systemctl stop trojan-go >/dev/null 2>&1
elif [[ "$num" = "11" ]]; then
systemctl disable ws-tls >/dev/null 2>&1
systemctl stop ws-tls >/dev/null 2>&1
elif [[ "$num" = "12" ]]; then
systemctl disable ws-nontls >/dev/null 2>&1
systemctl stop ws-nontls >/dev/null 2>&1
elif [[ "$num" = "13" ]]; then
systemctl disable ws-ovpn >/dev/null 2>&1
systemctl stop ws-ovpn >/dev/null 2>&1
else
menu
fi
}

start() {
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "
[${green} 1${NC}] Start Stunnel
[${green} 2${NC}] Start Wireguard
[${green} 3${NC}] Start L2TP
[${green} 4${NC}] Start PPTP
[${green} 5${NC}] Start SSTP
[${green} 6${NC}] Start SSR
[${green} 7${NC}] Start ShadowSocks
[${green} 8${NC}] Start Xray Vmess TLS
[${green} 9${NC}] Start Xray Vmess non TLS
[${green}10${NC}] Start TrojanGo
[${green}11${NC}] Start SSH ws TLS
[${green}12${NC}] Start SSH ws non TLS
[${green}13${NC}] Start SSH ws OpenVPN
"
read -rp "Input Number : " -e num
if [[ "$num" = "1" ]]; then
systemctl enable stunnel4 >/dev/null 2>&1
systemctl start stunnel4 >/dev/null 2>&1
elif [[ "$num" = "2" ]]; then
systemctl enable wg-quick@wg0 >/dev/null 2>&1
systemctl start wg-quick@wg0 >/dev/null 2>&1
elif [[ "$num" = "3" ]]; then
systemctl enable xl2tpd >/dev/null 2>&1
systemctl start xl2tpd >/dev/null 2>&1
elif [[ "$num" = "4" ]]; then
systemctl enable pptpd >/dev/null 2>&1
systemctl start pptpd >/dev/null 2>&1
elif [[ "$num" = "5" ]]; then
systemctl enable accel-ppp >/dev/null 2>&1
systemctl start accel-ppp >/dev/null 2>&1
elif [[ "$num" = "6" ]]; then
systemctl enable ssrmu >/dev/null 2>&1
systemctl start ssrmu >/dev/null 2>&1
elif [[ "$num" = "7" ]]; then
systemctl enable shadowsocks-libev >/dev/null 2>&1
systemctl start shadowsocks-libev >/dev/null 2>&1
elif [[ "$num" = "8" ]]; then
systemctl enable xray@v2ray-tls >/dev/null 2>&1
systemctl start xray@v2ray-tls >/dev/null 2>&1
elif [[ "$num" = "9" ]]; then
systemctl enable xray@v2ray-tls >/dev/null 2>&1
systemctl start xray@v2ray-nontls >/dev/null 2>&1
elif [[ "$num" = "10" ]]; then
systemctl enable trojan-go >/dev/null 2>&1
systemctl start trojan-go >/dev/null 2>&1
elif [[ "$num" = "11" ]]; then
systemctl enable ws-tls >/dev/null 2>&1
systemctl start ws-tls >/dev/null 2>&1
elif [[ "$num" = "12" ]]; then
systemctl enable ws-nontls >/dev/null 2>&1
systemctl start ws-nontls >/dev/null 2>&1
elif [[ "$num" = "13" ]]; then
systemctl enable ws-ovpn >/dev/null 2>&1
systemctl start ws-ovpn >/dev/null 2>&1
else
menu
fi
}

clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m      ⇱ Service ALL Status ⇲      \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "
❇️ SSH & VPN                : $stsssh
❇️ STUNNEL                  : $stsstn
❇️ WIREGUARD                : $stswg
❇️ L2TP                     : $stsl2tp
❇️ PPTP                     : $stspptp
❇️ SSTP                     : $stssstp
❇️ SSR                      : $stsssr
❇️ ShadowSocks              : $stsss"
if [ "xray@v2ray-tls" != "xray" ]; then
echo -e "❇️ V2RAY TLS                : $stsray"
fi
if [ "xray@v2ray-nontls" != "xray" ]; then
echo -e "❇️ V2RAY non TLS            : $sstsray"
fi
echo -e "❇️ TROJAN-GO                : $ststrgo
❇️ WS TLS                   : $swstls
❇️ WS non TLS               : $swsnontls
❇️ WS OpenVPN               : $swsovpn
"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -e "[${green}1${NC}] Turn Off Service"
echo -e "[${green}2${NC}] Turn On Service"
echo
read -rp "Input Number : " -e num
if [[ "$num" = "1" ]]; then
stop
elif [[ "$num" = "2" ]]; then
start
else
clear
menu
fi
read -n 1 -s -r -p "Press any key to back on menu"
menu
