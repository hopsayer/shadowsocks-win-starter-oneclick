rem Edit
@echo off
setlocal

rem Запускаем shadowsocks локально в фоне
start "" /b .\sslocal.exe -c .\config.json

rem Ждем 0.1 секунды, чтобы прокси поднялся
ping -n 1 127.0.0.1 >nul

rem Включаем системный прокси на 127.0.0.1:1080
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "127.0.0.1:1080" /f

echo System proxy enabled on 127.0.0.1:1080
echo In order to disable and exit, close this window.

rem Ждем нажатия любьой клавиши (окно на этом этапе закрывать не надо)
echo Press any key to disable system proxy 
pause >nul

rem Выключаем системный прокси (возвращаем в дефолт)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f >nul 2>&1

echo System proxy disabled
taskkill /im sslocal.exe /f >nul 2>&1
endlocal
exit

