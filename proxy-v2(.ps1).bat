@echo off
setlocal
set SSLOCAL_VERSION=1.24.0
set SSLOCAL_ZIP=shadowsocks-v%SSLOCAL_VERSION%.x86_64-pc-windows-msvc.zip
set SSLOCAL_URL=https://github.com/shadowsocks/shadowsocks-rust/releases/download/v%SSLOCAL_VERSION%/%SSLOCAL_ZIP%

rem Check if sslocal.exe exists
if not exist "sslocal.exe" (
    echo sslocal.exe not found
    
    echo Downloading Shadowsocks %SSLOCAL_VERSION%...
    curl -L -o "%SSLOCAL_ZIP%" "%SSLOCAL_URL%"
    if errorlevel 1 (
        echo ERROR: Failed to download Shadowsocks!
        pause
        exit /b 1
    )
    echo Download complete
    
    rem Extract zip
    echo Extracting Shadowsocks...
    tar -xf "%SSLOCAL_ZIP%"
    if errorlevel 1 (
        echo ERROR: Failed to extract Shadowsocks!
        pause
        exit /b 1
    )
    
    rem Clean up
    del "%SSLOCAL_ZIP%"
    
    echo Extraction complete
)

rem Check if config.json exists
if not exist "config.json" (
    echo ERROR: config.json not found! Please create config file.
    echo You can create a config.json with your Shadowsocks server settings.
    pause
    exit /b 1
)

rem Launch PowerShell script with proper cleanup handling
powershell -ExecutionPolicy Bypass -NoExit -Command "& {
    $ErrorActionPreference = 'Stop'
    
    function Disable-Proxy {
        Write-Host 'Disabling system proxy...' -ForegroundColor Yellow
        $regPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
        Set-ItemProperty -Path $regPath -Name ProxyEnable -Value 0
        Remove-ItemProperty -Path $regPath -Name ProxyServer -ErrorAction SilentlyContinue
        Add-Type -TypeDefinition 'using System;using System.Runtime.InteropServices;public class W{[DllImport(\"wininet.dll\")]public static extern bool InternetSetOption(IntPtr h,int o,IntPtr b,int l);public static void R(){InternetSetOption(IntPtr.Zero,39,IntPtr.Zero,0);InternetSetOption(IntPtr.Zero,37,IntPtr.Zero,0);}}'; [W]::R()
    }
    
    function Stop-Shadowsocks {
        Write-Host 'Stopping Shadowsocks...' -ForegroundColor Yellow
        Get-Process -Name 'sslocal' -ErrorAction SilentlyContinue | Stop-Process -Force
    }
    
    function Cleanup {
        Disable-Proxy
        Stop-Shadowsocks
        Write-Host 'Cleanup complete!' -ForegroundColor Green
    }
    
    try {
        Write-Host 'Starting Shadowsocks client...' -ForegroundColor Cyan
        $proc = Start-Process -FilePath 'sslocal.exe' -ArgumentList '-c', 'config.json' -WindowStyle Hidden -PassThru
        Start-Sleep -Seconds 1
        
        if ($proc.HasExited) {
            Write-Host '[ERROR] Shadowsocks failed to start! Check config.json' -ForegroundColor Red
            Read-Host 'Press Enter to exit'
            exit 1
        }
        
        Write-Host '[OK] Shadowsocks is running' -ForegroundColor Green
        
        Write-Host 'Enabling system proxy...' -ForegroundColor Cyan
        $regPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'
        Set-ItemProperty -Path $regPath -Name ProxyEnable -Value 1
        Set-ItemProperty -Path $regPath -Name ProxyServer -Value '127.0.0.1:1080'
        Add-Type -TypeDefinition 'using System;using System.Runtime.InteropServices;public class W{[DllImport(\"wininet.dll\")]public static extern bool InternetSetOption(IntPtr h,int o,IntPtr b,int l);public static void R(){InternetSetOption(IntPtr.Zero,39,IntPtr.Zero,0);InternetSetOption(IntPtr.Zero,37,IntPtr.Zero,0);}}'; [W]::R()
        
        Write-Host ''
        Write-Host '========================================' -ForegroundColor Green
        Write-Host ' Proxy enabled on 127.0.0.1:1080' -ForegroundColor Green
        Write-Host ' Close window to stop (auto-cleanup)' -ForegroundColor Yellow
        Write-Host '========================================' -ForegroundColor Green
        Write-Host ''
        
        Read-Host 'Press Enter to stop'
        
    } finally {
        Cleanup
        Start-Sleep -Seconds 2
    }
}"

endlocal
exit
