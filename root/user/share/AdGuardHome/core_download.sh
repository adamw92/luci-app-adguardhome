#!/bin/sh
#禁止多个实例
status=$(ps|grep -c /usr/share/AdGuardHome/core_download.sh)
[ "$status" -gt "3" ] && exit 0


START_LOG="/tmp/AdGuardHome_start.log"
LOGTIME=$(date "+%Y-%m-%d %H:%M:%S")
LOG_FILE="/tmp/AdGuardHome.log"
CPU_MODEL=$(uci get AdGuardHome.config.download_core 2>/dev/null)
   
if [ "$CPU_MODEL" != 0 ]; then
   echo "开始下载 AdGuardHome 内核..." >$START_LOG
   curl -fLO https://glare.now.sh/AdguardTeam/AdGuardHome/AdGuardHome_"$CPU_MODEL".tar.gz /tmp/AdGuardHome.tar.gz
   if [ "$?" -eq "0" ] && [ "$(ls -l /tmp/AdGuardHome.tar.gz |awk '{print int($5/1024)}')" -ne 0 ]; then
      tar zxvf /tmp/AdGuardHome.tar.gz -C /tmp >/dev/null 2>&1\
      && rm -rf /tmp/AdGuardHome.tar.gz >/dev/null 2>&1\
      && chmod 4755 /tmp/AdGuardHome\
      && chown root:root /tmp/AdGuardHome
      /etc/init.d/AdGuardHome stop
      echo "OpenClash 内核下载成功，开始更新..." >$START_LOG\
      && mv /tmp/AdGuardHome /etc/AdGuardHome/AdGuardHome >/dev/null 2>&1
      if [ "$?" -eq "0" ]; then
         /etc/init.d/AdGuardHome start
         echo "核心程序更新成功！" >$START_LOG
         echo "${LOGTIME} AdGuardHome Core Update Successful" >>$LOG_FILE
         sleep 5
         echo "" >$START_LOG
      else
         echo "核心程序更新失败，请确认设备闪存空间足够后再试！" >$START_LOG
         echo "${LOGTIME} AdGuardHome Core Update Error" >>$LOG_FILE
         sleep 5
         echo "" >$START_LOG
      fi
   else
      echo "核心程序下载失败，请检查网络或稍后再试！" >$START_LOG
      rm -rf /tmp/AdGuardHome.tar.gz >/dev/null 2>&1
      echo "${LOGTIME} AdGuardHome Core Update Error" >>$LOG_FILE
      sleep 10
      echo "" >$START_LOG
   fi
   else
      echo "未选择编译版本，请到全局设置中选择后再试！" >$START_LOG
      sleep 10
      echo "" >$START_LOG
   fi
