#!/bin/bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds/backup
# @Organization: SUSTech
# @Author: nanoseeds
# @Date: 2020-02-14 12:03:47
 # @LastEditors: nanoseeds
 # @LastEditTime: 2021-09-04 21:44:36
###
USER_AGENT="Mozilla/5.0 (X11;U;Linux i686;en-US;rv:1.9.0.3) Geco/2008092416 Firefox/3.0.3"
UBUNTU_VERSION="$(lsb_release -c | sed 's/Codename://g' | xargs)"
finish() {
    echo "${0} ${1} finish"
}
main_0() {
    sudo apt update -y
    sudo apt upgrade -y
}
main_source() {
    # backup so
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup
    echo "deb http://mirrors.163.com/debian/ bullseye main contrib non-free" | sudo tee /etc/apt/sources.list > /dev/null
    main_0
}
main_build() {
    sudo apt -y install git build-essential manpages-dev \
        make ffmpeg libssl-dev openssl net-tools vim xclip \
        curl wget screen gdb zip tree neofetch transmission \
        proxychains4 rename aria2 manpages-dev keychain \
        libimage-exiftool-perl openssh-client openssh-server traceroute htop pigz
}
main_jdk_mvn() {
    sudo apt install apt-transport-https ca-certificates wget dirmngr gnupg software-properties-common
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
    sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
    sudo apt update
    sudo apt install -y adoptopenjdk-8-hotspot openjdk-11-jdk openjdk-17-jdk maven gradle ant
    sudo update-alternatives --display java
    # sudo update-alternatives --config java
    # sudo update-alternatives --config javac
}
main_cmake() {
    sudo apt install cmake
}
main_python3() {
    sudo apt install -y python3-pip
}
# TODO
# sshd config
# 笔记本合盖 /etc/systemd/logind.conf
# #HandleLidSwitch=suspend -> #HandleLidSwitch=lock
# *power
# 安装网卡驱动 关闭安全启动 
main_ohmyzsh() {
    # download oh-my-zsh
    sudo apt install -y zsh
    sudo chsh -s "$(which zsh)"
    sudo usermod -s "$(which zsh)" "$(whoami)"
    if [ -d "${HOME}/.oh-my-zsh" ]; then
        rm -rf "${HOME}/.oh-my-zsh"
    fi
    proxychains4 git clone https://github.com/ohmyzsh/ohmyzsh.git \
        "${HOME}"/.oh-my-zsh --depth=1
    proxychains4 git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${HOME}"/.oh-my-zsh/plugins/zsh-syntax-highlighting --depth=1
    proxychains4 git clone https://github.com/zsh-users/zsh-autosuggestions.git \
        "${HOME}"/.oh-my-zsh/plugins/zsh-autosuggestions --depth=1
    {
        sudo chmod 0755 "${HOME}"/.oh-my-zsh
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/custom/plugins
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/plugins
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/plugins/z
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/plugins/git
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/plugins/zsh-syntax-highlighting
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/plugins/zsh-autosuggestions
    }
}
main_mysql(){
    wget https://repo.mysql.com/mysql-apt-config_0.8.19-1_all.deb
    sudo dpkg -i mysql-apt-config_0.*.****_all.deb
    # sudo apt remove mysql-server # remove mysql-5.7
    sudo apt update
    sudo apt install mysql-server # remove mysql-8.0
    mysql --version
}
main_nodejs() {
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install -y nodejs
}
function main_sshkeygen() {
    pre_path="${HOME}/.ssh/"
    file_name="${pre_path}"/YOUR_FILE_NAME
    ssh-keygen -t ed25519 -C "51754303+Certseeds@users.noreply.github.com" -f "${file_name}"
    xclip -selection clipboard <"${file_name}".pub
    #! DONT FORGET ADD PATH to zshrc
}
function main_gpgkeygen() {
    gpg --full-generate-key
    arpublic-file.key --export keyId
    gpg --armor -o private-file.key --export-secret-keys keyId
    gpg --import public-file.key
    gpg --allow-secret-key-import --import private-file.key
    gpg --list-secret-keys --keyid-format LONG
}
main_sshd() {
    sudo chown -R 1000:1000 "${HOME}"/.ssh/* # make sure all filex own by normal user
    sudo chmod 0700 "${HOME}"/.ssh
    sudo chmod 0600 "${HOME}"/.ssh/*
}
main_microsoft() {
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 0644 microsoft.gpg /etc/apt/trusted.gpg.d/
}
main_vscode() {
    main_microsoft
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo rm microsoft.gpg
    ## Install
    sudo apt update
    sudo apt install -y code
}
main_msedge() {
    ## Setup
    main_microsoft
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
    sudo rm microsoft.gpg
    ## Install
    sudo apt update
    sudo apt install -y microsoft-edge-dev
}
main_clang_format(){
    sudo apt install clang-format-10
}
main_docker(){
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install docker-ce
    sudo systemctl status docker
    docker --version
    sudo groupadd docker
    sudo usermod -aG docker "${USER}"
    docker run hello-world
}
main_114514() {
    sudo apt autoremove
    sudo apt autoclean
    sudo apt clean
}
main_index() {
    main_0
    echo "$0 stage 0 init"
    for index in "$@"; do
        echo "stage ${index} init"
        main_${index}
        finish ${index}
    done
    main_114514
    echo "main_index over"
}
main_index "$@"
exit 0
# do it after the all cript!
# TODO source ~/.zshrc;
# better do it by self: "source ~/.zshrc"