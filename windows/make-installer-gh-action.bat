@echo off
cd %~dp0

:: Usage:
:: make-installer-gh-action.bat <burpfile> <version>

echo.
echo +--------------------------------+
echo ^|                             ^|
echo ^| BurpSuite Installer Builder ^|
echo ^|                             ^|
echo +--------------------------------+
echo.

:: Check if jdk is installed
if not exist "jdk/" goto JDKNotFound

echo [+] Using JDK from "jdk/":
type jdk\release | findstr "JAVA_"

echo [+] Looking for BurpSuite jar files...
if not [%1]==[] (set burpfile=%1) else (for %%i in (burpsuite_pro*.jar) do (set burpfile=%%i))

if not exist "%burpfile%" goto BurpNotFound


if not [%2]==[] (set version=%2) else (goto VersionNotFound)

:BuildInstaller
:: %version% = burpsuite version (XXXX.X.X, i.e 2022.3.9)
echo [+] BurpSuite "%burpfile%" version: %version%

echo [+] Creating Run-Burp.bat...
echo @echo off > Run-Burp.bat
echo cd %%~dp0 >> Run-Burp.bat
echo start .\jdk\bin\javaw.exe -noverify -javaagent:burploader.jar --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -jar burpsuite_pro.jar >> Run-Burp.bat

set dir_output=Build
echo [+] Creating Installer in "%dir_output%/"...

ISCC /Qp "/O%dir_output%" "/DBurpVersion=%version%" "/DBurpJarFile=%burpfile%" Installer.iss
if %errorlevel% neq 0 goto :CompilationError


echo [+] Done! Installer created in "%dir_output%/".

:: Proper exit
timeout 3 /nobreak >nul
call :Cleanup
exit 0

:: Error handling

:Cleanup
del /Q Run-Burp.bat
exit 0

:JDKNotFound
echo [!] JDK was not found in "jdk/". Aborting...
exit 1

:BurpNotFound
echo [!] BurpSuite jar file not found. Please place the jar file in the same directory as this script.
exit 1

:VersionNotFound
echo [!] BurpSuite jar version not found.
exit 1

:CompilationError
echo [!] Error while compiling the installer. Aborting...
call :Cleanup
exit 1