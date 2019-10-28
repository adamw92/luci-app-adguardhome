# luci-app-adguardhome
简单的AdGuardHome的openwrt启动和停止界面，AdGuardHome默认安装位置为/etc/AdGuardHome

从AdGuardHome[官方releases页面](https://github.com/AdguardTeam/AdGuardHome/releases)，根据路由器架构选择对应压缩包下载，解压至/etc/AdGuardHome并授予775权限即可。 

注意：未内置配置文件，AdGuardHome运行后在luci页面点击web快捷管理方式即可打开AdGuardHome网页，根据指引完成配置即可。修改上游DNS、Bootstrap DNS及过滤器均可通过AdGuardHome网页完成。

AdGuardHome运行文件、配置文件AdGuardHome.yaml、data等全部位于/etc/AdGuardHome目录下，固件升级时直接备份该文件夹即可。如AdGuardHome自身有版本升级，通过AdGuardHome网页即可一键完成。

