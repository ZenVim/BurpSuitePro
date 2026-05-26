# Burp Suite Professional Installation Script
# This script installs required dependencies and sets up Burp Suite Professional

# Set progress preference to silent for faster downloads
Write-Host "Configuring download preferences..." -ForegroundColor Yellow
$ProgressPreference = 'SilentlyContinue'

# Check for administrator privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script must be run as Administrator. Please re-run with elevated privileges." -ForegroundColor Red
    exit 1
}

# Download and Install JDK-21
Write-Host "`nDownloading and installing JDK-21..." -ForegroundColor Cyan
$jdkUrl = "https://download.oracle.com/java/21/archive/jdk-21_windows-x64_bin.exe"
$jdkInstaller = "$env:TEMP\jdk-21_windows-x64_bin.exe"

try {
    Invoke-WebRequest -Uri $jdkUrl -OutFile $jdkInstaller -UseBasicParsing
    Write-Host "JDK-21 Downloaded. Starting installation process..." -ForegroundColor Green
    Start-Process -FilePath $jdkInstaller -ArgumentList "/s" -Wait -NoNewWindow
    Write-Host "JDK-21 installation completed!" -ForegroundColor Green
    Remove-Item $jdkInstaller -Force -ErrorAction SilentlyContinue
} catch {
    Write-Host "Error downloading/installing JDK-21: $_" -ForegroundColor Red
    Remove-Item $jdkInstaller -Force -ErrorAction SilentlyContinue
    exit 1
}

# Download and Install JRE-8
Write-Host "`nDownloading and installing JRE-8..." -ForegroundColor Cyan
$jreUrl = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=247947_0ae14417abb444ebb02b9815e2103550"
$jreInstaller = "$env:TEMP\jre-8.exe"

try {
    Invoke-WebRequest -Uri $jreUrl -OutFile $jreInstaller -UseBasicParsing
    Write-Host "JRE-8 Downloaded. Starting installation process..." -ForegroundColor Green
    Start-Process -FilePath $jreInstaller -Wait -NoNewWindow
    Write-Host "JRE-8 installation completed!" -ForegroundColor Green
    Remove-Item $jreInstaller -Force -ErrorAction SilentlyContinue
} catch {
    Write-Host "Error downloading/installing JRE-8: $_" -ForegroundColor Red
    Remove-Item $jreInstaller -Force -ErrorAction SilentlyContinue
    exit 1
}

# Fetch latest Burp Suite Professional version from PortSwigger
Write-Host "`nFetching latest Burp Suite Professional version..." -ForegroundColor Cyan

