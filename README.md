<h2>Download and install Firefox Release on Ubuntu 22.04, 23.10, 24.04 and Debian Stable or Testing</h2>

<p align="center">
    <img alt="License" src="https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge">
    <img alt="Shell Script" src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white">
    <img alt="Ubuntu" src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white">
    <img alt="Kubuntu" src="https://img.shields.io/badge/-KUbuntu-%230079C1?style=for-the-badge&logo=kubuntu&logoColor=white">
    <img alt="Xubuntu" src="https://img.shields.io/badge/XUBUNTU-2284F2?logo=xfce&logoColor=fff&style=for-the-badge">
    <img alt="Lubuntu" src="https://img.shields.io/badge/-Lubuntu-%230065C2?style=for-the-badge&logo=lubuntu&logoColor=white">
    <img alt="MATE" src="https://img.shields.io/badge/Ubuntu%20MATE-84A454.svg?style=for-the-badge&logo=Ubuntu-MATE&logoColor=white">
    <img alt="Debian" src="https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white">
</p>

## 📑 Proposal

Ubuntu in its version 22.04 ou higher brought the Firefox proposal through the Snap format as the default for its installations and its flavors. The purpose of this Git is to install Firefox in the latest version on these distros through a direct download from Mozilla PPA, with updates with the system.

This script can also install Firefox latest on Debian Stable or Testing, which usually has the ESR version installed.

<p align="center">Made with 💝 for <img src=".github/tux.png" align="top" width="18" /></p>

>[!WARNING] \
> This script only supports LTS versions of Ubuntu and only the latest point release (23.10 `mantic`). In addition, Debian is not supported on Oldstable either.

>[!IMPORTANT] \
>In case of errors please report them in the Issues tab for future correction.

>[!NOTE] \
>Keep in mind that performance, some bugs, missing features and missing system integrations with the Firefox Snap package, have the promise to are being addressed by Ubuntu developers. And ESR is developed to be as stable as possible and closely tracks major version releases.

## 📌 Notes

- Script will download the Firefox depending of locale setting of your system language.

- The script will check if you have the Snap or ESR versions installed, otherwise the latest version can be installed and both can coexist normally on the same system.

- If you choose to run this script in automatic mode, the script will automatically remove Firefox Snap or ESR and install the latest version from Mozilla or Debian Sid (for the Debian installation) repo as a replacement for the system's native versions.

- Manually, the script will uninstall the Snap or ESR versions and ask for confirmation to install the latest version.

- In addition to that, this script will also _pin_ the Snap version of Firefox in Ubuntu and ESR in Debian so it doesn't get installed again.

- If you want to install by the tarball method, use the old version of this script contained in `tarball branch`.

## 🚀 Execution

- `git clone` this repo.
- Give execution permissions on **Firefox-DeSnap.sh**
- `./Firefox-DeSnap` to execute.

## 🌎 How to update

When installing Firefox using this method you will have updates directly from the system repo `apt update` and `apt upgrade`.

## 🎁 Sponsoring

If you like this work, give me it a star on GitHub, and consider supporting it:

[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://www.paypal.com/donate/?business=VUS6R8TX53NTS&no_recurring=0&currency_code=USD)