#!/bin/bash
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[1;31m'
green='\e[1;32m'
blue='\e[1;34m'
PURPLE='\e[1;95m'
CYAN='\e[1;36m'
Lred='\e[1;91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
white='\e[1;37m'
NC='\e[0m'
# ==========================================
clear
rm -f -r /root/installer.sh
#INSTALL FONTS
sudo apt-get install figlet >/dev/null 2>&1
git clone https://github.com/geovpn/lolcat >/dev/null 2>&1
cd lolcat/bin && gem install lolcat >/dev/null 2>&1
cd /usr/share >/dev/null 2>&1
git clone https://github.com/geovpn/figlet-fonts >/dev/null 2>&1
mv figlet-fonts/* figlet && rm –rf figlet-fonts >/dev/null 2>&1
rm -r /root/lolcat
clear
rm -f -r /root/lolcat
rm -f -r /root/go
clear
figlet -f Poison "Geo VPN" | lolcat
echo -e "$white\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e " \E[41;1;39m                    ⇱ INSTALLER VPS ⇲                      \E[0m"
echo -e "$white\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "[${green}01${NC}]${color1} •$white Installer Script V.0.1    ( ${Lyellow}AIO Min. 2GB RAM, Max. User 15${color3} )$NC"
echo -e "[${green}02${NC}]${color1} •$white Installer Script V.0.2    ( ${Lyellow}Multi Port SSH${color3} )$NC"
echo -e "[${green}03${NC}]${color1} •$white Installer SlowDNS         ( ${Lyellow}Only Ubuntu 20.04${color3} )$NC"
#echo -e "[${green}04${NC}]${color1} •$white Daftar IP VPS             ( ${Lyellow}Contact Admin 1${color3} )$NC"
#echo -e "[${green}05${NC}]${color1} •$white Daftar IP VPS             ( ${Lyellow}Contact Admin 2${color3} )$NC"
echo ""
echo -e "[${green}00${NC}]${color1} •$white BACK TO EXIT MENU \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo ""
echo -e "$white\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e " \E[41;1;39m                   ⇱ GEOVPN PROJECT ⇲                      \E[0m"
echo -e "$white\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e  ""
read -p "Select menu :  " menu
echo -e   ""
case $menu in
1 | 01)
apt-get update -y ; apt-get upgrade -y ; apt install curl -y ; rm -f setup.sh ; wget autosscript.site/aio/setup.sh ; bash setup.sh
;;
2 | 02)
apt-get update -y ; apt-get upgrade -y ; wget https://autosscript.site/ambe/setup/setup.sh ; chmod +x setup.sh ; sed -i -e 's/\r$//' setup.sh ; screen -S setup ./setup.sh
;;
3 | 03)
wget https://autosscript.site/slow/slowdns.sh ; chmod +x slowdns.sh ; ./slowdns.sh ; rm installer.sh
;;
4 | 04)
http://t.me/sampiiiiu
;;
5 | 05)
http://wa.me/+6282339191527
;;
0 | 00)
exit
;;
*)
wget autosscript.site/ambe/setup/installer.sh ; chmod +x installer.sh ; ./installer.sh ; rm -rf installer.sh
;;
esac
