#!/usr/bin/env bash
## AUTHOR:
### 	Ciro Mota <contato.ciromota@outlook.com>
## NAME:
### 	Firefox-DeSnap.sh.
## DESCRIPTION:
###			Install Firefox Not Snap in the most current version on Ubuntu and your Flavours and Debian Stable or Testing.
## LICENSE:
###		  GPLv3. <https://github.com/ciro-mota/firefox-desnap/blob/main/LICENSE>
## CHANGELOG:
### 		Last Update: 07/05/2022. <https://github.com/ciro-mota/firefox-desnap/commits/main>

### Variables.
your_lang="$(locale | head -1 | sed -e 's/LANG=//' -e 's/.UTF-8$//' | tr "_" "-")"
snap_exist="$(snap list 2> /dev/null | grep firefox | awk '{print $1}')"
esr_exist="$(dpkg -l | grep firefox-esr | awk '{print $2}')"
version_check="$(lsb_release -cs)"

func_snap (){
### Pinning Snap Firefox package.
sudo tee -a /etc/apt/preferences.d/firefox-no-snap &>/dev/null << 'EOF' 
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
EOF
}

down_script (){
### Download.
echo -e "\e[32;1mDownloading...\e[m"
wget -O firefox-latest.bz2 -cq --show-progress https://download.mozilla.org/\?product\=firefox-latest-ssl\&os\=linux64\&lang\="$your_lang" -P /home/"$(id -nu 1000)"

### Instalation of Firefox Release.
echo ""
echo -e "\e[32;1mInstaling...\e[m"
echo ""
sudo tar xjf /home/"$(id -nu 1000)"/firefox*.bz2 -C /opt
sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
sudo chown -R "$(whoami)":"$(whoami)" /opt/firefox*

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

sudo chown "$(whoami)":"$(whoami)" /usr/share/applications/firefox-stable.desktop

echo -e "\e[32;1mFirefox successfully installed!\e[m"

### Clean downloaded file.
rm /home/"$(id -nu 1000)"/firefox*.bz2
}

func_down (){
echo ""
echo -e "Would you like to continue anyway to download and install tarball version?"
echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to exit the script:"
read -r download
		case $download in
			y|Y)
			echo ""
			echo ""
				down_script
			;;
			n|N)
			echo ""
			echo -e "\e[32;1mTerminating script...\e[m"
			echo ""
			exit 0
			;;  
			*)
			echo ""
			echo -e "\e[31;1mIncorrect option. Leaving...\e[m"
			echo ""
			exit 1
			;;
		esac
}

exec_script (){
### Uninstall Firefox Snap or ESR and script execution.
echo -e "Script will check if you have Firefox Snap or ESR installed and remove it."
echo -e "Would you like to continue the script? Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to exit"
read -r exists

	case $exists in
		y|Y)
		echo ""
			if [[ $snap_exist = "firefox" ]]; 
			then
				echo -e "Firefox Snap detected. Would you like do unistall?"
				echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to not uninstall:\n"
				read -r unin_snap
					case $unin_snap in
						y|Y)
						echo ""
						echo ""
							echo -e "\e[32;1mUninstalling Firefox Snap...\e[m"
							sudo snap remove firefox
							func_snap
						;;
						n|N)
						echo ""
							func_down
						echo ""
						;;  
						*)
						echo ""
						echo -e "\e[31;1mIncorrect option. Leaving...\e[m"
						echo ""
						exit 1		
					esac	
			elif [[ $esr_exist = "firefox-esr" ]]; 
			then
				echo -e "Firefox ESR detected. Would you like do unistall?"
				echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to not uninstall:\n"
				read -r unin_esr

					case $unin_esr in
						y|Y)
						echo ""
						echo ""
							echo -e "\e[32;1mUninstalling Firefox ESR...\e[m"
							sudo apt purge firefox-esr -y
						;;
						n|N)
						echo ""
							func_down
						echo ""
						;;  
						*)
						echo ""
						echo -e "\e[31;1mIncorrect option. Leaving...\e[m"
						echo ""
						exit 1
						;;
					esac
			else
				echo -e "No Firefox was detected."
					func_down
				echo ""				
			fi
		;;
		n|N)
		echo ""
		echo -e "\e[32;1mTerminating script...\e[m"
		echo ""
		exit 0
		;;  
		*)
		echo ""
		echo -e "\e[31;1mIncorrect option. Leaving...\e[m"
		echo ""
		exit 1
		;;		
	esac	
}

### Check Ubuntu/Flavours 22.04 and Debian Stable or Testing.
if [[ $version_check = 'jammy' ]] || [[ $version_check = 'bookworm' ]] || [[ $version_check = 'bullseye' ]]
then
	echo ""
	echo -e "\e[32;1mCorrect distro detected. Continuing script...\e[m"
	echo ""
		exec_script
	echo ""
	echo ""
else
	echo -e "\e[31;1mDistro not supported by this script.\e[m"
	exit 1
fi