try {
    $releasesResponse = Invoke-WebRequest `
        -Uri "https://portswigger.net/burp/releases#professional" `
        -UseBasicParsing `
        -ErrorAction Stop

    # Match full string: "Professional / Community 2026.4.3"
    $match = [regex]::Match(
        $releasesResponse.Content,
        'Professional \/ Community (20\d{2}\.\d+\.\d+)'
    )

    if ($match.Success) {
        # Capture only version number
        $burpSuiteVersion = $match.Groups[1].Value

        Write-Host "Latest version found: $burpSuiteVersion" -ForegroundColor Green
    }
    else {
        Write-Host "Could not parse version from PortSwigger releases page." -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "Failed to fetch PortSwigger releases page: $_" -ForegroundColor Red
    exit 1
}

# Download Burp Suite Professional
Write-Host "`nDownloading Burp Suite Professional $burpSuiteVersion..." -ForegroundColor Cyan
$burpSuiteJarFileName = "burpsuite_pro_v$burpSuiteVersion.jar"
$burpSuiteDownloadUrl = "https://portswigger.net/burp/releases/download?product=desktop&version=$burpSuiteVersion&type=Jar"

try {
    Invoke-WebRequest -Uri $burpSuiteDownloadUrl -OutFile $burpSuiteJarFileName -UseBasicParsing
    Write-Host "Burp Suite Professional downloaded successfully!" -ForegroundColor Green
} catch {
    Write-Host "Error downloading Burp Suite Professional: $_" -ForegroundColor Red
    exit 1
}

# Download Java agent loader component
Write-Host "`nDownloading Java agent loader component..." -ForegroundColor Cyan
$loaderJarFileName = "loader.jar"
try {
    Invoke-WebRequest -Uri "https://github.com/xiv3r/Burpsuite-Professional/raw/refs/heads/main/loader.jar" -OutFile $loaderJarFileName -UseBasicParsing
    Write-Host "Java agent loader component downloaded successfully!" -ForegroundColor Green
} catch {
    Write-Host "Error downloading Java agent loader component: $_" -ForegroundColor Red
    exit 1
}

# Create batch file for Burp Suite Professional execution
Write-Host "`nCreating Burp Suite Professional batch file..." -ForegroundColor Cyan
$burpSuiteBatchFileName = "BurpSuiteProfessional.bat"
if (Test-Path $burpSuiteBatchFileName) {
    Remove-Item $burpSuiteBatchFileName -Force
}
$installationDirectory = $PSScriptRoot
if ([string]::IsNullOrEmpty($installationDirectory)) {
    $installationDirectory = Get-Location
}
$javaCommand = "java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:`"$installationDirectory\$loaderJarFileName`" -noverify -jar `"$installationDirectory\$burpSuiteJarFileName`""
$javaCommand | Add-Content -Path $burpSuiteBatchFileName
Write-Host "Batch file created successfully!" -ForegroundColor Green

# Create VBScript file for background execution
Write-Host "`nCreating Burp Suite Professional launcher script..." -ForegroundColor Cyan
$burpSuiteLauncherScript = "BurpSuiteProfessional.vbs"
if (Test-Path $burpSuiteLauncherScript) {
    Remove-Item $burpSuiteLauncherScript -Force
}
Set-Content -Path $burpSuiteLauncherScript -Value "Set WshShell = CreateObject(`"WScript.Shell`")"
Add-Content -Path $burpSuiteLauncherScript -Value "WshShell.Run chr(34) & `"$installationDirectory\$burpSuiteBatchFileName`" & Chr(34), 0"
Add-Content -Path $burpSuiteLauncherScript -Value "Set WshShell = Nothing"
Write-Host "Launcher script created successfully!" -ForegroundColor Green

# Create Windows shortcut for Burp Suite Professional
Write-Host "`nCreating Windows shortcut..." -ForegroundColor Cyan
$launcherScriptPath = Join-Path $installationDirectory $burpSuiteLauncherScript
$iconFilePath = Join-Path $installationDirectory "icon64pro.ico"
$shortcutFileName = "BurpSuite Professional $burpSuiteVersion.lnk"
$shortcutFilePath = Join-Path $installationDirectory $shortcutFileName

try {
    $shellObject = New-Object -ComObject WScript.Shell
    $shortcutObject = $shellObject.CreateShortcut($shortcutFilePath)
    $shortcutObject.TargetPath = $launcherScriptPath
    $shortcutObject.WorkingDirectory = $installationDirectory
    $shortcutObject.IconLocation = $iconFilePath
    $shortcutObject.Description = "Burp Suite Professional $burpSuiteVersion"
    $shortcutObject.Save()
    Write-Host "Shortcut created successfully!" -ForegroundColor Green
    
    # Copy shortcut to Start Menu Programs folder
    Write-Host "`nCopying shortcut to Start Menu Programs folder..." -ForegroundColor Cyan
    $startMenuProgramsPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
    if (!(Test-Path $startMenuProgramsPath)) {
        New-Item -ItemType Directory -Path $startMenuProgramsPath -Force | Out-Null
    }
    $startMenuShortcutPath = Join-Path $startMenuProgramsPath $shortcutFileName
    Copy-Item -Path $shortcutFilePath -Destination $startMenuShortcutPath -Force
    Write-Host "Shortcut copied to Start Menu Programs folder!" -ForegroundColor Green
    Write-Host "You can now pin it to Start and Taskbar." -ForegroundColor Yellow
} catch {
    Write-Host "Error creating shortcut: $_" -ForegroundColor Red
}

# Reload Environment Variables
Write-Host "`nReloading Environment Variables..." -ForegroundColor Cyan
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
Write-Host "Environment variables reloaded!" -ForegroundColor Green

# Resolve java.exe path
$javaCmd = Get-Command java -ErrorAction SilentlyContinue
if ($javaCmd) {
    $javaExe = $javaCmd.Source
} else {
    Write-Host "java.exe not found in PATH. Ensure JDK-21 installed correctly." -ForegroundColor Red
    exit 1
}

# Starting activation process
Write-Host "`nStarting license key generator..." -ForegroundColor Cyan
try {
    Start-Process -FilePath $javaExe -ArgumentList "-jar `"$loaderJarFileName`"" -WindowStyle Hidden
    Write-Host "License key generator started!" -ForegroundColor Green
} catch {
    Write-Host "Error starting license key generator: $_" -ForegroundColor Red
    exit 1
}

Write-Host "`nStarting Burp Suite Professional..." -ForegroundColor Cyan
try {
    $javaArgs = @(
        "--add-opens=java.desktop/javax.swing=ALL-UNNAMED",
        "--add-opens=java.base/java.lang=ALL-UNNAMED",
        "--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED",
        "--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED",
        "--add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED",
        "-javaagent:$loaderJarFileName",
        "-noverify",
        "-jar",
        $burpSuiteJarFileName
    )
    Start-Process -FilePath $javaExe -ArgumentList $javaArgs -WindowStyle Hidden
    Write-Host "Burp Suite Professional started!" -ForegroundColor Green
    Write-Host "Please complete the activation process in the opened window." -ForegroundColor Yellow
} catch {
    Write-Host "Error starting Burp Suite Professional: $_" -ForegroundColor Red
}

Write-Host "`nInstallation and setup completed!" -ForegroundColor Green
Write-Host "You can launch Burp Suite Professional using the shortcut in Start Menu or from the installation directory." -ForegroundColor Yellow
