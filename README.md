# luci-app-adguardhome
简单的AdGuardHome的openwrt启动和停止界面，AdGuardHome默认安装位置为/adg/

从AdGuardHome[官方releases页面](https://github.com/AdguardTeam/AdGuardHome/releases)，根据路由器架构选择对应压缩包下载，在路由器根目录下建立adg文件夹，将压缩包中的文件解压并授予775权限即可。 

如果AdGuardHome安装至其他位置，请将/etc/init/AdGuardHome文件第8行BINLOADER_BIN="/adg/AdGuardHome"修改为你的安装位置。

注意：未内置配置文件，AdGuardHome首次运行后访问http:路由器ip:3000根据AdGuardHome指引即可完成配置。完成配置并登陆AdGuardHome网页后自行修改上游DNS、Bootstrap DNS及你需要的过滤器。

AdGuardHome运行文件、配置文件、data等全部位于/adg目录下，如AdGuardHome有升级，直接在AdGuardHome网页中点击升级即可。

建议修改AdGuardHome.yaml中的ratelimit数值，可以提高性能，可修改为0（不限制）或更大的数字，可参考官方wiki。
