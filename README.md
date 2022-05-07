# Download and install Firefox Release on Ubuntu 22.04 and Debian Stable or Testing

[![Versão-Português_Brasil](https://img.shields.io/badge/Versão-Português_Brasil-%2393CE0A?style=for-the-badge)](/README.pt-br.md)
![License](https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white) 
![Kubuntu](https://img.shields.io/badge/-KUbuntu-%230079C1?style=for-the-badge&logo=kubuntu&logoColor=white)
![Lubuntu](https://img.shields.io/badge/-Lubuntu-%230065C2?style=for-the-badge&logo=lubuntu&logoColor=white)
![Debian](https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![Last Commit](https://img.shields.io/github/last-commit/ciro-mota/firefox-desnap?style=for-the-badge)

## Proposal

Ubuntu in its version 22.04 brought the Firefox proposal through the Snap format as the default for its installations and some of its flavors. The purpose of this Git is to install Firefox in the most current version on these distros through a direct download from Mozilla, with updates in the browser itself.

Script will download the Firefox depending of locale setting of your system language. You can check that typing `locale | head -1`.

This script can also install Firefox stable on Debian Stable or Testing, which usually has the ESR version installed.

**This script is under development, errors are expected. In case of errors please report them in the Issues tab for correction.**

## Notes

- The script will check if you have the Snap or ESR versions installed, otherwise the Stable version can be installed and both can coexist normally on the same system.

- If you choose, the script will uninstall the Snap or ESR versions and ask for confirmation to install the Stable version.

- In addition to that, this script will also _pin_ the Snap version of Firefox so it doesn't get installed again.

- If you use Debian on the GNOME version, it requires a browser (either Firefox ESR or Chromium) to be installed on the system. In this case when choosing to remove Firefox ESR Chromium will be automatically installed.

## Execution

- `git clone` this repo.
- Give execution permissions on **Firefox-DeSnap.sh**
- `./Firefox-DeSnap` to execute.