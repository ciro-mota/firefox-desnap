</p>

<table align="right">
 <tr><td><a href="https://github.com/ciro-mota/firefox-desnap/blob/main/README.md">:us: English</a></td></tr>
 <tr><td><a href="https://github.com/ciro-mota/firefox-desnap/blob/main/README.pt-br.md">:brazil: Português</a></td></tr>
</table>

<h2>Download and install Firefox Release on Ubuntu 22.04, 22.10, 23.04, 23.10 and Debian Stable or Testing</h2>

<p align="center">
    <img alt="License" src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge">
    <img alt="Shell Script" src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white">
    <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white">
    <img alt="Kubuntu" src="https://img.shields.io/badge/-KUbuntu-%230079C1?style=for-the-badge&logo=kubuntu&logoColor=white">
    <img alt="Lubuntu" src="https://img.shields.io/badge/-Lubuntu-%230065C2?style=for-the-badge&logo=lubuntu&logoColor=white">
    <img alt="MATE" src="https://img.shields.io/badge/Ubuntu%20MATE-84A454.svg?style=for-the-badge&logo=Ubuntu-MATE&logoColor=white">
    <img alt="Debian" src="https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white">
    <img alt="Last Commit" src="https://img.shields.io/github/last-commit/ciro-mota/Personal-Startpage?style=for-the-badge">
</p>

## 🎁 Sponsoring

If you like this work, give me it a star on GitHub, and consider supporting it:

[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://www.paypal.com/donate/?business=VUS6R8TX53NTS&no_recurring=0&currency_code=USD)

## 📑 Proposal

Ubuntu in its version 22.04 ou higher brought the Firefox proposal through the Snap format as the default for its installations and its flavors. The purpose of this Git is to install Firefox in the latest version on these distros through a direct download from Mozilla, with updates in the browser itself.

Script will download the Firefox depending of locale setting of your system language. You can check that typing `locale | head -1`.

This script can also install Firefox latest on Debian Stable or Testing, which usually has the ESR version installed.

**This script is under development, errors are expected. In case of errors please report them in the Issues tab for correction.**

## 📌 Notes

- The script will check if you have the Snap or ESR versions installed, otherwise the latest version can be installed and both can coexist normally on the same system.

- If you choose to run this script in automatic mode, the script will automatically remove Firefox Snap or ESR and install the latest version in tarball format as a replacement for the system's native versions.

- Manually, the script will uninstall the Snap or ESR versions and ask for confirmation to install the latest tarball version.

- In addition to that, this script will also _pin_ the Snap version of Firefox so it doesn't get installed again.

- If you use Debian on the GNOME version, it requires a browser (either Firefox ESR or Chromium) to be installed on the system. In this case when choosing to remove Firefox ESR, Chromium will be automatically installed.

## 🚀 Execution

- `git clone` this repo.
- Give execution permissions on **Firefox-DeSnap.sh**
- `./Firefox-DeSnap` to execute.