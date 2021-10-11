FROM ubuntu:focal

LABEL maintainer="Certseeds <51754303+Certseeds@users.noreply.github.com>"

ARG USER_AGENT="Mozilla/5.0 (X11;U;Linux i686;en-US;rv:1.9.0.3) Geco/2008092416 Firefox/3.0.3" \
    UBUNTU_VERSION="focal" \
    USERNAME="nanoseeds" \
    GCC_NOW_VERSION="9" \
    GCC_NEWEST_VERSION="11" \
    CMAKE_VERSION="3.20.5-0kitware1ubuntu20.04.1"

RUN  echo "deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list \
  && echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list \
  && apt-get update && apt-get upgrade -y && apt-get install apt-utils openssh-client openssh-server zsh -y \
  && apt-get -y install git build-essential manpages-dev \
    make ffmpeg libssl-dev openssl net-tools vim xclip \
    curl wget screen gdb zip tree neofetch transmission \
  && apt-get install -y \
    proxychains4 exiftool rename aria2 manpages-dev keychain \
    lsb-core openssh-client openssh-server traceroute htop pigz \
  && apt-get install -y software-properties-common \
  && apt-get install -y apt-transport-https ca-certificates gnupg 

RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y \
  &&  apt-get update \
  &&  apt-get install -y gcc-"${GCC_NEWEST_VERSION}" g++-"${GCC_NEWEST_VERSION}" \
  && gcc-"${GCC_NEWEST_VERSION}" --version \
  &&  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_NEWEST_VERSION} 1110 \
  &&  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_NOW_VERSION} 930 \
  &&  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_NEWEST_VERSION} 1110 \
  &&  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_NOW_VERSION} 930 

RUN  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null \
  | gpg --dearmor - \
  | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \
  && echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main" \
  | tee /etc/apt/sources.list.d/kitware.list >/dev/null \
  && apt-get update  \
  && rm /usr/share/keyrings/kitware-archive-keyring.gpg \
  && apt-get install kitware-archive-keyring \
  && echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal-rc main" \
  | tee -a /etc/apt/sources.list.d/kitware.list >/dev/null \
  && apt-get update  \
  && apt-get -y install cmake-data="${CMAKE_VERSION}" cmake="${CMAKE_VERSION}" \
  && apt-mark hold cmake cmake-data

RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add \
  && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
  && add-apt-repository ppa:openjdk-r/ppa -y \
  && apt-get update -y \
  && apt-get install -y openjdk-8-jdk \
  && apt-get install -y openjdk-11-jdk \
  && apt-get install -y openjdk-17-jdk \
  && apt-get install -y maven gradle ant

RUN  add-apt-repository ppa:longsleep/golang-backports -y \
  && apt-get update -y \
  && apt-get install -y golang-go

RUN  echo "Port 22" > /etc/ssh/sshd_config \
  && echo "ListenAddress 0.0.0.0" >> /etc/ssh/sshd_config \
  && echo "PubkeyAuthentication no" >> /etc/ssh/sshd_config \
  && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
  && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
  && echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config \
  && echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config \
  && echo "UsePAM yes" >> /etc/ssh/sshd_config \
  && echo "X11Forwarding yes" >> /etc/ssh/sshd_config \
  && echo "TCPKeepAlive yes" >> /etc/ssh/sshd_config \
  && echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config \
  && echo "ClientAliveCountMax 100" >> /etc/ssh/sshd_config \
  && echo "UseDNS no" >> /etc/ssh/sshd_config \
  && echo "AcceptEnv LANG LC_*" >> /etc/ssh/sshd_config \
  && echo "Subsystem       sftp    /usr/lib/openssh/sftp-server" >> /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd \
  && LANG="zh_SG.UTF-8"

RUN  useradd "${USERNAME}" -m -g sudo -s /usr/bin/zsh \
  && echo "${USERNAME}:${USERNAME}" | chpasswd

