#!/usr/bin/env bash
## AUTHOR:
### 	Ciro Mota <contato.ciromota@outlook.com>
## NAME:
### 	Firefox-DeSnap.sh.
## DESCRIPTION:
###			Install Firefox Not Snap in the most current version on Ubuntu and your Flavours.
## LICENSE:
###		  GPLv3. <https://github.com/ciro-mota/firefox-desnap/blob/main/LICENSE>
## CHANGELOG:
### 		Last Update: 01/05/2022. <https://github.com/ciro-mota/firefox-desnap/commits/main>

### Variables.
your_lang="$(locale | head -1 | sed -e 's/LANG=//' -e 's/.UTF-8$//' | tr "_" "-")"
snap_exist="$(snap list 2> /dev/null | grep firefox | awk '{print $1}')"

main_script (){
### Pinning Snap Firefox package.
sudo tee -a /etc/apt/preferences.d/firefox-no-snap &>/dev/null << 'EOF' 
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
EOF

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

### Check Ubuntu/Flavours 22.04.
if [[ $(lsb_release -cs) = 'jammy' ]] 
then
	echo ""
	echo ""
	echo -e "\e[32;1mJammy 22.04 Detected. Continuing script...\e[m"
	echo ""
	echo ""
else
	echo -e "\e[31;1mDistro not supported by this script.\e[m"
	exit 1
fi

### Uninstall Firefox Snap and Script execution
if [[ $snap_exist = "firefox" ]] 
then
	echo -e "\e[32;1mUninstalling Firefox Snap...\e[m"
	sudo snap remove firefox
	main_script
else
	echo -e "Firefox Snap not installed on your system. Would you like to continue the script to download and install?"
	echo -e "Type \e[33;1mY\e[m to continue or \e[33;1mN\e[m to exit the script:\n"

	while true; do
	read -r download
		case $download in
			y|Y)
			echo ""
			echo ""
				main_script
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
	done	
fi

