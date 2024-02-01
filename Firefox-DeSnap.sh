#!/usr/bin/env bash
## AUTHOR:
### 	Ciro Mota <contato.ciromota@outlook.com>
## NAME:
### 	Firefox-DeSnap.sh.
## DESCRIPTION:
###			Install Firefox Latest on Ubuntu after 22.04 and your flavours and Debian Stable, Oldstable or Testing.
## LICENSE:
###		  GPLv3. <https://github.com/ciro-mota/firefox-desnap/blob/main/LICENSE>
## CHANGELOG:
### 		Last Update: 01/02/2024. <https://github.com/ciro-mota/firefox-desnap/commits/main>

### Variables.
your_lang="$(locale | head -1 | sed -e 's/LANG=//' -e 's/.UTF-8$//' -e 's/_/-/' | awk '{print tolower($0)}')"
your_lang_deb="$(locale -a | tail -1 | sed -e 's/.utf8$//' -e 's/_/-/' | awk '{print tolower($0)}')"
snap_exist="$(snap list 2>/dev/null | grep firefox | awk '{print $1}')"
esr_exist="$(dpkg -l | grep firefox-esr | awk '{print $2}')"
version_check="$(lsb_release -cs)"

### Pinning Snap and uninstalling Firefox Snap package.
func_snap() {
    echo -e "\e[32;1mUninstalling Firefox Snap...\e[m\n"

    sudo snap remove firefox >/dev/null

    sudo tee -a /etc/apt/preferences.d/firefox-no-snap &>/dev/null <<'EOF'
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
EOF

    sudo tee -a /etc/apt/preferences.d/mozilla &>/dev/null <<'EOF'
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
EOF
}

### Uninstall Firefox Snap.
func_select_snap() {
    echo -e "Firefox Snap detected. Would you like do unistall?"
    echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to not uninstall and exit:\n"
    read -r unin_snap
    case $unin_snap in
    y | Y)
        func_snap
        func_install_ubuntu
        ;;
    n | N)
        exit 1
        ;;
    *)
        echo -e "\e[31;1mIncorrect option. Please try again.\e[m\n"
        func_select_snap
        ;;
    esac
}

### Main Ubuntu function.
func_install_ubuntu() {
    echo -e "Would you like to continue anyway to download and install Firefox not Snap?"
    echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to exit the script:\n"
    read -r download
    case $download in
    y | Y)
        ### Adding PPA.
        echo -e "\e[32;1mAdding Firefox Oficial PPA...\e[m"
        wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- |
            sudo tee /etc/apt/keyrings/packages.mozilla.org.asc >/dev/null

        echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" |
            sudo tee -a /etc/apt/sources.list.d/mozilla.list >/dev/null

        sudo apt-get -qq update >/dev/null

        ### Install Firefox and lang-pack
        sudo apt install -y firefox firefox-l10n-"$your_lang"
        ;;
    n | N)
        echo -e "\e[32;1mTerminating script...\e[m"
        exit 0
        ;;
    *)
        echo -e "\e[31;1mIncorrect option. Please try again.\e[m"
        func_down
        ;;
    esac
}

### Uninstall Firefox ESR.
func_esr() {
    echo -e "\e[32;1mUninstalling Firefox ESR...\e[m\n"
    sudo apt-get purge firefox-esr -y >/dev/null
}

### Call uninstall Firefox ESR and install Firefox Latest.
func_select_esr() {
    echo -e "Firefox ESR detected. Would you like do unistall?"
    echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to not uninstall and exit:\n"
    read -r unin_esr
    case $unin_esr in
    y | Y)
        func_esr
        func_install_debian
        ;;
    n | N)
        exit 1
        ;;
    *)
        echo -e "\e[31;1mIncorrect option. Please try again.\e[m\n"
        func_select_esr
        ;;
    esac
}

### Main Debian function.
func_install_debian() {
    ### Adding Unstable source.
    echo -e "\e[32;1mAdding Firefox Debian Unstable source...\e[m"
    sudo tee -a /etc/apt/sources.list &>/dev/null <<'EOF'
deb http://deb.debian.org/debian/ unstable main
EOF

    sudo tee -a /etc/apt/preferences.d/99firefox-unstable &>/dev/null <<'EOF'
Package: *
Pin: release a=stable
Pin-Priority: 900

Package: *
Pin: release a=unstable
Pin-Priority: 10
EOF

    sudo apt -qq update && sudo apt install -y -t unstable firefox firefox-l10n-"$your_lang_deb"
}

### Call for Firefox Snap or ESR uninstall script.
exec_script() {
    echo -e "Script will check if you have Firefox Snap or ESR installed and remove it."
    echo -e "Would you like to continue the script? Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to exit\n"
    read -r exists
    case $exists in
    y | Y)
        if [[ $snap_exist = "firefox" ]]; then
            func_select_snap
        elif [[ $esr_exist = "firefox-esr" ]]; then
            func_select_esr
        else
            echo -e "No Firefox was detected.\n"
            exit 0
        fi
        ;;
    n | N)
        echo -e "\e[32;1mTerminating script...\e[m\n"
        exit 0
        ;;
    *)
        echo -e "\e[31;1mIncorrect option. Please try again.\e[m\n"
        exec_script
        ;;
    esac
}

### Execution in automatic mode.
func_auto() {
    echo -e "Would you like to run this script automatically? See the documentation to see what it will do."
    echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to interactive mode or \e[33;1mX\e[m to exit.\n"
    read -r choose
    case $choose in
    y | Y)
        if [[ $snap_exist = "firefox" ]]; then
            func_snap
            func_install_ubuntu
        elif [[ $esr_exist = "firefox-esr" ]]; then
            func_esr
            func_install_debian
        else
            echo -e "No Firefox was detected.\n"
            exit 0
        fi
        ;;
    n | N)
        exec_script
        ;;
    x | X)
        exit 1
        ;;
    *)
        echo -e "\e[31;1mIncorrect option.\e[m"
        func_auto
        ;;
    esac
}

### Check Ubuntu/Flavours 22.04, 22.10, 23.04, 23.10 and Debian Stable or Testing and start exec.
if [[ $version_check =~ ^(mantic|lunar|jammy|trixie|bookworm|bullseye)$ ]]; then
    func_auto
else
    echo -e "\e[31;1mDistro not supported by this script.\e[m"
    exit 1
fi
