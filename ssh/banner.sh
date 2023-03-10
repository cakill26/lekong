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
echo -e "${red}==[ BACA TERLEBIH DAHULU ]==${NC}

1. Format harus html kalau kurang paham silahkan googling
2. Edit teks sesuai keinginan
3. Jika sudah di edit simpan tekan CTRL+x+y+enter
4. Untuk membatalkan/keluar tekan CTRL + x + n‌‌

nb : jangan lupa restart vps setelah edit banner‌‌
"
echo -n "Wanna go ? (y/n)? "
read answer
if [ -z $answer ]; then
menu-tools
fi
if [ "$answer" == "${answer#[Yy]}" ] ;then
setting-menu
else
clear
nano /etc/issue.net
setting-menu
fi
