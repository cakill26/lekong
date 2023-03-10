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
echo start
source /var/lib/geovpnstore/ipvps.conf
domain=$(cat /etc/xray/domain)
echo -e "[ ${GREEN}INFO${NC} ] Start " 
sleep 1
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by ws-nontls" 
systemctl stop xray@v2ray-nontls
sleep 2
echo -e "[ ${GREEN}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${GREEN}INFO${NC} ] Starting renew cert... " 
sleep 2
echo -e "[ ${GREEN}INFO$NC ] Getting acme for cert"
wget cakill26.github.io/lekong/ambe/acme.sh >/dev/null 2>&1
bash acme.sh --install >/dev/null 2>&1
bash acme.sh --register-account -m admin@geolstore.net
wget https://get.acme.sh >/dev/null 2>&1 | sh -s email=admin@geolstore.net
/root/.acme.sh/acme.sh --upgrade --auto-upgrade >/dev/null 2>&1
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt >/dev/null 2>&1
/root/.acme.sh/acme.sh --issue -d $domain --standalone --force --keylength ec-256
/root/.acme.sh/acme.sh --installcert -d $domain --ecc --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key
echo ""
systemctl start xray@v2ray-nontls
systemctl restart xray@v2ray-nontls
sleep 5
rm acme.sh >/dev/null 2>&1
echo -e "[ ${GREEN}INFO${NC} ] Renew cert done... "
restart
