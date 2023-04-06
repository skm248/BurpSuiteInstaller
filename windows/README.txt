+--------------------------------+
|                             |
| BurpSuite Installer Builder |
|                             |
+--------------------------------+
An installer builder for PortSwigger's Burp Suite Proffessional that mimics the original one by including a fully functioning jdk.
Also adds the keygen (Thanks h3110w0r1d-y/BurpLoaderKeygen) and easy-to-follow instructions on how to activate.

Requirements:
	- Inno Setup 6 (https://jrsoftware.org/isdl.php)

How-To-Use:
	1. Add your Burp Suite Professional JAR file, can be downloaded from https://portswigger.net/burp/releases
	2. put the file in the current folder, and ensure its name is "burpsuite_pro.jar" or follows the pattern "burpsuite_pro_vXXXX.X.X.jar" (X is placehold for burp version)
	3. run make-installer.bat


TODO:
	- Create a downloadable version, maybe one that modifies the original installler. this installer is rather heavy (~800MB)