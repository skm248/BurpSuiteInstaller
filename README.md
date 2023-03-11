<a id="readme-top"></a>

<br />
<div align="center">
  <a href="https://github.com/mmgordon82/BurpSuiteInstaller">
    <img src="readme-assets/title-logo.png" alt="Logo" height="150">
  </a>

<h3 align="center">Burp Suite Cracekd Activator (Keygen and Loader + Easy Install)</h3>

  <p align="center">
    Install the most updated versions of Burp Suite (Pro) with easy-to-use installers and instructions in an automated fashion.
    <br />
  </p>

![Go](https://img.shields.io/badge/go-%2300ADD8.svg?style=for-the-badge&logo=go&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Inno Setup](readme-assets/badge-inno-setup.svg)
![OpenJDK](https://img.shields.io/badge/OpenJDK-%23d47820.svg?style=for-the-badge&logo=openjdk&logoColor=white)
</br>
[![Download Now](https://img.shields.io/badge/-Download%20Now-5b4fff?style=for-the-badge&logo=github&logoColor=black)](https://github.com/mmgordon82/BurpSuiteInstaller/releases/latest)

</div>



<!-- ABOUT THE PROJECT -->
## About
tl;dr now you can install Burp Suite (or patch your current setup) easily.

In the past few months, I needed to install Burp suite more than I had imagined. And every time I found myself bamboozled with how to crack/activate it.

Just to clarify, activating it means doing the following:
 - Looking online (mostly on Telegram or shady torrent sites) for a cracked version (hoping it doesn't contain any virus)
 - Download it
 - Put the JAR file somewhere on my PC
 - Modify the .vmoptions file
 - Download and install JRE
 - Discover I downloaded the wrong version of JRE
 - Download and install JRE (the right version this time)
 - Use a half-cocked keygen and loader that contains god-knows-what.
 - (OPTIONAL) create a shortcut and put it in the Programs directory, so it can be accessed as a run-of-the-mill software.

So in the past few weeks I decided to work on a solution that would mimic the official Burp-Suite exe installer only paid pro members get.

This repo includes:
 - `installer` for Windows - Installs everything needed, includes JDK, Burp and the keygen/loader.
 - `mini-patcher`, for those who prefer installing the proper EXE releases of Burp - activates the existing installed Burp.
 - `portable` edition, for those who want to carry it on a USB drive.

The keygen used is written by [h3110w0r1d-y](https://github.com/h3110w0r1d-y/BurpLoaderKeygen).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting Started

### Linux

#### Download the latest release
```bash

```


### Windows


Simply download the [latest release](https://github.com/mmgordon82/BurpSuiteInstaller/releases/latest) and follow the instructions.

## Utilities

### Remove License and Configurations
Sometimes you might want to remove the license and configurations from Burp Suite. This is useful when you want to use Burp Suite on a different machine, or when you want to reset Burp Suite to its default state. For this, you can use the `remove-license.bat` script.

#### Windows
Simply run the `remove-license.bat` script. This will remove the license and configurations stored on disk and on registry.

#### Linux
```bash

```

## Set up Update Server
Feel free to fork this repo and set up your own update server. This is useful if you want to use your own keygen/loader, or if you want to use a different version of Burp Suite.

The update server is responsible for loading the Dockerfile, checking for new updates, and creating a release on this repo.

If you have docker installed, you can run the following command to start the update server:
```bash

```


<!-- LICENSE -->
## License

Distributed under the MIT License.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* Keygen by [h3110w0r1d-y](https://github.com/h3110w0r1d-y/BurpLoaderKeygen)

<p align="right">(<a href="#readme-top">back to top</a>)</p>
