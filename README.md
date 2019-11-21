# luci-app-adguardhome
[Download Luci ipk](https://github.com/adamw92/luci-app-adguardhome/releases/download/1.3.1/luci-app-adguardhome_1.3-1_all.ipk)

简单的AdGuardHome的OpenWrt启动和停止控制及主程序下载，AdGuardHome默认安装位置为/etc/AdGuardHome/，内置快捷方式可快速打开AdGuardHome Web页面。

安装luci后选择你的处理器构架点击下载，将会下载最新版本AdGuardHome主程序，为防止AdGuardHome出错，未对主程序进行压缩，部分机型可能没有足够的空间存放AdGuardHome主程序。

注意：luci不内置配置文件，AdGuardHome首次运行后在luci页面点击web快捷管理方式即可打开AdGuardHome网页，根据指引完成配置即可。修改上游DNS、Bootstrap DNS及过滤器均可通过AdGuardHome网页或直接修改AdGuardHome.yaml完成。
luci页面内的网页端口数只影响luci内置“AdGuardHome Web”快捷方式指向的端口号，如果您在前期指引中修改了网页端口号或直接修改了AdGuardHome.yaml中的端口号，请同步修改这里，避免网页快捷方式失效。

AdGuardHome主程序、配置文件AdGuardHome.yaml、data等全部位于/etc/AdGuardHome/目录下，固件升级时直接备份该文件夹即可。如AdGuardHome自身有版本升级，通过AdGuardHome网页即可一键完成。

建议修改AdGuardHome.yaml中的ratelimit数值，可以提高性能，可修改为0（不限制）或更大的数字，AdGuardHome.yaml更多配置信息可参考官方wiki。
