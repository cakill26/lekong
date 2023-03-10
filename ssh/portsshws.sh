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
# =========================================

#cek port dan tampilkan

ws="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"

#input port untuk pengganti
echo -e "======================================"
echo -e ""
echo -e "Change Port $ws"
echo -e ""
echo -e "======================================"
read -p "New Port SSH WS : " ws2
if [ -z $ws2 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $ws2)
if [[ -z $cek ]]; then


#ganti port layanan
sed -i "s/$ws/$ws2/g" /etc/default/sslh
sed -i "s/$ws/$ws2/g" /etc/stunnel/stunnel.conf
sed -i "s/   - Websocket TLS           : $ws/   - Websocket TLS           : $ws2/g" /root/log-install.txt

iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $ws -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $ws -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $ws2 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $ws2 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null


sed -i "s/$ws/$ws2/g" /etc/systemd/system/ws-stunnel.service
systemctl daemon-reload
systemctl restart sslh
systemctl restart ws-stunnel > /dev/null

#ganti port info

echo -e "\e[032;1mPort $ws2 modified successfully\e[0m"
else
echo "Port $ws2 is used"
fi



#done 
