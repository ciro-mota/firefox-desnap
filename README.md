# Download and install Firefox Release on Ubuntu 22.04

[![Versão-Português_Brasil](https://img.shields.io/badge/Versão-Português_Brasil-%2393CE0A?style=for-the-badge)](/README.pt-br.md)
![License](https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white) 
![Kubuntu](https://img.shields.io/badge/-KUbuntu-%230079C1?style=for-the-badge&logo=kubuntu&logoColor=white)
![Debian](https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![Last Commit](https://img.shields.io/github/last-commit/ciro-mota/padavan-collection?style=for-the-badge)

Ubuntu in its version 22.04 brought the Firefox proposal through the Snap format as the default for its installations and some of its flavors. The purpose of this Git is to install Firefox in the most current version on Ubuntu and Kubuntu through a direct download from Mozilla itself, with updates in the browser itself.

Script will download, depending on the user's choice, the English or Brazilian Portuguese versions. You can comment these entries and adapt the script to your language.

Other flavors, if necessary, will be added later.

This script can also be used in Debian Stable or Testing with DE GNOME or Plasma.

**This script is under development, errors are expected.**

## Before running

You will need to uninstall the Snap version of Firefox, although both versions can coexist on the same system. Run `snap remove firefox` to remove.

The Script will also _pin_ the Snap version of Firefox so it doesn't get installed again.