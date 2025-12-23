# Shadowsocks Windows Starter

A simple and reliable way to launch Outline VPN (shadowsocks) on Windows with just a double-click.

No heavy, complicated GUI clients or any installations are needed.

## What it does

• **Automatically downloads** `sslocal.exe` on first run (if not present)

• Starts `sslocal.exe` in the background

• Enables system-wide proxy on `127.0.0.1:1080`

• Keeps the proxy active while the window is open

• **Auto-cleanup**: Disables proxy and terminates `sslocal.exe` when window is closed

## Quick guide

### Option 1: Automatic setup (recommended)

1. Download `proxy-v2(.ps1).bat` and `config.json` from this repository
2. Obtain your Outline Access Key — it should look like:
   `ssconf://example.com/en/abc123/xyz456#abc123`
3. Edit it to start with `https://` instead of `ssconf://`:  
   `https://example.com/en/abc123/xyz456#abc123`
4. Open the link in your browser — you'll see a VPN config in JSON format
5. Fill the corresponding lines in `config.json` with info from your browser (the "prefix" field is not needed). Save the file.
6. Run `proxy-v2(.ps1).bat` (preferably as Administrator)
7. On first run, **sslocal.exe will be downloaded automatically** (version 1.24.0)

### Option 2: Manual setup

If you prefer to download `sslocal.exe` manually:

1. Download Shadowsocks-Rust for Windows (MSVC version):  
   https://github.com/shadowsocks/shadowsocks-rust/releases
2. Extract `sslocal.exe` from the archive
3. Place `sslocal.exe`, `proxy-v2(.ps1).bat` and `config.json` in the same folder
4. Follow steps 2-6 from Option 1

## Features comparison

### New version: `proxy-v2(.ps1).bat`

-  **Auto-downloads** sslocal.exe if missing
-  **Auto-cleanup** when window is closed (no manual action needed)
-  Instant proxy activation (no browser restart required)
-  Validates files before running
-  Checks if process started successfully
-  Color-coded status messages
-  Works with double-click

### Old version: `proxy.bat` (legacy)

-  Requires manual download of sslocal.exe
-  Requires pressing a key to disable proxy
-  Basic error handling
-  Simple and lightweight

## Required file structure

### Minimal (with auto-download)
```
|proxy-folder
├── proxy-v2(.ps1).bat
└── config.json
```

### After first run
```
|proxy-folder
├── proxy-v2(.ps1).bat
├── config.json
└── sslocal.exe (auto-downloaded)
```

## Usage

1. Double-click `proxy-v2(.ps1).bat`
2. Wait for "Proxy enabled" message
3. Browse with VPN active
4. **Simply close the window** to stop - cleanup is automatic!

## Troubleshooting

**"sslocal.exe failed to start"**
- Check your `config.json` for typos
- Verify your Outline Access Key is still valid
- Try running as Administrator

**"Failed to download Shadowsocks"**
- Check your internet connection
- GitHub may be temporarily unavailable
- Try downloading manually from the [releases page](https://github.com/shadowsocks/shadowsocks-rust/releases)

## Author

by [@pavop02](https://github.com/pavop02)

## Keywords

shadowsocks, shadowsocks-rust, sslocal, vpn, proxy, windows, batch, batch-script, batch-file, vpn-client, script, starter, launcher, powershell, auto-download, auto-cleanup
