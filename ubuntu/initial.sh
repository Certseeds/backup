#!/usr/bin/env bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds/backup
# @Author: nanoseeds
# @CreateDate: 2020-02-14 12:03:47
###
depercated="true" # no more feature will be add to this file
USER_AGENT="Mozilla/5.0 (X11;U;Linux i686;en-US;rv:1.9.0.3) Geco/2008092416 Firefox/3.0.3"
UBUNTU_VERSION="$(lsb_release -c | sed 's/Codename://g' | xargs)"
finish() {
    echo "${0} ${1} finish"
}
main_0() {
    #sudo chmod 0777 /usr/bin/screen
    # sudo /etc/init.d/screen-cleanup start
    sudo apt update -y
    sudo apt upgrade -y
}
main_build() {
    sudo apt -y install git build-essential manpages-dev \
        make ffmpeg libssl-dev openssl net-tools vim xclip \
        curl wget screen gdb zip tree neofetch transmission \
        proxychains4 exiftool rename aria2 manpages-dev keychain \
        lsb-core openssh-client openssh-server traceroute htop pigz
}
main_newergcc() {
    sudo apt-get update
    local GCC_VERSION=11
    sudo apt-get install gcc-"${GCC_VERSION}" g++-"${GCC_VERSION}"
    gcc-"${GCC_VERSION}" --version
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 1110
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 750
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 1110
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 750
}
main_cmake() {
    sudo apt install -y apt-transport-https ca-certificates gnupg software-properties-common wget

    wget "https://apt.kitware.com/keys/kitware-archive-latest.asc" | gpg --dearmor > kitware.gpg
    sudo install -o root -g root -m 0644 kitware.gpg /etc/apt/trusted.gpg.d/
    rm ./kitware.gpg
    sudo add-apt-repository "deb [signed-by=/etc/apt/trusted.gpg.d/kitware.gpg] https://apt.kitware.com/ubuntu/ ${UBUNTU_VERSION} main" -y
    sudo apt update
    sudo apt-cache policy cmake
    sudo apt-cache policy cmake-data
    # CMAKE_VERSION="3.20.5-0kitware1ubuntu20.04.1" # for ubuntu 2004
    sudo apt -y install cmake-data="${CMAKE_VERSION}" cmake="${CMAKE_VERSION}"
    sudo apt-mark hold cmake cmake-data
}
main_python3() {
    sudo apt install -y python3-pip
    sudo pip3 install numpy
}
main_jdk_mvn() {
    sudo apt-get update
    sudo apt install -y openjdk-14-jdk openjdk-11-jdk openjdk-8-jdk maven gradle ant
    sudo update-alternatives --display java
}
main_nodejs() {
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
}
main_opencv3() {
    sudo apt install -y libopencv-dev
}
main_go() {
    sudo apt install -y golang-go
}
main_pdftotext() {
    sudo apt install -y libpoppler-cpp-dev pkg-config
    pip3 install pdftotext            # then can import pdftotext
    sudo apt install -y poppler-utils # then can run `pdftotext`
}
main_texlive() {
    # it's better to install it via docker, texlive contains so much files...
    mkdir -p "${HOME}"/zsh_include
    local origin="$(pwd)"
    mkdir -p ./texlive
    mkdir -p /media/tex
    sudo mount -t auto -o loop ./texlive.iso /media/tex
    cd /media/tex
    sudo ./install-tl
    #! then should input  `I`
    sudo umount /media/tex
    sudo rm -r /media/tex
    cd "${origin}"
}
function main_sshkeygen() {
    local pre_path="${HOME}/.ssh/"
    local file_name="${pre_path}"/YOUR_FILE_NAME
    ssh-keygen -t ed25519 -C "51754303+Certseeds@users.noreply.github.com" -f "${file_name}"
    xclip -selection clipboard <"${file_name}".pub
    #! DONT FORGET ADD PATH to zshrc
}
function main_gpgkeygen() {
    gpg --full-generate-key
    gpg --armor -o public-file.key --export keyId
    gpg --armor -o private-file.key --export-secret-keys keyId
    gpg --import public-file.key
    gpg --allow-secret-key-import --import private-file.key
    gpg --list-secret-keys --keyid-format LONG
}

main_sshd() {
    sudo chown -R 1000:1000 "${HOME}"/.ssh/* # make sure all filex own by normal user
    sudo chmod 0700 "${HOME}"/.ssh
    sudo chmod 0600 "${HOME}"/.ssh/*
    sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
    # do not forget to ln a *.pub as authorized_keys as login pub key
}

main_microsoft() {
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 0644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo rm microsoft.gpg
}
main_vscode() {
    main_microsoft
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    ## Install
    sudo apt update
    sudo apt install -y code
}
main_msedge() {
    ## Setup
    main_microsoft
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
    ## Install
    sudo apt update
    sudo apt install -y microsoft-edge-dev
}
main_intelmkl() {
    local origin="$(pwd)"
    mkdir -p ./intelmkl
    cd ./intelmkl
    wget -O ./intelmkl.pub \
        "https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB" \
        --user-agent="${USER_AGENT}" \
        --no-check-certificate
    sudo install -o root -g root -m 0644 intelmkl.gpg /etc/apt/trusted.gpg.d/
    echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
    # or `sudo add-apt-repository "deb https://apt.repos.intel.com/oneapi all main"`
    sudo apt update
    sudo apt install -y intel-oneapi-mkl intel-oneapi-mkl-devel
    cd "${origin}"
    rm -rf ./intelmkl
}
main_vmware() {
    #only for vmware
    sudo apt install -y open-vm-tools
    # sudo apt install open-vm-tools-dkms -y
    sudo apt install -y open-vm-tools-desktop
    {
        proxychains4 git clone https://github.com/rasa/vmware-tools-patches.git
        cd vmware-tools-patches
        . ./setup.sh
        ./download-tools.sh latest
        ./untar-and-patch.sh
        ./compile.sh
    }
    {
        sudo modprobe vmhgfs #检测是否存在
        lsmod | grep vmhgfs
        sudo mkdir /mnt/hgfs #不存在要用接下来两条挂载
        sudo mount -t vmhgfs .host:/ /mnt/hgfs
    }
}
main_podman(){
    sudo apt-get install podman
    sudo apt-get install dbus-user-session
    podman --version
    podamn run hello-world
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
