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
echo -e ""
toilet --gay -f slant -t " Start Service"
sleep 2
#systemctl restart shadowsocks-libev-server@tls
#systemctl restart shadowsocks-libev-server@http
/etc/init.d/ssrmu restart
systemctl restart ssrmu
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/openvpn restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
/etc/init.d/squid restart
/etc/init.d/xl2tpd restart
/etc/init.d/pptpd restart
/etc/init.d/accel-ppp restart
/etc/init.d/shadowsocks-libev restart
systemctl restart ws-nontls
#systemctl restart ws-openssh.service
systemctl restart ws-ovpn
systemctl restart ws-tls
systemctl restart xray@v2ray-tls
systemctl restart xray@v2ray-nontls
systemctl restart xray@vless-tls
systemctl restart xray@vless-nontls
systemctl restart xray@trojan
systemctl restart shadowsocks-libev
systemctl restart xl2tpd
systemctl restart pptpd
systemctl restart ipsec
systemctl restart accel-ppp
systemctl restart wg-quick@wg0
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp
systemctl restart trojan-go
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
clear
echo -e "Restart All Service" | lolcat
sleep 2
figlet -f slant SUKSES | lolcat
echo -e ""
running
