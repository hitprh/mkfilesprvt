#!/bin/bash
# Illegal selling and redistribution of this script is strictly prohibited.
# Please respect the author's property.
# Binigay sainyo ng libre, ipamahagi nyo rin ng libre.

DEBIAN_SOURCES_LIST="/etc/apt/sources.list"



# Update package list
apt update || handle_error "Failed to update package list."
art=$(cat << "EOF"

  __  __ _____ _____ _____   ____   _____ _____ _    _   _____ _   _  _____ _______       _      _      ______ _____  
 |  \/  |_   _/ ____|  __ \ / __ \ / ____/ ____| |  | | |_   _| \ | |/ ____|__   __|/\   | |    | |    |  ____|  __ \ 
 | \  / | | || |    | |__) | |  | | (___| (___ | |__| |   | | |  \| | (___    | |  /  \  | |    | |    | |__  | |__) |
 | |\/| | | || |    |  _  /| |  | |\___ \\___ \|  __  |   | | | . ` |\___ \   | | / /\ \ | |    | |    |  __| |  _  / 
 | |  | |_| || |____| | \ \| |__| |____) |___) | |  | |  _| |_| |\  |____) |  | |/ ____ \| |____| |____| |____| | \ \ 
 |_|  |_|_____\_____|_|  \_\\____/|_____/_____/|_|  |_| |_____|_| \_|_____/   |_/_/    \_\______|______|______|_|  \_\
                                                                                                                      
                                                                                                                      

EOF
)
                                                                                                                                                
clear

echo "$art"
echo "Please select your OS version:"
echo "1. Debian 9"
echo "2. Debian 10"
echo "3. Debian 11"
echo "4. Debian 12"
echo "5. Exit"
read -p "Enter your choice [1-5]: " choice


case $choice in
    1)
        echo "You selected Debian 9"
        rm -f $DEBIAN_SOURCES_LIST || handle_error "Failed to remove the current sources.list"
        cat << END > $DEBIAN_SOURCES_LIST
# Debian 9 Stretch (Archived)
deb http://archive.debian.org/debian/ stretch main contrib non-free
deb-src http://archive.debian.org/debian/ stretch main contrib non-free

deb http://archive.debian.org/debian-security stretch/updates main contrib non-free
deb-src http://archive.debian.org/debian-security stretch/updates main contrib non-free

deb http://archive.debian.org/debian stretch-updates main contrib non-free
deb-src http://archive.debian.org/debian stretch-updates main contrib non-free

END
        ;;
    2)
        echo "You selected Debian 10"
        rm -f $DEBIAN_SOURCES_LIST || handle_error "Failed to remove the current sources.list"
        cat << END > $DEBIAN_SOURCES_LIST
# Debian 10 Buster
deb http://deb.debian.org/debian/ buster main contrib non-free
deb-src http://deb.debian.org/debian/ buster main contrib non-free

deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free

deb http://deb.debian.org/debian/ buster-updates main contrib non-free
deb-src http://deb.debian.org/debian/ buster-updates main contrib non-free

deb http://deb.debian.org/debian/ buster-backports main contrib non-free
deb-src http://deb.debian.org/debian/ buster-backports main contrib non-free

END
        ;;
    3)
        echo "You selected Debian 11"
        rm -f $DEBIAN_SOURCES_LIST || handle_error "Failed to remove the current sources.list"
        cat << END > $DEBIAN_SOURCES_LIST
# Debian 11 Bullseye
deb http://deb.debian.org/debian/ bullseye main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye main contrib non-free

deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free

deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye-updates main contrib non-free

deb http://deb.debian.org/debian/ bullseye-backports main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye-backports main contrib non-free

END
        ;;
    4)
        echo "You selected Debian 12"
        rm -f $DEBIAN_SOURCES_LIST || handle_error "Failed to remove the current sources.list"
        cat << END > $DEBIAN_SOURCES_LIST
# Debian Bookworm Repositories
deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware

# Debian Security Updates
deb http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware

# Debian Updates
deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware

# Backports (if you need newer packages)
deb http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware

END

        # Install the required OpenSSL package
        wget -q http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb || handle_error "Failed to download libssl1.1 package"
        dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb || handle_error "Failed to install libssl1.1 package"
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        handle_error "Invalid option selected."
        ;;
esac

echo "Sources list updated successfully."

sleep 1s


apt install -y || handle_error "Failed to install required packages."

sleep 1s
apt update 

rm -f DebianVPS* 
wget -q 'https://raw.githubusercontent.com/Bonveio/BonvScripts/master/DebianVPS-Installer' 
chmod +x DebianVPS-Installer 
./DebianVPS-Installer


rm -f /etc/banner
wget -qO /etc/banner https://raw.githubusercontent.com/bannerpy/Files/main/mcbanner
dos2unix -q /etc/banner
sleep 1s
clear

echo "$art"
echo "Please Select WS Port"
echo "1. SSHWS - 80"
echo "2. MULTI WS - SSLWS: 8443,9443,7443 | SSHWS: 80,8888,880 | OVPNWS (TCP): 1110,2110,3110"
echo "3. Do Not Install WS"
echo

read -p "Enter your choice [1-3]: " choice

case $choice in
    1)
        echo "You selected SSHWS - 80"
        wget -q -O /etc/microssh https://raw.githubusercontent.com/bannerpy/Files/main/micro.py
        chmod +x /etc/microssh
        sed -i "/DEFAULT_HOST = '127.0.0.1:443'/c\DEFAULT_HOST = '127.0.0.1:550'" /etc/microssh
        clear
        echo "$art"
        echo "Configuration for SSHWS on port 80 has been completed."
        ;;
    2)
        echo "You selected MULTI WS"
        
       
        wget -q -O /etc/microssh https://raw.githubusercontent.com/hitprh/mkfilesprvt/main/microws.py
        chmod +x /etc/microssh
        clear



        echo "$art"
        echo "MULTI WS installation completed."
        echo "MULTI WS is configured with the following ports:"
        echo "SSLWS: 8443, 9443, 7443"
        echo "SSHWS: 80, 8888, 880"
        echo "OVPNWS (TCP): 1110, 2110, 3110"
        ;;
    3)
        echo "You selected not to install WebSocket services."
        echo "Skipping WS installation."
        ;;
    *)
        echo "Invalid choice, please select 1, 2, or 3."
        ;;
esac


cat << END > /etc/systemd/system/microssh.service 
[Unit]
Description=Micro Ssh
Documentation=https://google.com
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python3 -O /etc/microssh
Restart=on-failure

[Install]
WantedBy=multi-user.target
END


systemctl daemon-reload
systemctl enable microssh
systemctl restart microssh


systemctl restart microssh

sleep 1s
wget -q -O /usr/local/bin/portcheck.py https://raw.githubusercontent.com/hitprh/word/main/portcheck.py
chmod +x /usr/local/bin/portcheck.py


cat << END > /etc/systemd/system/portcheck.service 
[Unit]
Description=Monitor and restart specified services on failure
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 /usr/local/bin/portcheck.py
Restart=always
RestartSec=30
Restart=on-failure

[Install]
WantedBy=multi-user.target

END
systemctl daemon-reload
systemctl enable portcheck
systemctl start portcheck
systemctl restart portcheck


apt-get install squid
apt install squid

wget -qO /etc/squid/squid.conf https://raw.githubusercontent.com/Senpaiconfig/microsshpanel/main/squid.conf
dos2unix -q /etc/squid/squid.conf
service squid start

sed -i "s|127.0.0.1|$(curl -s https://api.ipify.org)|g" /etc/squid/squid.conf && service squid restart


sed -i '$ a\VersionAddendum <font color="green">MICROSSH.COM OPENSSH</font>' /etc/ssh/sshd_config

bash -c "sed -i '/ncp-disable/d' /etc/openvpn/server/*.conf; systemctl restart openvpn-server@{ec_s,s}erver_{tc,ud}p"

sed -i "s|127.0.0.1|$(curl -s https://api.ipify.org)|g" /etc/stunnel/stunnel.conf && service stunnel4 restart


service stunnel4 start

restart_service() {
    service_name=$1
    echo "Restarting $service_name..."
    service $service_name restart
    if [ $? -eq 0 ]; then
        echo "$service_name restarted successfully."
    else
        echo "Failed to restart $service_name."
    fi
}


restart_service stunnel4
restart_service dropbear
restart_service squid
restart_service openvpn
restart_service ssh


echo "System services (proxy, SSH, OpenVPN, and Squid) have been restarted."
sleep 2s
apt update
apt upgrade -y
apt full-upgrade -y
apt autoremove -y

echo "" > ~/.bash_history 
echo '' > /var/log/syslog
rm -f /etc/crontab
history -c
clear
echo "$art"
echo "MICROSSH DEBIAN 9-12 INSTALLER COMPLETED"
echo "Port Autocheck and Restart Added."
echo "Squid and Ovpn Fix."
echo "Credits to BonvScript."
echo "BonvScript Fixed Version Team Microssh."
