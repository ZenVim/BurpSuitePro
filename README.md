# Burp Suite Professional Setup Guide

This repository contains Burp Suite Professional setup files for Windows.

## Prerequisites

- Windows 10/11
- PowerShell
- Internet connection (for downloading Java and Burp Suite)

## Quick Start

### Option 1: Latest Version (Recommended)

Navigate to the `BurpSuitePro-Latest` folder and run the installation script:

- Open `Powershell` as administrator and execute below command.

```powershell
cd BurpSuitePro-Latest
Set-ExecutionPolicy -ExecutionPolicy bypass -Scope process
.\Install.ps1
```

The script will automatically:
- Download and install JDK-21 (if not already installed)
- Download and install JRE-8 (if not already installed)
- Download the latest Burp Suite Professional version
- Set up launcher scripts and shortcuts
- Handle activation

### Option 2: Version 1.7.37

If you prefer the older 1.7.37 version, use the files in `BurpSuitePro-1.7.37/`.

## After Installation

1. **Start Menu Shortcut**: A shortcut will be created in your Start Menu Programs folder
2. **Activation**: The script will launch both the license key generator and Burp Suite Professional
3. **Complete Activation**: Follow the on-screen prompts in the opened windows to complete activation

## File Structure

```
BurpSuitePro/
├── BurpSuitePro-Latest/          # Latest version setup files
│   ├── Install.ps1               # Main installation script
│   ├── loader.jar                # Java agent for activation
│   ├── icon64pro.ico             # Application icon
│   └── README.md                 # Detailed documentation
│
└── BurpSuitePro-1.7.37/          # Legacy version 1.7.37
    └── (version-specific files)
```

## Troubleshooting

- **Java not found**: The script automatically downloads and installs JDK-21 and JRE-8
- **Download failures**: Check your internet connection and try running the script again
- **Activation issues**: Ensure you run the script as Administrator if you encounter permission errors

## References

- Original project: https://github.com/xiv3r/Burpsuite-Professional
- PortSwigger: https://portswigger.net/burp

---

**Note**: This tool is intended for educational and authorized security testing purposes only.
