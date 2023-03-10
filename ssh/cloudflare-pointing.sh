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
if [ ! -f "/etc/cf.conf" ]; then
echo "No setting found for ID and Email cloudflare"
sleep 2
read -n 1 -s -r -p "Press any key to settings"
sleep 1
echo ""
read -e -p "[*] Input your Domain : " domain
read -e -p "[*] Input your Email Cloudflare :" email
read -e -p "[*] Input your Api Key Cloudflare :" key
echo -e "domain=$domain" > /etc/cf.conf
echo -e "email=$email" >> /etc/cf.conf
echo -e "key=$key" >> /etc/cf.conf
clear
echo "Done"
echo "Your ID Cloudflare"
echo -e "==============================="
echo "DOMAIN         : $domain"
echo "Email          : $email"
echo "Api Key        : $key"
echo -e "==============================="
echo "Setting done ✓ now open this menu again"
exit
fi

    source /etc/cf.conf
    DOMAIN=$domain
    CF_ID=$email
    CF_KEY=$key
    set -euo pipefail
    green "Setting found..."
    echo ""
    read -p "Input your Subdomain :" sub
    read -p "Input your IP BUG :" IP
    echo "Updating DNS for ${sub}..."
    ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
         -H "X-Auth-Email: ${CF_ID}" \
         -H "X-Auth-Key: ${CF_KEY}" \
         -H "Content-Type: application/json" | jq -r .result[0].id)
    
    RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${sub}" \
         -H "X-Auth-Email: ${CF_ID}" \
         -H "X-Auth-Key: ${CF_KEY}" \
         -H "Content-Type: application/json" | jq -r .result[0].id)
    
    if [[ "${#RECORD}" -le 10 ]]; then
         RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
         -H "X-Auth-Email: ${CF_ID}" \
         -H "X-Auth-Key: ${CF_KEY}" \
         -H "Content-Type: application/json" \
         --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
    fi
    
    RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
         -H "X-Auth-Email: ${CF_ID}" \
         -H "X-Auth-Key: ${CF_KEY}" \
         -H "Content-Type: application/json" \
         --data '{"type":"A","name":"'${sub}'","content":"'${IP}'","ttl":120,"proxied":false}')
    echo "DONE...!"
