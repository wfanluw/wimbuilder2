rem Battery icon should be optional, skip now

call AddFiles %0 :end_files
goto :end_files

; Computer Management shortcut
\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Computer Management.lnk

; Battery icon should be optional, skip now
+ver < 0
; Battery icon - In Winre.wim inf: hidbatt.inf,cmbatt.inf - drivers: battc.sys,HidBatt.sys,CmBatt.sys - system32: umpo.dll,umpnpmgr.dll

\Windows\INF\battery.inf
\Windows\INF\c_battery.inf
@\Windows\System32\
batmeter.dll
+ver*

@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
+if "x%opt[shell.app]%"<>"xwinxshell"
+ver >= 17763
Microsoft-Windows-Client-Desktop-Required-Package*.cat
Microsoft-Windows-Client-Desktop-Required-WOW64-Package*.cat
+ver*
Microsoft-Windows-Client-Features-Package*.cat
Microsoft-Windows-Client-Features-WOW64-Package*.cat
-if

@\Windows\System32\

; resources for desktop background contextmenu
Display.dll
themecpl.dll

:end_files

rem fix blank shortcut icons
reg add HKLM\Tmp_Software\Policies\Microsoft\Windows\Explorer /v EnableShellShortcutIconRemotePath /t REG_DWORD /d 1 /f

rem Display, Personalize
if not "x%opt[build.registry.software]%"=="xfull" (
    call RegCopy HKLM\SOFTWARE\Classes\DesktopBackground\Shell
)

call X2X
call Explorer\submain.bat
call WinXShell\submain.bat
