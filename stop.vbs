' 解药：尽量关掉「小惊喜.vbs」拉起的窗口（先关资源管理器/设置类宿主，再按进程名结束常见附属程序）
' 说明：会关闭当前用户所有已打开的资源管理器文件夹窗口；会结束整机的 calc/notepad 等同名进程（若你正开着别的记事本也会被关掉）。不结束桌面主 explorer.exe。
On Error Resume Next
Dim sh, w, ws, im, procList, i

' 1) 关掉 Shell 里可枚举的窗口（主要是「此电脑」类文件夹、部分控制面板宿主）
Set sh = CreateObject("Shell.Application")
For Each w In sh.Windows
  On Error Resume Next
  w.Quit
Next

WScript.Sleep 400

' 2) 结束与「小惊喜」列表对应的进程（与 小惊喜.vbs 中 Array 第一项一致）
Set ws = CreateObject("WScript.Shell")
procList = Array( _
  "calc.exe", "notepad.exe", "mspaint.exe", "charmap.exe", "osk.exe", "magnify.exe", _
  "SnippingTool.exe", "snippingtool.exe", "winver.exe", "write.exe", "dxdiag.exe", _
  "msinfo32.exe", "narrator.exe", "stikynot.exe", "psr.exe", "dccw.exe", "tabtip.exe", _
  "presentationsettings.exe", "displayswitch.exe", "mblctr.exe", "dvdplay.exe", _
  "wmplayer.exe", "wab.exe", "eudcedit.exe", "sigverif.exe", "hh.exe", "msedge.exe", _
  "gpresult.exe", "whoami.exe", "tasklist.exe", "ipconfig.exe", "ping.exe", "tracert.exe", _
  "nslookup.exe", "netstat.exe", "getmac.exe", "hostname.exe", "clip.exe", _
  "mmc.exe", "resmon.exe", "perfmon.exe", "SystemSettings.exe" _
)

For i = 0 To UBound(procList)
  im = procList(i)
  ws.Run "cmd /c taskkill /F /IM """ & im & """ /T 2>nul", 0, True
Next

' 3) 不结束 rundll32：颜色/声音等 CPL 若仍开着，请在任务栏对应窗口手动关闭，或注销/重启后再试。

' 结束
