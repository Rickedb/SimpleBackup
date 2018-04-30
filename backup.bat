@Echo off

net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Please run it with administator permissions!
    pause
    exit /b
)

powershell set-executionpolicy unrestricted
powershell -file %~dp0init.ps1
powershell set-executionpolicy restricted
pause