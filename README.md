# Shadowsocks Windows Starter

A simple and reliable way to launch Outline VPN (shadowsocks) on Windows with just a double-click. 

No heavy, complicated GUI clients or any installations are needed.

## What it does

• Starts `sslocal.exe`

• Enables system-wide proxy on `127.0.0.1:1080`  

• Keeps the proxy active while the cmd window is open  

• On key press, disables proxy and terminates `sslocal.exe`

## Required file structure
```
|shadowsocks
├── proxy.bat
├── config.json
└── sslocal.exe
```

## Quick guide

1. Download Shadowsocks-Rust for Windows (MSVC version):  
   [https://github.com/shadowsocks/shadowsocks-rust/releases](https://github.com/shadowsocks/shadowsocks-rust/releases)  
2. Place `sslocal.exe`, `proxy.bat` and `config.json` in the same folder  
3. Obtain your Outline Access Key — it should look like: 
   https://example.com/en/abc123/xyz456#abc123  
4. Edit it to start with `https://` instead of `ssconf://`:  
   `https://example.com/en/abc123/xyz456#abc123`  
5. Open the link in your browser — you’ll see a VPN config in JSON format 
6. Fill the corresponding lines in the 'config.json' with info from your browser (the "prefix" field is not needed). Save the file. 
7. Run `proxy.bat` (preferably as Administrator)

## Author:

by [@pavop02](https://github.com/pavop02)

## Keywords

shadowsocks, shadowsocks-rust, sslocal, vpn, proxy, windows, batch, batch-script, batch-file, vpn-client, script, starter, launcher
