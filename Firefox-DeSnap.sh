#!/usr/bin/env bash
## AUTHOR:
### 	Ciro Mota <contato.ciromota@outlook.com>
## NAME:
### 	Firefox-DeSnap.sh.
## DESCRIPTION:
###			Install Firefox Tarball version latest on Ubuntu and your Flavours and Debian Stable or Testing.
## LICENSE:
###		  GPLv3. <https://github.com/ciro-mota/firefox-desnap/blob/main/LICENSE>
## CHANGELOG:
### 		Last Update: 19/05/2022. <https://github.com/ciro-mota/firefox-desnap/commits/main>

### Variables.
down_url="https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang="
your_lang="$(locale | head -1 | sed -e 's/LANG=//' -e 's/.UTF-8$//' | tr "_" "-")"
snap_exist="$(snap list 2> /dev/null | grep firefox | awk '{print $1}')"
esr_exist="$(dpkg -l | grep firefox-esr | awk '{print $2}')"
version_check="$(lsb_release -cs)"

func_snap (){
echo -e "\e[32;1mUninstalling Firefox Snap...\e[m\n"
	
### Pinning Snap and uninstalling Firefox package.
sudo snap remove firefox >/dev/null

sudo tee -a /etc/apt/preferences.d/firefox-no-snap &>/dev/null << 'EOF' 
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
EOF
}

func_esr (){
echo -e "\e[32;1mUninstalling Firefox ESR...\e[m\n"
sudo apt-get purge firefox-esr -y >/dev/null
}

down_script (){
### Download.
echo -e "\e[32;1mDownloading...\e[m\n"
wget -O firefox-latest.bz2 -cq --show-progress "$down_url""$your_lang" -P /home/"$(id -nu 1000)"

### Instalation of Firefox Release.
echo -e "\e[32;1mInstaling...\e[m\n"
sudo tar xjf /home/"$(id -nu 1000)"/firefox*.bz2 -C /opt
sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
sudo chown -R "$(whoami)":"$(whoami)" /opt/firefox*

### Creating shortcut.
sudo tee -a /usr/share/applications/firefox-stable.desktop &>/dev/null << 'EOF' 
[Desktop Entry]
Version=1.0
Name=Firefox
GenericName=Web Browser
Comment=Browse the Web
Exec=firefox %u
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;profile-manager-window;

X-Desktop-File-Install-Version=0.26

[Desktop Action new-window]
Name=Open a New Window
Exec=firefox --new-window %u

[Desktop Action new-private-window]
Name=Open a New Private Window
Exec=firefox --private-window %u

[Desktop Action profile-manager-window]
Name=Open the Profile Manager
Exec=firefox --ProfileManager
EOF

### Shortcut permissions
sudo chown "$(whoami)":"$(whoami)" /usr/share/applications/firefox-stable.desktop

### Clean downloaded file.
rm /home/"$(id -nu 1000)"/firefox*.bz2

echo -e "\e[32;1mFirefox successfully installed!\e[m"
}

### Call download and installation function
func_down (){
echo -e "Would you like to continue anyway to download and install tarball version?"
echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to exit the script:\n"
read -r download
		case $download in
			y|Y)
				down_script
			;;
			n|N)
				echo -e "\e[32;1mTerminating script...\e[m"
				exit 0
			;;  
			*)
				echo -e "\e[31;1mIncorrect option.\e[m"
				func_down
			;;
		esac
}

### Call uninstall snap and/or installation
func_ff_snap (){
	echo -e "Firefox Snap detected. Would you like do unistall?"
	echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to not uninstall:\n"
	read -r unin_snap
		case $unin_snap in
			y|Y)
					func_snap
				;;
			n|N)
					func_down
				;;  
			*)
					echo -e "\e[31;1mIncorrect option.\e[m\n"
					func_ff_snap	
			esac
}

### Call uninstall ESR and/or installation
func_ff_esr (){
	echo -e "Firefox ESR detected. Would you like do unistall?"
	echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to not uninstall:\n"
	read -r unin_esr
		case $unin_esr in
			y|Y)
					func_esr
			;;
			n|N)
					func_down
			;;  
			*)
					echo -e "\e[31;1mIncorrect option.\e[m\n"
					func_ff_esr
			;;
		esac
}

### Main uninstall Firefox Snap or ESR and script execution.
exec_script (){
echo -e "Script will check if you have Firefox Snap or ESR installed and remove it."
echo -e "Would you like to continue the script? Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to exit\n"
read -r exists
		case $exists in
			y|Y)
				if [[ $snap_exist = "firefox" ]]; 
				then
						func_ff_snap
				elif [[ $esr_exist = "firefox-esr" ]]; 
				then
						func_ff_esr
				else
					echo -e "No Firefox was detected.\n"
						func_down				
				fi
			;;
			n|N)
			echo -e "\e[32;1mTerminating script...\e[m\n"
			exit 0
			;;  
			*)
			echo -e "\e[31;1mIncorrect option.\e[m\n"
						exec_script
			;;		
		esac	
	}

func_auto () {
	echo -e "Would you like to run this script automatically? See the documentation to see what it will do."
	echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to interactive mode\n"
	read -r choose
		case $choose in
			y|Y)
				if [[ $snap_exist = "firefox" ]]; 
				then
						func_snap
						down_script
				elif [[ $esr_exist = "firefox-esr" ]]; 
				then
						func_esr
						down_script
				else
						down_script				
				fi
			;;
			n|N)
						exec_script
			;;  
			*)
						echo -e "\e[31;1mIncorrect option.\e[m"
						func_auto
			;;		
		esac
}

### Check Ubuntu/Flavours 22.04 and Debian Stable or Testing and exec.
if [[ $version_check = 'jammy' ]] || [[ $version_check = 'bookworm' ]] || [[ $version_check = 'bullseye' ]]
then
			func_auto
else
	echo -e "\e[31;1mDistro not supported by this script.\e[m"
	exit 1
fi