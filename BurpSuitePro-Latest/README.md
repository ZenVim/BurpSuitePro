## Activated BurpSuite Professional for Windows 10/11

### Installation

Open Powershell as administrator and execute below command to set Script Execution Policy.
```
Set-ExecutionPolicy -ExecutionPolicy bypass -Scope process
```

```powershell
cd BurpSuitePro-Latest
.\Install.ps1
```

The script will automatically:
- Download and install JDK-21 (if not already installed)
- Download and install JRE-8 (if not already installed)
- Download the latest Burp Suite Professional version
- Set up launcher scripts and shortcuts
- Handle activation

## References
- https://github.com/xiv3r/Burpsuite-Professional
