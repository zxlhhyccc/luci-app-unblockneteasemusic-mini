-- Created By [CTCGFW]Project-OpenWrt
-- https://github.com/project-openwrt

mp = Map("unblockneteasemusic", translate("解除网易云音乐播放限制"))
mp.description = translate("原理：采用 [QQ/虾米/百度/酷狗/酷我/咕咪/JOOX] 等音源，替换网易云音乐 无版权/收费 歌曲链接\n由 [CTCGFW]Project-OpenWrt 提供服务器支持，来源: https://github.com/project-openwrt/luci-app-unblockneteasemusic-mini")

mp:section(SimpleSection).template = "unblockneteasemusic-mini/unblockneteasemusic_mini_status"

s = mp:section(TypedSection, "unblockneteasemusic-mini")
s.anonymous=true
s.addremove=false

enable = s:option(Flag, "enable", translate("启用本插件"))
enable.description = translate("启用本插件以解除网易云音乐播放限制")
enable.default = 0
enable.rmempty = false

download_certificate = s:option(Button,"download_certificate",translate("HTTPS 证书"))
download_certificate.inputtitle = translate("下载 CA 根证书")
download_certificate.description = translate("Linux/iOS/MacOSX设备在信任根证书后方可正常使用解锁功能。")
download_certificate.inputstyle = "apply"
download_certificate.write = function()
  	Download_Certificate()
end

function Download_Certificate()
	local t,e
	t=nixio.open("https://raw.githubusercontent.com/nondanee/UnblockNeteaseMusic/master/ca.crt","r")
	luci.http.header('Content-Disposition','attachment; filename="ca.crt"')
	luci.http.prepare_content("application/octet-stream")
	while true do
		e=t:read(nixio.const.buffersize)
		if(not e)or(#e==0)then
			break
		else
			luci.http.write(e)
		end
	end
	t:close()
	luci.http.close()
end

return mp
