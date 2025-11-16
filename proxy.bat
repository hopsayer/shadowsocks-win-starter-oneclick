@echo off
setlocal

rem Run shadowsocks locally in background
start "" /b .\sslocal.exe -c .\config.json

rem Wait to ensure that proxy is up
ping -n 1 127.0.0.1 >nul

rem Enable system proxy on 127.0.0.1:1080
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "127.0.0.1:1080" /f

echo System proxy enabled on 127.0.0.1:1080
echo PRESS ANY KEY TO QUIT PROPERLY

rem Wait for any key pressed
echo Press any key to disable system proxy 
pause >nul

rem Disable system proxy (setting it to default state)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f >nul 2>&1

echo System proxy disabled
taskkill /im sslocal.exe /f >nul 2>&1
endlocal
exit



