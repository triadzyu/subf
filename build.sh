#!/bin/bash
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

instal_nodejs_vps() {
    apt update && apt upgrade -y
    apt install binutils -y
    apt install coreutils -y
    apt install xz-utils -y
    apt install -y nodejs npm
    ln -s /usr/bin/nodejs /usr/bin/node
    npm install -g bash-obfuscate
    apt install cmdtest -y
    apt install yarn -y
    #cd "$PROJECT_DIR"
    #echo "Install dependensi..."
    #yarn install || npm install
    #echo "Menjalankan project..."
    #npm start
}

function dpkg_query(){
    if [ $(dpkg-query -W -f='${Status}' shc 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo belum terinstall shc, we will aquire them now. This may take a while.
        read -p 'Press enter to continue.'
        apt update && apt upgrade -y
        apt install shc
    elif [ $(dpkg-query -W -f='${Status}' nodejs 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo belum terinstall nodejs, we will aquire them now. This may take a while.
        read -p 'Press enter to continue.'
        instal_nodejs_vps
    fi
}

function instalnpm(){
PROJECT_DIR="$HOME/enc"
REPO_URL="https://github.com/triadzyu/enc.git"

if ! command -v node &> /dev/null; then
    echo "Node.js belum terinstall, akan dipasang sekarang. Ini mungkin butuh waktu."
    read -p "Tekan enter untuk melanjutkan..."
    apt update && apt upgrade -y
    apt install -y nodejs npm
    npm install -g bash-obfuscate
    apt install -y yarn
    cd "$PROJECT_DIR"
    echo "Install dependensi..."
    yarn install || npm install
    echo "Menjalankan project..."
    npm start
else
    echo "Npm Node.js sudah terpasang. ✓"
fi

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Project belum ada, akan clone dari repo."
    git clone "$REPO_URL" "$PROJECT_DIR"
fi



mkdir lib
echo 'echo lib.so' > lib/lib.sh
git add lib/lib.sh
git commit -m "add lib.sh in lib folder"
git push


git add build.sh
git commit -m "add build.sh in HOME folder"
git push



}

download_packages_vps