RUN  echo '[user]\n\
    name = Certseeds\n\
    email = 51754303+Certseeds@users.noreply.github.com\n\
    signingkey = *\n\
[commit]\n\
    template = ~/.gitcommit\n\
    #gpgsign = true\n\
[alias]\n\
    commits = commit -s\n\
    checkoutb = checkout -b\n\
    mergeno = merge --no-ff\n\
[core]\n\
    editor = vim\n\
    autocrlf = input\n\
    ignorecase = false\n\
[gui]\n\
    encoding = utf-8\n\
[i18n]\n\
    commitencoding = utf-8\n\
    logoutputencoding = utf-8\n\
[init]\n\
  defaultBranch = master\n\
' > "/home/${USERNAME}/.gitconfig" \
  && echo '</subject>\n\
\n\
Branch:\n\
\n\
<type>:\n\
- [ ] Bug fix\n\
- [ ] Bug fix (Test)\n\
- [ ] New feature\n\
- [ ] Breaking change\n\
- [ ] Documentation update\n\
- [ ] This change requires a documentation update\n\
\n\
<body>\n\
\n\
<footer>' > "/home/${USERNAME}/.gitcommit" \
  && echo 'channels:\n\
  - defaults\n\
show_channel_urls: true\n\
channel_alias: http://mirrors.tuna.tsinghua.edu.cn/anaconda\n\
default_channels:\n\
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main\n\
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r\n\
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2\n\
custom_channels:\n\
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud\n\
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud\n\
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud\n\
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud\n\
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud\n\
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud\n\
  ' > "/home/${USERNAME}/.condarc" \
&& echo 'set nocompatible\n\
syntax on\n\
set showmode\n\
set showcmd\n\
set mouse=a\n\
set encoding=utf-8\n\
set t_Co=256\n\
filetype indent on\n\
set autoindent\n\
set shiftwidth=4\n\
set tabstop=2\n\
set expandtab\n\
set softtabstop=2\n\
set number\n\
set relativenumber\n\
set cursorline\n\
set textwidth=80\n\
set wrap\n\
set showmatch\n\
set hlsearch\n\
set incsearch\n\
set ignorecase\n\
set smartcase\n\
set spell spelllang=en_us\n\
set undofile\n\
set backup\n\
set swapfile\n\
set noerrorbells\n\
set visualbell\n\
set autoread\n\
set listchars=tab:»■,trail:■\n\
set list\n\
set wildmenu\n\
set wildmode=longest:list,full\n\
'  > "/home/${USERNAME}/.vimrc" \
  && mkdir -p "/home/${USERNAME}/.cargo" \ 
  && echo '[cargo-new]\n\
name = "Certseeds"    # name to use in `authors` field\n\
email = "Certseeds <51754303+Certseeds@users.noreply.github.com>"\n\
vcs = "git"\n\
\n\
[source.crates-io]\n\
registry = "https://github.com/rust-lang/crates.io-index"\n\
\n\
replace-with = 'tuna'\n\
[source.tuna]\n\
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"\n\
\n\
#replace-with = 'ustc'\n\
#[source.ustc]\n\
#registry = "git://mirrors.ustc.edu.cn/crates.io-index"\n\
\n\
[net]\n\
git-fetch-with-cli = true\n\
'  > "/home/${USERNAME}/.cargo/config" \
  && mkdir -p "/home/${USERNAME}/.gradle" \ 
  && echo 'String MAVEN_ALIYUN = 'http://maven.aliyun.com/nexus/content/groups/public'\n\
\n\
allprojects {\n\
    buildscript {\n\
    repositories {\n\
        mavenCentral()\n\
        maven { url 'https://maven.aliyun.com/repository/jcenter' }\n\
        maven { url 'https://maven.aliyun.com/repository/google' }\n\
        maven { url 'https://maven.aliyun.com/repository/central' }\n\
        maven { url 'https://maven.aliyun.com/repository/gradle-plugin' }\n\
    }\n\
    }\n\
\n\
    repositories {\n\
    mavenCentral()\n\
    maven { url 'https://maven.aliyun.com/repository/jcenter' }\n\
    maven { url 'https://maven.aliyun.com/repository/google' }\n\
    maven { url 'https://maven.aliyun.com/repository/central' }\n\
    maven { url 'https://maven.aliyun.com/repository/gradle-plugin' }\n\
    }\n\
}\n\' > "/home/${USERNAME}/.gradle/init.gradle" \
  && mkdir "/home/${USERNAME}/.pip" \
  && mkdir "/home/${USERNAME}/.m2" \
  && echo "[global]\n\
index-url = https://mirrors.aliyun.com/pypi/simple/\n\
extra-index-url = https://pypi.mirrors.ustc.edu.cn/simple/\n\
trusted-host =\n\
    pypi.douban.com\n\
    pypi.tuna.tsinghua\n\
    mirrors.aliyun.com\n\
    pypi.mirrors.ustc.edu.cn\n\
timeout = 120\n\
" > "/home/${USERNAME}/.pip/pip.conf" \
 && echo "<?xml version="1.0" encoding="UTF-8"?>\n\
\n\
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"\n\
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n\
      xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">\n\
\n\
  <pluginGroups>\n\
  </pluginGroups>\n\
\n\
  <proxies>\n\
  </proxies>\n\
  <servers>\n\
  </servers>\n\
  <mirrors>\n\
    <mirror>\n\
     <id>aliyunmaven</id>\n\
     <mirrorOf>central</mirrorOf>\n\
     <name>阿里云公共仓库</name>\n\
     <url>https://maven.aliyun.com/repository/central</url>\n\
    </mirror>\n\
    <mirror>\n\
      <id>repo1</id>\n\
      <mirrorOf>central</mirrorOf>\n\
      <name>central repo</name>\n\
      <url>http://repo1.maven.org/maven2/</url>\n\
    </mirror>\n\
    <mirror>\n\
     <id>aliyunmaven</id>\n\
     <mirrorOf>apache snapshots</mirrorOf>\n\
     <name>阿里云阿帕奇仓库</name>\n\
     <url>https://maven.aliyun.com/repository/apache-snapshots</url>\n\
    </mirror>\n\
  </mirrors>\n\
\n\
  <profiles>\n\
  </profiles>\n\
</settings>\n\
" > "/home/${USERNAME}/.m2/settings.xml"

