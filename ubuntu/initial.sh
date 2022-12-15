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
main_source() {
    # backup so
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup
    sudo cp "$(pwd)"/source_aliyun_1804.list /etc/apt/sources.list
    main_0
}
main_build() {
    sudo apt -y install git build-essential manpages-dev \
        make ffmpeg libssl-dev openssl net-tools vim xclip \
        curl wget screen gdb zip tree neofetch transmission \
        proxychains4 exiftool rename aria2 manpages-dev keychain \
        lsb-core openssh-client openssh-server traceroute htop pigz
}
main_newergcc() {
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
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
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
    sudo add-apt-repository "deb https://apt.kitware.com/ubuntu/ ${UBUNTU_VERSION} main" -y
    sudo apt update
    sudo apt-cache policy cmake
    sudo apt-cache policy cmake-data
    # CMAKE_VERSION="3.20.5-0kitware1ubuntu20.04.1" # for ubuntu 2004
    local CMAKE_VERSION="3.20.5-0kitware1" # for ubuntu 1804
    sudo apt -y install cmake-data="${CMAKE_VERSION}" cmake="${CMAKE_VERSION}"
    sudo apt-mark hold cmake cmake-data
}
main_python3() {
    sudo apt install -y python3-pip
    sudo pip3 install numpy
}
main_jdk_mvn() {
    sudo add-apt-repository ppa:openjdk-r/ppa -y
    sudo apt-get update
    sudo apt install -y openjdk-14-jdk openjdk-11-jdk openjdk-8-jdk maven gradle ant
    sudo update-alternatives --display java
    # sudo update-alternatives --config java
    # sudo update-alternatives --config javac
}
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
    wget https://repo.mysql.com//mysql-apt-config_0.8.19-1_all.deb
    sudo dpkg -i mysql-apt-config_0.*.****_all.deb
    sudo apt remove mysql-server # remove mysql-5.7
    sudo apt update
    sudo apt install mysql-server # remove mysql-8.0
    mysql --version
}
main_miniconda() {
    mkdir -p "${HOME}"/zsh_include
    local MINICONDA="Miniconda3-py39_4.9.2-Linux-x86_64.sh"
    wget -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/"${MINICONDA}" \
        --user-agent="${USER_AGENT}" \
        --no-check-certificate
    sudo chmod 0755 ./"${MINICONDA}"
    ./"${MINICONDA}"
    rm ./"${MINICONDA}"
}
main_conda() {
    conda create -n origin python=3.6
    conda create -n pytorch python=3.8
    conda condif --show
    conda update --all
    #   conda install pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=10.2 -c pytorch
}
main_anaconda() {
    # anaconda
    local ANACONDA="Anaconda3-2020.07-Linux-x86_64.sh"
    proxychains4 wget -c https://repo.anaconda.com/archive/"${ANACONDA}" \
        --user-agent="${USER_AGENT}" \
        --no-check-certificate
    sudo chmod 0755 ./"${ANACONDA}"
    sudo ./"${ANACONDA}"
    rm ./"${ANACONDA}"
    # TODO press enter && yes now
    # TODO source ~/.zshrc
}
main_nodejs() {
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt install -y nodejs
}
main_opencv3() {
    sudo apt install -y libopencv-dev
}
main_go() {
    # set go
    sudo add-apt-repository ppa:longsleep/golang-backports -y
    sudo apt update
    sudo apt install -y golang-go
}
main_pdftotext() {
    sudo apt install -y libpoppler-cpp-dev pkg-config
    pip3 install pdftotext            # then can import pdftotext
    sudo apt install -y poppler-utils # then can run `pdftotext`
}
main_texlive() {
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
main_githubcli() {
    sudo apt install -y software-properties-common
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
    sudo add-apt-repository https://cli.github.com/packages -y
    sudo apt update
    sudo apt install -y gh
}
main_ryus() {
    #download python2 and ryus
    sudo apt install -y python2 mininet python3-ryu iputils-arping -y
    #`python2` names `python` in ubuntu1804 and elders.
}
function main_linguist() {
    sudo apt install -y pkg-config libicu-dev zlib1g-dev libcurl4-openssl-dev libssl-dev ruby-dev
    gem sources --add https://mirrors.tuna.tsinghua.edu.cn/rubygems/ --remove https://rubygems.org/
    gem sources -l
    gem install github-linguist
    # now $(github-linguist --breakdown) can use
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
main_intelmkl() {
    local origin="$(pwd)"
    mkdir -p ./intelmkl
    cd ./intelmkl
    wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
        --user-agent="${USER_AGENT}" \
        --no-check-certificate
    sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
    echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
    # or `sudo add-apt-repository "deb https://apt.repos.intel.com/oneapi all main"`
    sudo apt update
    sudo apt install -y intel-oneapi-mkl intel-oneapi-mkl-devel
    cd "${origin}"
    rm -rf ./intelmkl
}
main_cuda() {
    #! FIRST, install driver!!
    # wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
    sudo cp cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
    # wget https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
    sudo apt install -y ./cuda/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
    sudo apt install -y ./cuda/cuda-repo-ubuntu1804-10-2-local_10.2.1-1_amd64.deb
    sudo apt install -y ./cuda/cuda-repo-ubuntu1804-10-2-local_10.2.2-1_amd64.deb
    sudo apt install -y ./cuda/libcudnn8_8.1.1.33-1+cuda10.2_amd64.deb
    sudo apt install -y ./cuda/libcudnn8-dev_8.1.1.33-1+cuda10.2_amd64.deb
    sudo apt-key add /var/cuda-repo-10-2-local-10.2.89-440.33.01/7fa2af80.pub
    sudo apt update
    sudo apt install -y cuda
}
main_caffe_ssd() {
    #! c***f is dead, do not use it anymore.
    sudo apt install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler \
        libopenblas-dev liblapack-dev libatlas-base-dev \
        libgflags-dev libgoogle-glog-dev liblmdb-dev
    sudo apt install -y --no-install-recommends libboost-all-dev
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
        sudo mkdir /mnt/hgfs　#不存在要用接下来两条挂载
        sudo mount -t vmhgfs .host:/ /mnt/hgfs
    }
}
main_graphcard() {
    # fuck `graphics-drivers`, it make 440 shortcut for 450, and 430 shortcut for 440, make drivers can not use at all.
    ls
    # fuck nvidia, in driver 440.100 does not match 440.33, can you believe?
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
