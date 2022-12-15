#!/usr/bin/env bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds/backup
# @Author: nanoseeds
# @CreateDate: 2020-08-21 18:23:17
###

SHELL_FOLDER=$(
    cd "$(dirname "${0}")"
    pwd
)
wsl() {
    sudo chmod 0777 /usr/bin/screen
    sudo /etc/init.d/screen-cleanup start
    sudo apt update -y
    sudo apt upgrade -y
    sudo /etc/init.d/ssh restart
    source "${SHELL_FOLDER}"/set_proxy.sh
}
function ubuntu(){
    sudo apt update
    sudo apt upgrade
    sudo apt clean
    sudo apt autoremove
    sudo apt autoclean
}
ubuntu
#wsl