RUN  chown -R "${USERNAME}:root" "/home/${USERNAME}/.condarc" \
  && chown -R "${USERNAME}:root" "/home/${USERNAME}/.cargo/config" \
  && chown -R "${USERNAME}:root" "/home/${USERNAME}/.gradle/init.gradle" \
  && chown -R "${USERNAME}:root" "/home/${USERNAME}/.pip/pip.conf" \
  && chown -R "${USERNAME}:root" "/home/${USERNAME}/.m2/settings.xml" \
  && chown -R "${USERNAME}:root" "/home/${USERNAME}/.vimrc" \
  && chown -R "${USERNAME}:root" "/home/${USERNAME}/.gitconfig" \
  && chown -R "${USERNAME}:root" "/home/${USERNAME}/.gitcommit"

COPY ./.oh-my-zsh /home/${USERNAME}/.oh-my-zsh

RUN  chsh -s "/usr/bin/zsh" \
  && usermod -s "/usr/bin/zsh" "root" \
  && usermod -s "/usr/bin/zsh" "${USERNAME}" \
  && chmod 0755 /home/${USERNAME}/.oh-my-zsh \
  && chmod 0755 /home/${USERNAME}/.oh-my-zsh/custom/plugins \
  && chmod 0755 /home/${USERNAME}/.oh-my-zsh/plugins \
  && chmod 0755 /home/${USERNAME}/.oh-my-zsh/plugins/z \
  && chmod 0755 /home/${USERNAME}/.oh-my-zsh/plugins/git \
  && chmod 0755 /home/${USERNAME}/.oh-my-zsh/plugins/zsh-autosuggestions \
  && chmod 0755 /home/${USERNAME}/.oh-my-zsh/plugins/zsh-syntax-highlighting \
  && chown -R "${USERNAME}:root" /home/${USERNAME}/.oh-my-zsh \
  && chown -R "${USERNAME}:root" /home/${USERNAME}/.oh-my-zsh/custom/plugins \
  && chown -R "${USERNAME}:root" /home/${USERNAME}/.oh-my-zsh/plugins \
  && chown -R "${USERNAME}:root" /home/${USERNAME}/.oh-my-zsh/plugins/z \
  && chown -R "${USERNAME}:root" /home/${USERNAME}/.oh-my-zsh/plugins/git \
  && chown -R "${USERNAME}:root" /home/${USERNAME}/.oh-my-zsh/plugins/zsh-autosuggestions \
  && chown -R "${USERNAME}:root" /home/${USERNAME}/.oh-my-zsh/plugins/zsh-syntax-highlighting

RUN  echo 'export ZSH="/home/${USERNAME}/.oh-my-zsh"' > "/home/${USERNAME}/.zshrc" \
  && echo 'ZSH_THEME="ys"\n\
HIST_STAMPS="yyyy-mm-dd"\n\
alias cp="cp -i"\n\
alias pcf="proxychains4"\n\
' >> "/home/${USERNAME}/.zshrc" \
  && echo 'plugins=(\n\
 git \n\
 z \n\
 zsh-syntax-highlighting\n\
 zsh-autosuggestions)\n\
\n\
source ${ZSH}/oh-my-zsh.sh\n\
' >> "/home/${USERNAME}/.zshrc" \
  && chown -R "${USERNAME}:root" /home/${USERNAME}/.zshrc \
  && ln -s /home/${USERNAME}/.oh-my-zsh /root/.oh-my-zsh

ENTRYPOINT service ssh restart && bash
