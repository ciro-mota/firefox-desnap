#!/usr/bin/env bash
## AUTHOR:
### 	Ciro Mota <contato.ciromota@outlook.com>
## NAME:
### 	Thunderbird-DeSnap.sh.
## DESCRIPTION:
###			Install Thunderbird Latest on Ubuntu after 22.04 and your flavours.
## LICENSE:
###		  GPLv3. <https://github.com/ciro-mota/firefox-desnap/blob/main/LICENSE>
## CHANGELOG:
### 		Last Update: 12/05/2024. <https://github.com/ciro-mota/firefox-desnap/commits/main>

### Variables.
your_lang="$(locale | head -1 | sed -e 's/LANG=//' -e 's/.UTF-8$//' -e 's/_/-/' | awk '{print tolower($0)}')"
snap_exist="$(snap list 2>/dev/null | grep thunderbird | awk '{print $1}')"
version_check="$(lsb_release -cs)"

### Pinning Snap and uninstalling Thunderbird Snap package.
func_snap() {
    echo -e "\e[32;1mUninstalling Thunderbird Snap...\e[m\n"

    sudo snap remove thunderbird >/dev/null
    sudo apt remove thunderbird* >/dev/null

    sudo tee -a /etc/apt/preferences.d/thunderbird-no-snap &>/dev/null <<'EOF'
Package: thunderbird*
Pin: release o=Ubuntu*
Pin-Priority: -1
EOF

    sudo tee -a /etc/apt/preferences.d/thunderbird &>/dev/null <<'EOF'
Package: thunderbird*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
}

### Uninstall Thunderbird Snap.
func_select_snap() {
    echo -e "Thunderbird Snap detected. Would you like do uninstall?"
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
    echo -e "Would you like to continue anyway to download and install Thunderbird not Snap?"
    echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to exit the script:\n"
    read -r download
    case $download in
    y | Y)
        ### Adding PPA.
        echo -e "\e[32;1mAdding Thunderbird Mozilla Team PPA...\e[m"
        sudo add-apt-repository ppa:mozillateam/ppa -y

        sudo apt-get -qq update >/dev/null

        ### Install Thunderbird and lang-pack
        sudo apt install -y thunderbird thunderbird-locale-"$your_lang"
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

### Call for Thunderbird Snap uninstall script.
exec_script() {
    echo -e "Script will check if you have Thunderbird Snap installed and remove it."
    echo -e "Would you like to continue the script? Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to exit\n"
    read -r exists
    case $exists in
    y | Y)
        if [[ $snap_exist = "thunderbird" ]]; then
            func_select_snap
        else
            echo -e "No Thunderbird was detected.\n"
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
        if [[ $snap_exist = "thunderbird" ]]; then
            func_snap
            func_install_ubuntu
        else
            echo -e "No Thunderbird was detected.\n"
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

### Check Ubuntu/Flavours 22.04, 23.10, 24.04 and start exec.
if [[ $version_check =~ ^(noble|mantic|jammy)$ ]]; then
    func_auto
else
    echo -e "\e[31;1mDistro not supported by this script.\e[m"
    exit 1
fi
