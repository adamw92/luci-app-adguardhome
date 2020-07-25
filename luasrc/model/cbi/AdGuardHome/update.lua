local NXFS = require "nixio.fs"
local SYS  = require "luci.sys"
local HTTP = require "luci.http"
local DISP = require "luci.dispatcher"
local UTIL = require "luci.util"
local uci = require("luci.model.uci").cursor()
local m

font_green = [[<font color="green">]]
font_off = [[</font>]]
bold_on  = [[<strong>]]
bold_off = [[</strong>]]


m = Map("AdGuardHome", translate("AdGuardHome默认安装位置为/etc/AdGuardHome/"))
m.pageaction = false
s = m:section(TypedSection, "AdGuardHome")
s.anonymous = true

local cpu_model=SYS.exec("opkg status libc 2>/dev/null |grep 'Architecture' |awk -F ': ' '{print $2}' 2>/dev/null")
o = s:option(ListValue, "download_core", translate("选择内核"))
o.description = translate("CPU Model")..': '..font_green..bold_on..cpu_model..bold_off..font_off..' '
o:value("linux_386", translate("Linux 32-bit"))
o:value("linux_amd64", translate("Linux 64-bit (x86-64)"))
o:value("linux_armv5", translate("32-bit ARMv5"))
o:value("linux_armv6", translate("32-bit ARMv6"))
o:value("linux_armv7", translate("32-bit ARMv7"))
o:value("linux_arm64", translate("64-bit ARMv8"))
o:value("linux_mips_softfloat", translate("32-bit MIPS"))
o:value("linux_mipsle_softfloat", translate("32-bit MIPSLE"))
o:value("linux_mips64_softfloat", translate("64-bit MIPS"))
o:value("linux_mips64le_softfloat", translate("64-bit MIPSLE"))
o:value("0", translate("Not Set"))


o = s:option(Button,"down_core")
o.title = translate("Download")
o.inputtitle = translate("Download")
o.description = translate("请选择CPU类型后点击下载，默认下载stable 版本，下载完成后请勾选启动广告屏蔽，保存并应用后，点击AdGuardHome Web按钮进行配置。后续更新请使用AdGuardHome Web控制页面进行更新。")
o.inputstyle = "reload"
o.write = function()
  m.uci:set("AdGuardHome", "config", "enable", 1)
  m.uci:commit("AdGuardHome")
  SYS.call("sh /usr/share/AdGuardHome/core_download.sh >>/tmp/AdGuardHome.log 2>&1 &")
  HTTP.redirect(DISP.build_url("admin", "services", "AdGuardHome", "update"))
end

local clog = "/tmp/AdGuardHome.log"
log = s:option(TextValue, "clog")
log.readonly=true
log.description = translate("")
log.rows = 15
log.wrap = "off"
log.cfgvalue = function(self, section)
	return NXFS.readfile(clog) or ""
end
log.write = function(self, section, value)
end

return m