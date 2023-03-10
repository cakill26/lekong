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
read -p "Username : " User
egrep "^$User" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "Day Extend : " Days
Today=`date +%s`
Days_Detailed=$(( $Days * 86400 ))
Expire_On=$(($Today + $Days_Detailed))
Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
passwd -u $User
usermod -e  $Expiration $User
egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
clear
echo -e ""
echo -e "========================================"
echo -e ""
echo -e "    Username        :  $User"
echo -e "    Days Added      :  $Days Days"
echo -e "    Expires on      :  $Expiration_Display"
echo -e ""
echo -e "========================================"
else
clear
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "        Username Doesnt Exist        "
echo -e ""
echo -e "======================================"
fi
echo -e ""
echo -e ""
echo -e ""
read -n 1 -s -r -p "Press Any Key To Back On Menu"

menu-ssh
