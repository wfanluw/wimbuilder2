rem Call this by Projects\<ProjectName>\prepare.bat
if "x%~1"=="x" goto :EOF
call %1
goto :EOF

:BEFORE_WIM_BUILD
rem ===================================
if "x%opt[custom.cmd_mode]%"=="xtrue" (
    %opt[custom.cmd_mode_code]%
)
rem ===================================
goto :EOF

:BEFORE_WIM_MOUNT
rem ===================================

rem ===================================
goto :EOF

:BEFORE_HIVE_LOAD
rem ===================================

rem ===================================
goto :EOF
