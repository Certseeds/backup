$script = {
    $appList =
    "nanaZip",
    "temurin8-jdk", "temurin11-jdk", "temurin17-jdk", "ant", "aria2",
    "cmake", "colortool",
    "dark", "dismplusplus",
    "everything", "exiftool", "eartrumpet"
    "gh", "github", "go", "git", "gradle"
    "innounp",
    "jetbrains-toolbox"
    "kotlin",
    "maven", "miniconda3", "mysql",
    "neatdownloadmanager", "neteasemusic", "nodejs-lts", "nvm",
    "officetoolplus", "oh-my-posh",
    "pdf-xchange-editor", "potplayer", "posh-git"
    "rufus", "rustup-msvc",
    "spacesniffer", "steam", "sudo", "SourceCodePro-NF", "Source-Han-Sans-SC", "Source-Han-Serif-SC",
    "unxutils",
    "which";
    #! do not use scoop install vscode, it's shim use cmd-code
    #! so wsl can not open code-remote-wsl
    # pay attention to install `git`, it will use it's own mingw's gpg
    $scoop_bucket_list = "extras", "java", "nerd-fonts", "dorado https://github.com/chawyehsu/dorado";
    #Main-function
    function main {
        #starting helper function
        update_scoop
        search
        install
    }

    function add_bucket {
        foreach ($item in $scoop_bucket_list) {
            scoop bucket add $item;
        }
    }

    #Helpers
    function update_scoop {
        scoop update
        scoop update *
    }
    function install {
        foreach ($item in $appList) {
            scoop install $item
        }
        scoop config aria2-enabled false
    }
    function search {
        foreach ($item in $appList) {
            scoop install $item
        }
    }
    function mysql_setting {
        Set-Location ~
        Set-Location ./scoop
        Set-Location ./persist
        Set-Location ./mysql
        Set-Location ./data
        sudo rm -rf ./*
        mysqld --initialize
        sudo mysqld.exe --install
        sudo net start mysql
    }
    function oh_my_posh {
        Install-Module -Name PSReadLine -Scope CurrentUser -Force
        Install-Module -Name DirColors -Scope CurrentUser -Force
        $PROFILE | Get-Member -Type NoteProperty
    }
    function install {
        set-executionpolicy remotesigned -scope currentuser
        iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    }
    function ssh_agent {
        Get-Service -Name ssh-agent | Set-Service -StartupType Automatic
    }
    function rustupsetup {
        rustup default stable
    }
    #Entry point
    main
}
#netsh winhttp set proxy 127.0.0.1:1080
Invoke-Command $script
