#!/bin/sh
#禁止多个实例
status=$(ps|grep -c /usr/share/AdGuardHome/core_download.sh)
[ "$status" -gt "3" ] && exit 0


START_LOG="/tmp/AdGuardHome_start.log"
LOGTIME=$(date "+%Y-%m-%d %H:%M:%S")
LOG_FILE="/tmp/AdGuardHome.log"
CPU_MODEL=$(uci get AdGuardHome.AdGuardHome.download_core)
   
if [ "$CPU_MODEL" != 0 ]; then
	echo "开始检测AdGuardHome 版本号..." >$LOG_FILE
	AdGuardHome_version=`wget -qO- "https://github.com/AdguardTeam/AdGuardHome/tags"| grep "/AdguardTeam/AdGuardHome/releases/tag/"| head -n 1| awk -F "/tag/v" '{print $2}'| sed 's/\">//'`
	echo "AdGuardHome最新版本为"$AdGuardHome_version"" 
	echo "开始下载 AdGuardHome 内核..." 
	wget-ssl --no-check-certificate https://github.com/AdguardTeam/AdGuardHome/releases/download/v"$AdGuardHome_version"/AdGuardHome_"$CPU_MODEL".tar.gz -O 2>&1 >1 /tmp/AdGuardHome.tar.gz
	if [ "$?" -eq "0" ]; then
		tar zxvf /tmp/AdGuardHome.tar.gz -C /tmp >/dev/null 2>&1\
		&& rm -rf /tmp/AdGuardHome.tar.gz >/dev/null 2>&1\
		&& chmod 4755 /tmp/AdGuardHome\
		&& chown root:root /tmp/AdGuardHome
		/etc/init.d/AdGuardHome stop
		echo "AdGuardHome 内核下载成功，开始更新..." 
		mv /tmp/AdGuardHome/* /etc/AdGuardHome/ >/dev/null 2>&1
	else
		echo "核心程序下载失败，请检查网络或稍后再试！" 
		rm -rf /tmp/AdGuardHome.tar.gz >/dev/null 2>&1
		echo "${LOGTIME} AdGuardHome Core Update Error" >>$LOG_FILE
		sleep 10
	
	fi
else
      echo "未选择编译版本，请到全局设置中选择后再试！" >$LOG_FILE
      sleep 10
fi
