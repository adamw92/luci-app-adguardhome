require("luci.sys")
require("luci.util")
local fs=require"nixio.fs"
local port=require"luci.model.uci".cursor()
local port=port:get("AdGuardHome","AdGuardHome","port")

mp = Map("AdGuardHome", translate("AdGuard Home"))
mp.description = translate("免费和开源，功能强大的全网络广告和跟踪程序拦截DNS服务器,支持DNS over TLS（DoT）和DNS over HTTPS（DoH）方式。")
mp:section(SimpleSection).template  = "AdGuardHome/AdGuardHome_status"

s = mp:section(TypedSection, "AdGuardHome")
s.anonymous=true
s.addremove=false

enabled = s:option(Flag, "enabled", translate("启用广告屏蔽"))
enabled.default = 0
enabled.rmempty = false

enabled =s:option(Value,"port",translate("管理端口"))
enabled.placeholder=3000
enabled.default=3000
enabled.datatype="port"
enabled.rmempty=false
enabled.description = translate("注:只为下面的网页快捷方式提供管理端口参数↓ 建议在进行首次配置时将网页管理页面监听端口设置为3000。 <br /><br /> <input type=\"button\" style=\"width:180px;border-color:Teal; text-align:center;font-weight:bold;color:Green;\" value=\"AdGuardHome Web\" onclick=\"window.open('http://'+window.location.hostname+':"..port.."/')\"/>")

local apply = luci.http.formvalue("cbi.apply")
 if apply then
     io.popen("/etc/init.d/AdGuardHome reload")
end

return mp
