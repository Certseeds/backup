<!--
 * @Github: https://github.com/Certseeds/backup
 * @Author: nanoseeds
 * @Date: 2020-08-21 15:14:03
 * @LastEditors: nanoseeds
 * @License: CC-BY-NC-SA_V4_0 or any later version
 -->

# meaningless title

| Order |                            Action                            |
| :---: | :----------------------------------------------------------: |
|   0   |                            重装.                             |
|   2   |                 确认可以正常执行之后的流程。                 |
|   3   |                          设置浏览器                          |
|   4   | 安装scoop.`scoop install git`,设置,clone dotfiles库。 |
|   5   |                 安装vscode,开始记录装机过程.                 |
|   6   |           `scoop install diskplusplus`, 开始调系统           |
|   7   |                  安装fillder,解锁uwp的网络问题.                  |
|   8   |                安装一票uwp应用,顺带解锁网络问题。                |
|   9   |           `scoop install officetoolplus`,装office            |
|  10   |                         wsl settings                         |
|  11   |    `scoop install jetbrains-toolbox`,装clion,idea,etc...     |
|  12   |          `scoop install temurin8/11/17-jdk`,配idea           |
|  13   |             `scoop install miniconda3`,配pycharm             |
|  14   |                 `scoop install neteasemusic`                 |
|  15   |                   `scoop insatll gpg4win`                    |
|  16   |               `scoop install 7-zip potplayer`                |
|  17   |                     安装vmware,调虚拟机                      |

+ 会自动更新的(Edge,vscode,jetbrains),只用scoop的库里的下载的链接,自己安装.
+ 自己不更新的/不需要更新的/不想更新的,用scoop

## 更换系统

如果原有系统在另外一个盘里, 有很多东西可以复制过来, 不需要下载.

0. 装机
1. 开启windows更新, 后台更新系统+驱动.
2. login broswer, sync conf and config
3. 开bitlocker, 全盘加密先搞上.

``` log
login, and sync其他配置.

DnsOverHttpsMode: secure
DnsOverHttpsTemplates: https://doh.pub/dns-query
HubsSidebarEnabled: false
```

4. 把scoop复制过来

``` log
重装系统之前,先完整复制用户目录下的scoop文件夹到非系统盘
重装系统之后,将scoop文件夹粘贴回去用户目录
在环境变量设置中,新建一个用户变量,名字为SCOOP,值为当前scoop文件夹的地址,即:
> C:\Users\xxxx\scoop
允许脚本执行:
> set-executionpolicy remotesigned -s currentuser
双击用户变量中的path,新建一个路径,填入 :
> %SCOOP%\shims
管理员权限powershell中运行:
> scoop reset *
```

5. uwp应用

+ eartrumpet
+ ms-todo
+ windows-terminal

6. 把dotfiles复制过来, 上软链接.
7. 先把onedrive文件复制一个小文件, 开onedrive试一下, 然后决定是否复制全部的.
8. 装一下ide
+ java在scoop里面
+ clion需要wsl2里面的gcc
+ goland在scoop里面
+ pycharm在wsl2里面起podman-python
