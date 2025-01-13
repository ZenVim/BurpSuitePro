## Activated BurpSuite Professional 2024.11.2 for Windows 10/11

NOTE: For BurpSuite Professional 2024.11.2 version supports only `jdk-21_windows-x64_bin.exe` if you have any other version uninstall it.

1. Open Command Prompt in the BurpSuitePro-2024.11.2 folder
2. Install `[jdk-21_windows-x64_bin.exe](https://download.oracle.com/java/21/archive/jdk-21_windows-x64_bin.exe)`:
3. Install `[burpsuite_pro_v2024.11.2.jar](https://portswigger-cdn.net/burp/releases/download?product=pro&version=2024.11.2&type=Jar)`:
4. Paste this command in opned Powershell and hit ENTER.
```
java -jar loader.jar
```
5. Automatically using Powershell
```
Copy-Item "BurpSuite Latest.lnk" "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\BurpSuite Latest.lnk"
```

## Refrences
- https://github.com/xiv3r/Burpsuite-Professional