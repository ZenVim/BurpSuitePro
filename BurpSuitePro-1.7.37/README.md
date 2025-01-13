## Activated BurpSuite Professional 1.7.37 for Windows 10/11

NOTE: For BurpSuite Professional 1.7.37 version supports only `jdk-8u202-windows-x64.exe` if you have any other version uninstall it.

1. Open Command Prompt in the BurpSuitePro-1.7.37 folder
2. Install `[jdk-8u202-windows-x64.exe](https://javadl.oracle.com/webapps/download/GetFile/1.8.0_202-b08/1961070e4c9b4e26a04e7f5a083f551e/windows-i586/jdk-8u202-windows-x64.exe)`:
3. Install `[burpsuite_pro_v1.7.37.jar](https://portswigger-cdn.net/burp/releases/download?product=pro&version=1.7.37&type=Jar)`:
4. Paste this command in opned CMD Prompt and hit ENTER.
```
java -jar keygen.jar
```
5. Automatically using Powershell
```
Copy-Item "BurpSuite.lnk" "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\BurpSuite.lnk"
```


## Activated BurpSuite Professional 1.7.37 for Ubuntu

NOTE: For BurpSuite Professional 1.7.37 version supports only `jdk-8u202-linux-x64.tar.gz` if you have any other version uninstall it.

1. Open Terminal in the BurpSuitePro-1.7.37 folder
2. Install
```
https://javadl.oracle.com/webapps/download/GetFile/1.8.0_202-b08/1961070e4c9b4e26a04e7f5a083f551e/linux-i586/jdk-8u202-linux-x64.tar.gz

tar -xvf jdk-8u202-linux-x64.tar.gz

sudo mkdir -p /usr/lib/jvm
sudo mv jdk1.8.0_202 /usr/lib/jvm/

nano ~/.bashrc

export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_202
export PATH=$PATH:$JAVA_HOME/bin

source ~/.bashrc

java -version
```

3. Paste this command in opned Terminal and hit ENTER.
```
java -jar keygen.jar
```

4. Paste this command in opned CMD Prompt and hit ENTER.
```
java -Xbootclasspath/p:keygen.jar -jar burpsuite_pro_v1.7.37.jar
```
