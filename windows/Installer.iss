; Installs Burp Suite (burpsuite_pro.jar) and crack (burploader.jar) as a proper software with a proper icon, shortcut and sh$t.

#define ApplicationName "Burp Suite Professional"

; Should be declared at runtime "/DBurpVersion=2022.3.9"
#ifndef BurpVersion
    #define BurpVersion ""
#endif

; Should be declared at runtime "/DBurpJarFile=<jar path>"
#ifndef BurpJarFile
    #define BurpJarFile "burpsuite_pro.jar"
#endif

#define ApplicationPublisher "PortSwigger Web Security"
#define ApplicationURL "https://portswigger.net/"
#define InstallerVersion "1.0.0.0"


[Setup]
AppId={{3C74456C-FE96-4E99-92AD-8A32E8A347AC}}
AppName={#ApplicationName}
AppVersion={#BurpVersion}
PrivilegesRequired=lowest
VersionInfoProductName={#ApplicationName}
AppCopyright={#ApplicationPublisher}
VersionInfoVersion={#InstallerVersion}
AppVerName={#ApplicationName} {#BurpVersion}
AppPublisher={#ApplicationPublisher}
AppPublisherURL={#ApplicationURL}
AppSupportURL={#ApplicationURL}
AppUpdatesURL={#ApplicationURL}
DefaultDirName={autopf}\{#ApplicationName}
DefaultGroupName={#ApplicationName}
InfoAfterFile=Post-Info.txt
SetupIconFile=burp-suite-professional.ico
UsePreviousAppDir=yes
DisableProgramGroupPage=auto
OutputBaseFilename=burpsuite_pro_windows_x64_v{#BurpVersion}
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; 
Name: "startmenu"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Dirs]
Name: "{app}\jdk";

[Files]

; JDK Folder
Source: "jdk\*"; DestDir: "{app}\jdk"; Flags: ignoreversion recursesubdirs nocompression

; Burp Suite jar file
Source: "{#BurpJarFile}"; DestDir: "{app}"; DestName: "burpsuite_pro.jar"; Flags: ignoreversion nocompression

; Burp Loader jar file
Source: "burploader.jar"; DestDir: "{app}"; Flags: ignoreversion

; Burp Reset settings file
Source: "reset-burp-settings.bat"; DestDir: "{app}"; Flags: ignoreversion

; Icon file
Source: "burp-suite-professional.ico"; DestDir: "{app}"; Flags: ignoreversion

; Run .bat file
Source: "Run-Burp.bat"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#ApplicationName}"; Filename: "{app}\Run-Burp.bat"; WorkingDir: "{app}"; IconFilename: "{app}\burp-suite-professional.ico"; Tasks: startmenu desktopicon
Name: "{autoprograms}\{#ApplicationName} Keygen"; Filename: "{app}\jdk\bin\javaw.exe"; Parameters: "-jar burploader.jar"; WorkingDir: "{app}"; Tasks: startmenu

[Run]
Filename: "{app}\Run-Burp.bat"; Description: "{cm:LaunchProgram,{#ApplicationName}}"; Flags: nowait postinstall skipifsilent
Filename: "{app}\jdk\bin\javaw.exe"; Parameters: "-jar ""{app}\burploader.jar"""; Description: "{cm:LaunchProgram,Keygen}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: files; Name: "{app}\{#BurpJarFile}"
Type: files; Name: "{app}\burpsuite_pro_*.jar"
