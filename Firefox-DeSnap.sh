#!/usr/bin/env bash
## AUTHOR:
### 	Ciro Mota <contato.ciromota@outlook.com>
## NAME:
### 	Firefox-DeSnap.sh.
## DESCRIPTION:
###			Install Firefox Tarball version latest on Ubuntu after 22.04 and your flavours and Debian Stable, Oldstable or Testing.
## LICENSE:
###		  GPLv3. <https://github.com/ciro-mota/firefox-desnap/blob/main/LICENSE>
## CHANGELOG:
### 		Last Update: 20/09/2023. <https://github.com/ciro-mota/firefox-desnap/commits/main>

### Variables.
down_url="https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang="
down_icon_url="https://raw.githubusercontent.com/ciro-mota/firefox-desnap/main/assets/firefox-stable.desktop"
your_lang="$(locale | head -1 | sed -e 's/LANG=//' -e 's/.UTF-8$//' -e 's/_/-/')"
snap_exist="$(snap list 2>/dev/null | grep firefox | awk '{print $1}')"
esr_exist="$(dpkg -l | grep firefox-esr | awk '{print $2}')"
version_check="$(lsb_release -cs)"

### Pinning Snap and uninstalling Firefox package.
func_snap() {
	echo -e "\e[32;1mUninstalling Firefox Snap...\e[m\n"

	sudo snap remove firefox >/dev/null

	sudo tee -a /etc/apt/preferences.d/firefox-no-snap &>/dev/null <<'EOF'
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
EOF
}

### Uninstall Firefox Snap.
func_select_snap() {
	echo -e "Firefox Snap detected. Would you like do unistall?"
	echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to not uninstall:\n"
	read -r unin_snap
	case $unin_snap in
	y | Y)
		func_snap
		func_down
		;;
	n | N)
		func_down
		;;
	*)
		echo -e "\e[31;1mIncorrect option. Please try again.\e[m\n"
		func_select_snap
		;;
	esac
}

### Uninstall Firefox ESR.
func_esr() {
	echo -e "\e[32;1mUninstalling Firefox ESR...\e[m\n"
	sudo apt-get purge firefox-esr -y >/dev/null
}


### Call uninstall Firefox ESR.
func_select_esr() {
	echo -e "Firefox ESR detected. Would you like do unistall?"
	echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to not uninstall:\n"
	read -r unin_esr
	case $unin_esr in
	y | Y)
		func_esr
		func_down
		;;
	n | N)
		func_down
		;;
	*)
		echo -e "\e[31;1mIncorrect option. Please try again.\e[m\n"
		func_select_esr
		;;
	esac
}

### Main function.
func_install() {
	### Download.
	echo -e "\e[32;1mDownloading...\e[m\n"
	wget -O firefox-latest.bz2 -cq --show-progress "$down_url""$your_lang" -P /home/"$(id -nu 1000)"

	### Instalation of Firefox Release.
	echo -e "\e[32;1mInstaling...\e[m\n"
	sudo tar xjf /home/"$(id -nu 1000)"/firefox*.bz2 -C /opt
	sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
	sudo chown -R "$(whoami)":"$(whoami)" /opt/firefox*

	### Creating shortcut.
	echo -e "\e[32;1mDownloading icon...\e[m\n"
	wget -O firefox-stable.desktop -cq --show-progress "$down_icon_url" -P /home/"$(id -nu 1000)"
	sudo mv /home/"$(id -nu 1000)"/firefox-stable.desktop /usr/share/applications

	### Shortcut permissions.
	sudo chown "$(whoami)":"$(whoami)" /usr/share/applications/firefox-stable.desktop

	### Clean downloaded file.
	rm /home/"$(id -nu 1000)"/firefox*.bz2

	echo -e "\e[32;1mFirefox successfully installed!\e[m"
}

### Call download/installation function.
func_down() {
	echo -e "Would you like to continue anyway to download and install Firefox tarball version?"
	echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to exit the script:\n"
	read -r download
	case $download in
	y | Y)
		func_install
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


### Call Firefox Snap or ESR uninstall script.
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
			func_down
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
	echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to interactive mode\n"
	read -r choose
	case $choose in
	y | Y)
		if [[ $snap_exist = "firefox" ]]; then
			func_snap
			func_install
		elif [[ $esr_exist = "firefox-esr" ]]; then
			func_esr
			func_install
		else
			func_install
		fi
		;;
	n | N)
		exec_script
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