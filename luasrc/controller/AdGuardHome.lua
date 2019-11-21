module("luci.controller.AdGuardHome",package.seeall)
function index()
if not nixio.fs.access("/etc/config/AdGuardHome")then
return
end
	entry({"admin", "services", "AdGuardHome"},alias("admin", "services", "AdGuardHome", "overview"), _("AdGuard Home"), 30).dependent = false
	entry({"admin", "services", "AdGuardHome", "overview"},cbi("AdGuardHome/overview"),_("Overview"), 10).leaf = true
	entry({"admin", "services", "AdGuardHome", "update"},cbi("AdGuardHome/update"),_("Update"), 20).leaf = true


	entry({"admin", "services", "AdGuardHome"},cbi("AdGuardHome"),_("AdGuard Home"),30).dependent=true
	entry({"admin", "services", "AdGuardHome","status"},call("act_status")).leaf=true
end 

function act_status()
	local e={}
	e.running=luci.sys.call("pgrep -f AdGuardHome/AdGuardHome >/dev/null")==0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
