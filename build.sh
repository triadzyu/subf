#!/bin/bash

Green_background="\033[42;37m"
Reeed_background="\033[41;37m"
Green_background="\033[42;37m"
Red_background="\033[41;37m"
Suffix="\033[0m"

CLBlack="\e[0;30m";CLRed="\e[0;31m";CLGreen="\e[0;32m"
CLYellow="\e[0;33m";CLBlue="\e[0;34m";CLPurple="\e[0;35m"
CLCyan="\e[0;36m";CLWhite="\e[0;37m"

BGBlack="\e[40m";BGRed="\e[41m";BGGreen="\e[42m"
BGYellow="\e[43m";BGBlue="\e[44m";BGPurple="\e[45m"
BGCyan="\e[46m";BGWhite="\e[47m"

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
NC='\e[0m'
tyblue='\e[1;36m'
merah='\033[0;31m'
netral='\e[0m'

b="\033[34;1m";m="\033[31;1m";h="\033[32;1m"
p="\033[39;1m";c="\033[35;1m";u="\033[36;1m"
k="\033[33;1m";n="\033[00m"
pu="\033[36;1m"
ds="\033[30;1m"
o="\033[0m"


biru="\033[34;1m"

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ============================================================
IDX="https://raw.githubusercontent.com/njajaldoang/1dra/main/"
YDX="https://raw.githubusercontent.com/YaddyKakkoii/stb/main/"
# ============================================================
function makedirectory(){
    mkdir -p $HOME/.var
    mkdir -p $HOME/.var/local
    mkdir -p $HOME/.var/local/sbin
    mkdir -p $HOME/.var/local/backup
}
function checkdirectory(){
if [ -d $HOME/.var ]; then rm -rf $HOME/.var; fi
if [ ! -d $HOME/.var ]; then makedirectory; fi
}
if [ ! -f $HOME/.var/local/sbin/spiner ]; then
    checkdirectory
    wget -qO $HOME/.var/local/sbin/spiner "${YDX}spiner.sh"
    chmod 777 $HOME/.var/local/sbin/spiner
else
    rm -rf $HOME/.var/local/sbin/spiner
    wget -qO $HOME/.var/local/sbin/spiner "${YDX}spiner.sh"
    chmod 777 $HOME/.var/local/sbin/spiner
fi
source $HOME/.var/local/sbin/spiner
clear
# ============================================================
type -P wget 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'wget' not found, installing" && apt install wget -y
type -P curl 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'curl' not found, installing" && apt install curl -y
type -P nmap 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'nmap' not found, installing" && apt install nmap -y
type -P zip 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'zip' not found, installing" && apt install zip -y
type -P jq 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'jq' not found, installing" && apt install jq
type -P gawk 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'gawk' not found, installing" && apt install gawk
type -P sshpass 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'sshpass' not found, installing" && apt install sshpass
type -P vim 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'vim' not found, installing" && apt install vim
# ============================================================

paketvps=(
    "wget"
    "nmap"
    "zip"
    "nmap"
    "jq"
    "bc"
    "screen"
    "vim"
    "httping"
    "gcc"
    "sshpass"
    "perl"
    "git"
)

check_vps() {
    local paketvps="$1"
    if ls /usr/bin | grep -q "^$paketvps"; then
        echo "$paketvps sudah terpasang.✓"
    else
        echo "$paketvps belum terpasang. Menginstal $package..."
        apt install ${paketvps} -y
        if [ $? -eq 0 ]; then
            echo "$paketvps berhasil diinstal."
        else
            echo "Gagal menginstal $paketvps."
        fi
    fi
}

download_packages_vps() {
    echo "Update dan instal paket"
    for pkg in "${paketvps[@]}"; do
        check_vps "$pkg"
    done
    sleep 1
}

download_packages_vps

# Fungsi untuk menginstal Subfinder
install_subfinder() {
  echo "Memeriksa apakah Subfinder sudah terpasang..."
  if ! command -v subfinder &> /dev/null; then
    echo "Subfinder tidak ditemukan. Mengunduh dan memasang Subfinder..."
    curl -s https://api.github.com/repos/projectdiscovery/subfinder/releases/latest | \
    grep "browser_download_url.*linux_amd64.zip" | cut -d '"' -f 4 | \
    wget -i - -O subfinder.zip
    unzip subfinder.zip
    chmod +x subfinder
    sudo mv subfinder /usr/local/bin/
    rm subfinder.zip
    echo "Subfinder berhasil dipasang!"
  else
    echo "Subfinder sudah terpasang."
  fi
}

if ! command -v subfinder &> /dev/null; then
    install_subfinder
else
    printf "${p}[${m}!${p}]${h} ${CYAN} subfinder ${GREEN}terinstall ✓\n"
fi
