#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================

clear
sleep 3
domain=$(cat /etc/xray/domain)
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Jakarta
chronyc sourcestats -v
chronyc tracking -v
date

# / / Ambil Xray Core Version Terbaru
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"

# / / Installation Xray Core
xraycore_link="https://github.com/XTLS/Xray-core/releases/download/v$latest_version/xray-linux-64.zip"

# 
uuid=$(cat /proc/sys/kernel/random/uuid)

# / / Make Main Directory
mkdir -p /usr/bin/xray
mkdir -p /etc/xray

# / / Unzip Xray Linux 64
cd `mktemp -d`
curl -sL "$xraycore_link" -o xray.zip
unzip -q xray.zip && rm -rf xray.zip
mv xray /usr/local/bin/xray
chmod +x /usr/local/bin/xray

# Make Folder XRay
mkdir -p /var/log/xray/
#
wget -q -O /usr/local/bin/geosite.dat "https:${Server_URL}/grpc/geosite.dat"
wget -q -O /usr/local/bin/geoip.dat "https://${Server_URL}/grpc/geoip.dat"

#
cat > /etc/xray/geo-vmessgrpc.json << END
{
    "log": {
            "access": "/var/log/xray/access5.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 4443,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vmessgrpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "Geo"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
END

cat > /etc/xray/geo-vlessgrpc.json << END
{
    "log": {
            "access": "/var/log/xray/access5.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 2082,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vlessgrpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "Geo"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
END

cat > /etc/systemd/system/geo-vmess-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://t.me/sampiiiiu
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /etc/xray/geo-vmessgrpc.json
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/geo-vless-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://t.me/sampiiiiu
After=network.target nss-lookup.target

[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /etc/xray/geo-vlessgrpc.json
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
EOF

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2096 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2096 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2082 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2082 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl enable geo-vmess-grpc
systemctl restart geo-vmess-grpc
systemctl enable geo-vless-grpc
systemctl restart geo-vless-grpc
#
cd /usr/local/sbin


wget -O addgrpc "https://${Server_URL}/grpc/addgrpc.sh" > /dev/null 2>&1
wget -O delgrpc "https://${Server_URL}/grpc/delgrpc.sh" > /dev/null 2>&1
wget -O renewgrpc "https://${Server_URL}/grpc/renewgrpc.sh" > /dev/null 2>&1
wget -O cekgrpc "https://${Server_URL}/grpc/cekgrpc.sh" > /dev/null 2>&1
chmod +x addgrpc > /dev/null 2>&1
chmod +x delgrpc > /dev/null 2>&1
chmod +x renewgrpc > /dev/null 2>&1
chmod +x cekgrpc > /dev/null 2>&1
cd
rm -f geo-grpc.sh
