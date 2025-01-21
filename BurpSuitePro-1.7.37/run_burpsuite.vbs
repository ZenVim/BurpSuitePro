' Create a shell object
Set objShell = CreateObject("WScript.Shell")

' Define the Java executable path
javaPath = """C:\Program Files\Java\jdk1.8.0_202\bin\java.exe"""

' Construct the command
command = javaPath & " -Xbootclasspath/p:""C:/BurpSuitePro/BurpSuitePro-1.7.37/keygen.jar"" -jar ""C:/BurpSuitePro/BurpSuitePro-1.7.37/burpsuite_pro_v1.7.37.jar"""

' Run the command
objShell.Run command, 0, True

' Clean up
Set objShell = Nothing
