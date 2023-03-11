@echo off
echo [+] Deleting Burp's File Settings 
rd /s /q "%userprofile%\AppData\Roaming\BurpSuite\"
echo [+] Deleting Burp's Registry Settings 
reg delete "HKEY_CURRENT_USER\SOFTWARE\JavaSoft\Prefs\burp" /f
echo [+] Done!

:: Proper exit
timeout 3 /nobreak >nul