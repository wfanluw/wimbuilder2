call ACLRegKey Tmp_System
call ACLRegKey Tmp_Software
call ACLRegKey Tmp_Default
rem call ACLRegKey Tmp_Drivers

call RegCopy HKLM\Software\Classes\AppID
call ACLRegKey HKLM\Software\Classes\AppID

rem set "RunAs"="Interactive User" -* "RunAs"=""
for /F %%i IN ('Reg Query HKLM\Tmp_Software\Classes\AppID /s /f "Interactive User" ^|Findstr Tmp_Software') do (
  Reg Add "%%i" /v RunAs /d "" /F >nul 2>nul
)

call RegCopy HKLM\Software\Classes\CLSID
call RegCopy HKLM\Software\Classes\Interface
call RegCopy HKLM\Software\Classes\TypeLib
rem //-
call RegCopy HKLM\Software\Classes\Folder
call RegCopy HKLM\Software\Classes\themefile
call RegCopy HKLM\Software\Classes\SystemFileAssociations
rem //-
call RegCopy "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Svchost"
call RegCopy HKLM\Software\Microsoft\SecurityManager
call RegCopy HKLM\Software\Microsoft\Ole

rem // policymanager.dll need:
call RegCopy HKLM\Software\Microsoft\PolicyManager
rem call RegCopy HKLM\Software\Classes\Unknown

rem has high cost performance to copy all DriverDatabase items,
rem just 4MB SYSTEM size(608KB compressed)
call RegCopy SYSTEM\DriverDatabase
rem skip RegCopy in AddDrivers macro
set AddDrivers_TYPE=FILE

if "x%opt[build.registry.system]%"=="xmerge" (
    call RegCopy SYSTEM\ControlSet001
    set REGCOPY_SKIP_SYSTEM=1
)

call "%~dp0Catalog.bat"

pushd "%~dp0WoW64_Basic"
submain.bat
popd
