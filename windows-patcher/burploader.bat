@echo off
setlocal EnableDelayedExpansion 
cd %~dp0

echo.
echo +-----------------------+
echo ^|                        ^|
echo ^|   BurpSuite Patcher    ^|
echo ^|                        ^|
echo +-----------------------+
echo.

:: Find Burp Suite
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\7318-9294-3757-1226" /v "InstallLocation"') DO set "BurpPath=%%B"

if exist %BurpPath% goto FoundPath

:PromptBurpPath
echo [!] Couldn't find BurpSuite path.
set /p BurpPath=Enter Path to Burp Suite installation:

:FoundPath
echo [+] Found Path: %BurpPath%
set OptionsFile=%BurpPath%\BurpSuitePro.vmoptions
set ActivationFilename=activation.vmoptions

:: Copy Keygen/Loader
echo [+] Copying Keygen-Loader to Path
copy burploader.jar %BurpPath%

:: Add Line to vmoptions
set line=-include-options %ActivationFilename%
type %OptionsFile% | findstr /C:"%line%" >nul
if %errorlevel% neq 0 echo %line% >> %OptionsFile%

:: Create new sub-vmoptions
echo -noverify >> %BurpPath%\%ActivationFilename%
echo -javaagent:burploader.jar >> %BurpPath%\%ActivationFilename%
echo --add-opens=java.base/java.lang=ALL-UNNAMED >> %BurpPath%\%ActivationFilename%
echo --add-opens=java.desktop/javax.swing=ALL-UNNAMED >> %BurpPath%\%ActivationFilename%
echo --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED >> %BurpPath%\%ActivationFilename%
echo --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED >> %BurpPath%\%ActivationFilename%
echo --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED >> %BurpPath%\%ActivationFilename%

echo [+] Use the keygen to register the program
start %BurpPath%\BurpSuitePro.exe
start %BurpPath%\jre\bin\javaw.exe -jar %BurpPath%\burploader.jar

echo [+] Done!
