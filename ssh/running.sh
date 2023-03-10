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
############
MYIP=$(curl -sS ipv4.icanhazip.com)
export Desa=$(curl -s ipinfo.io/city )
export ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
export domain=$(cat /etc/xray/domain)
export DATE=$(date +%m/%d/%Y)
export IPVPS=$(curl -s ipinfo.io/ip )
export freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
export tram=$( free -m | awk 'NR==2 {print $2}' )
export swap=$( free -m | awk 'NR==4 {print $2}' )
#########################
IZIN=$(curl -sS https://raw.githubusercontent.com/geovpn/perizinan/main/main/allow | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
else
echo -e "\e[31mPermission Denied!\e[0m";
exit 0
fi
#EXPIRED
expired=$(curl -sS https://raw.githubusercontent.com/geovpn/perizinan/main/main/allow | grep $MYIP | awk '{print $3}')
echo $expired > /root/expired.txt
today=$(date -d +1day +%Y-%m-%d)
while read expired
do
	exp=$(echo $expired | curl -sS https://raw.githubusercontent.com/geovpn/perizinan/main/main/allow | grep $MYIP | awk '{print $3}')
	if [[ $exp < $today ]]; then
		geo="\033[1;31mExpired\033[0m"
        else
        geo=$(curl -sS https://raw.githubusercontent.com/geovpn/perizinan/main/main/allow | grep $MYIP | awk '{print $3}')
	fi
done < /root/expired.txt
rm /root/expired.txt
Name=$(curl -sS https://raw.githubusercontent.com/geovpn/perizinan/main/main/allow | grep $MYIP | awk '{print $2}')
# STATUS EXP
istri=$(date -d "$exp" +%s)
suami=$(date -d "$today" +%s)
anak=$(( (istri - suami) / 86400 ))
echo -e ""
# GETTING INFORMATION
ssh=$(systemctl status ssh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
l2tp_status=$(systemctl status xl2tpd | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
openvpn_service="$(systemctl show openvpn.service --no-page)"
oovpn=$(echo "${openvpn_service}" | grep 'ActiveState=' | cut -f2 -d=)
#sst_status=$(systemctl status shadowsocks-libev-server@tls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1) 
ss_status=$(systemctl status shadowsocks-libev | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1) 
tls_v2ray_status=$(systemctl status xray@v2ray-tls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nontls_v2ray_status=$(systemctl status xray@v2ray-nontls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vless_tls_v2ray_status=$(systemctl status xray@vless-tls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vless_nontls_v2ray_status=$(systemctl status xray@vless-nontls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssr_status=$(systemctl status ssrmu | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
trojan_server=$(systemctl status xray@trojan | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_status=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
stunnel_service=$(/etc/init.d/stunnel5 status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
sstp_service=$(systemctl status accel-ppp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
squid_service=$(/etc/init.d/squid status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vnstat_service=$(/etc/init.d/vnstat status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
cron_service=$(/etc/init.d/cron status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
fail2ban_service=$(/etc/init.d/fail2ban status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wg="$(systemctl show wg-quick@wg0.service --no-page)"
swg=$(echo "${wg}" | grep 'ActiveState=' | cut -f2 -d=)
trgo="$(systemctl show trojan-go.service --no-page)"                                      
strgo=$(echo "${trgo}" | grep 'ActiveState=' | cut -f2 -d=)  
sswg=$(systemctl status wg-quick@wg0 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wstls=$(systemctl status ws-tls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wsdrop=$(systemctl status ws-nontls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wsovpn=$(systemctl status ws-ovpn | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
osslh=$(systemctl status sslh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohp=$(systemctl status dropbear-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohq=$(systemctl status openvpn-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohr=$(systemctl status ssh-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
grpc=$(systemctl status geo-vmess-grpc | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vgrpc=$(systemctl status geo-vless-grpc | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

# COLOR VALIDATION
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
clear

# STATUS SERVICE Shadowsocks HTTP
if [[ $ss_status == "running" ]]; then 
   sss_status=" ${GREEN}Running ${NC}( No Error )"
else
   sss_status="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE OPENVPN
if [[ $oovpn == "active" ]]; then
  status_openvpn=" ${GREEN}Running ${NC}( No Error )"
else
  status_openvpn="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  SSH 
if [[ $ssh == "running" ]]; then 
   sssh=" ${GREEN}Running ${NC}( No Error )"
else
   sssh="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  SQUID 
if [[ $squid_service == "running" ]]; then 
   status_squid=" ${GREEN}Running ${NC}( No Error )"
else
   status_squid="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  VNSTAT 
if [[ $vnstat_service == "running" ]]; then 
   status_vnstat=" ${GREEN}Running ${NC}( No Error )"
else
   status_vnstat="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  CRONS 
if [[ $cron_service == "running" ]]; then 
   status_cron=" ${GREEN}Running ${NC}( No Error )"
else
   status_cron="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  FAIL2BAN 
if [[ $fail2ban_service == "running" ]]; then 
   status_fail2ban=" ${GREEN}Running ${NC}( No Error )"
else
   status_fail2ban="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  TLS 
if [[ $tls_v2ray_status == "running" ]]; then 
   status_tls_v2ray=" ${GREEN}Running${NC} ( No Error )"
else
   status_tls_v2ray="${RED}  Not Running${NC}   ( Error )"
fi

# STATUS SERVICE NON TLS V2RAY
if [[ $nontls_v2ray_status == "running" ]]; then 
   status_nontls_v2ray=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   status_nontls_v2ray="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE VLESS HTTPS
if [[ $vless_tls_v2ray_status == "running" ]]; then
  status_tls_vless=" ${GREEN}Running${NC} ( No Error )"
else
  status_tls_vless="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE VLESS HTTP
if [[ $vless_nontls_v2ray_status == "running" ]]; then
  status_nontls_vless=" ${GREEN}Running${NC} ( No Error )"
else
  status_nontls_vless="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# SHADOWSOCKSR STATUS
if [[ $ssr_status == "running" ]] ; then
  status_ssr=" ${GREEN}Running${NC} ( No Error )${NC}"
else
  status_ssr="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# SODOSOK
if [[ $status_text == "active" ]] ; then
  status_sodosok=" ${GREEN}Running${NC} ( No Error )${NC}"
else
  status_sodosok="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE TROJAN
if [[ $trojan_server == "running" ]]; then 
   status_virus_trojan=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   status_virus_trojan="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE WIREGUARD
if [[ $swg == "active" ]]; then
  status_wg=" ${GREEN}Running ${NC}( No Error )${NC}"
else
  status_wg="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# Status Service Trojan GO
if [[ $strgo == "active" ]]; then
  status_trgo=" ${GREEN}Running ${NC}( No Error )${NC}"
else
  status_trgo="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE L2TP
if [[ $l2tp_status == "running" ]]; then 
   status_l2tp=" ${GREEN}Running${NC} ( No Error )${NC}"
else
   status_l2tp="${RED}  Not Running${NC}  ( Error )${NC}"
fi

# STATUS SERVICE DROPBEAR
if [[ $dropbear_status == "running" ]]; then 
   status_beruangjatuh=" ${GREEN}Running${NC} ( No Error )${NC}"
else
   status_beruangjatuh="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE STUNNEL
if [[ $stunnel_service == "running" ]]; then 
   status_stunnel=" ${GREEN}Running ${NC}( No Error )"
else
   status_stunnel="${RED}  Not Running ${NC}  ( Error )}"
fi

# STATUS SERVICE SSTP
if [[ $sstp_service == "running" ]]; then 
   status_sstp=" ${GREEN}Running ${NC}( No Error )"
else
   status_sstp="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE WEBSOCKET TLS
if [[ $wstls == "running" ]]; then 
   swstls=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swstls="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET DROPBEAR
if [[ $wsdrop == "running" ]]; then 
   swsdrop=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swsdrop="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET OPEN OVPN
if [[ $wsovpn == "running" ]]; then 
   swsovpn=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swsovpn="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE SSLH / SSH
if [[ $osslh == "running" ]]; then 
   sosslh=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sosslh="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS OHP DROPBEAR
if [[ $ohp == "running" ]]; then 
   sohp=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sohp="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS OHP OpenVPN
if [[ $ohq == "running" ]]; then 
   sohq=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sohq="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS OHP SSH
if [[ $ohr == "running" ]]; then 
   sohr=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   sohr="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET OPENSSH
if [[ $wsopen == "running" ]]; then 
   swsopen=" ${GREEN}Running ${NC}( No Error )${NC}" 
else
   swsopen="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE GRPC VMESS
if [[ $grpc == "running" ]]; then 
   sgrpc=" ${GREEN}Running ${NC}( No Error )${NC}" 
else
   sgrpc="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE GRPC VMESS
if [[ $vgrpc == "running" ]]; then 
   svgrpc=" ${GREEN}Running ${NC}( No Error )${NC}" 
else
   svgrpc="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# TOTAL RAM
total_ram=` grep "MemTotal: " /proc/meminfo | awk '{ print $2}'`
totalram=$(($total_ram/1024))
# KERNEL TERBARU
#kernelku=$(uname -r)
Domen="$(cat /etc/xray/domain)"
figlet -f Poison "Geo VPN" | lolcat
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│$NC\E[41;1;39m     ⇱ Subscription & System Information ⇲                 \E[0m\033[0;34m│"
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│$NC$green SEVER UPTIME         ${color1}:$white $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "\033[0;34m│$NC$green HOSTNAME             ${color1}:$white $HOSTNAME"
echo -e "\033[0;34m│$NC$green CURRENT TIME         ${color1}:$white $( date -d "0 days" +"%d-%m-%Y | %X" )"
echo -e "\033[0;34m│$NC$green ISP NAME             ${color1}:$white $ISP"
echo -e "\033[0;34m│$NC$green CITY                 ${color1}:$white $Desa"
echo -e "\033[0;34m│$NC$green OPERATING SYSTEM     ${color1}:$white "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e "\033[0;34m│$NC$green TOTAL AMOUNT OF RAM  ${color1}:$white $tram MB"
echo -e "\033[0;34m│$NC$green DOMAIN               ${color1}:$white $domain"
echo -e "\033[0;34m│$NC$green IP VPS               ${color1}:$white $IPVPS"
#echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
#echo -e " \E[41;1;39m                ⇱ Subscription Information ⇲               \E[0m\033[0;34m│"
#echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e "\033[0;34m│$NC$green CLIENT NAME          ${color1}:$white \033[1;36m$Name${NC}"
echo -e "\033[0;34m│$NC$green EXP SCRIPT           ${color1}:$white \033[1;36m$geo $NC$white( $green$anak days$white )${NC}"
echo -e "\033[0;34m│$NC$green VERSION              ${color1}:$white \033[1;36m$(cat /opt/.ver)\e[0m${NC}"
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│$NC\E[41;1;39m                  ⇱ Service Information ⇲                  \E[0m\033[0;34m│"
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│$NC$white SSH / TUN                    :$sssh"
echo -e "\033[0;34m│$NC$white OpenVPN                      :$status_openvpn"
echo -e "\033[0;34m│$NC$white Dropbear                     :$status_beruangjatuh"
echo -e "\033[0;34m│$NC$white Stunnel5                     :$status_stunnel"
echo -e "\033[0;34m│$NC$white Squid                        :$status_squid"
echo -e "\033[0;34m│$NC$white Fail2Ban                     :$status_fail2ban"
echo -e "\033[0;34m│$NC$white Crons                        :$status_cron"
echo -e "\033[0;34m│$NC$white Vnstat                       :$status_vnstat"
echo -e "\033[0;34m│$NC$white L2TP                         :$status_l2tp"
echo -e "\033[0;34m│$NC$white SSTP                         :$status_sstp"
echo -e "\033[0;34m│$NC$white XRAYS Vmess TLS              :$status_tls_v2ray"
echo -e "\033[0;34m│$NC$white XRAYS Vmess None TLS         :$status_nontls_v2ray"
echo -e "\033[0;34m│$NC$white XRAYS Vless TLS              :$status_tls_vless"
echo -e "\033[0;34m│$NC$white XRAYS Vless None TLS         :$status_nontls_vless"
echo -e "\033[0;34m│$NC$white XRAYS Vmess GRPC             :$sgrpc"
echo -e "\033[0;34m│$NC$white XRAYS Vless GRPC             :$svgrpc"
echo -e "\033[0;34m│$NC$white Shadowsocks-R                :$status_ssr"
#echo -e " Shadowsocks-OBFS HTTPS  :$status_sst"
echo -e "\033[0;34m│$NC$white Shadowsocks-OBFS             :$sss_status"
echo -e "\033[0;34m│$NC$white XRAYS Trojan                 :$status_virus_trojan"
echo -e "\033[0;34m│$NC$white Trojan GO                    :$status_trgo"
echo -e "\033[0;34m│$NC$white Wireguard                    :$status_wg"
echo -e "\033[0;34m│$NC$white Websocket TLS                :$swstls"
echo -e "\033[0;34m│$NC$white Websocket None TLS           :$swsdrop"
echo -e "\033[0;34m│$NC$white Websocket Ovpn               :$swsovpn"
echo -e "\033[0;34m│$NC$white OHP Dropbear                 :$sohp"
echo -e "\033[0;34m│$NC$white OHP OpenVPN                  :$sohq"
echo -e "\033[0;34m│$NC$white OHP SSH                      :$sohr"
echo -e "\033[0;34m│$NC$white SSL / SSH Multiplexer        :$sosslh"
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
echo -e "\033[0;34m┌───────────────────────────────────────────────────────────┐${NC}"
echo -e "\033[0;34m│$NC\E[41;1;39m                      ⇱ GEOVPN PROJECT ⇲                   \E[0m\033[0;34m│"
echo -e "\033[0;34m└───────────────────────────────────────────────────────────┘${NC}"
#read -n 1 -s -r -p "Press Any Key To Back On Menu"

#menu
