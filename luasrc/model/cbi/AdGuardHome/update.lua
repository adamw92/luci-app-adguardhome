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
o:value("linux_386")
o:value("linux_amd64", translate("linux-amd64(x86-64)"))
o:value("linux_arm")
o:value("linux_arm64")
o:value("linux_mips")
o:value("linux_mipsle")
o:value("0", translate("Not Set"))


o = s:option(Button,"down_core")
o.title = translate("Download")
o.inputtitle = translate("Download")
o.description = translate("Download")
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