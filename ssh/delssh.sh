#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================

clear
# // Clear
clear
clear && clear && clear
clear;clear;clear

# // Remove User
read -p "Input Username : " Pengguna

if [[ $Pengguna == "root" ]]; then
    echo -e "${EROR} Sorry Root User Cannot Be Removed !"
    exit 1
fi
if getent passwd $Pengguna > /dev/null 2>&1; then
        userdel -f $Pengguna
        echo -e "${OKEY} User ( ${YELLOW}$Pengguna${NC} ) Has Been Removed !"
else
        echo -e "${EROR} User ( ${YELLOW}$Pengguna${NC} ) Not Exists !"
fi
read -n 1 -s -r -p "Press any key to back on menu"

menu-ssh
