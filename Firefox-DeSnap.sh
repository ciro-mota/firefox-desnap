#!/usr/bin/env bash
## AUTHOR:
### 	Ciro Mota <contato.ciromota@outlook.com>
## NAME:
### 	Firefox-DeSnap.sh.
## DESCRIPTION:
###			Install Firefox Not Snap in the most current version on Ubuntu and Kubuntu.
## LICENSE:
###		  GPLv3. <https://github.com/ciro-mota/firefox-desnap/blob/main/LICENSE>
## CHANGELOG:
### 		Last Update: 24/04/2022. <https://github.com/ciro-mota/firefox-desnap/commits/main>

### Download Links.
url_firefox_br="https://ftp.mozilla.org/pub/firefox/releases/99.0.1/linux-x86_64/pt-BR/firefox-99.0.1.tar.bz2"
url_firefox_en="https://ftp.mozilla.org/pub/firefox/releases/99.0.1/linux-x86_64/en-US/firefox-99.0.1.tar.bz2"

# ---------------------------------------------------------------------------------------------------- #
# ------------------------------------------ TEST AND EXECUTION -------------------------------------- #
### Check GNOME or Plasma.
if [[ $(gnome-shell --version | awk '{print $1}') = "GNOME" ]];
then        
      echo ""
	    echo -e "\e[32;1mGNOME Detected. Continuing script...\e[m"
	    echo ""
elif [[ $(plasmashell --version | awk '{print $1}') = "plasmashell" ]];
then
      echo ""
	    echo -e "\e[32;1mPlasma Detected. Continuing script...\e[m"
	    echo ""
else
      echo ""
      echo -e "\e[31;1mDE not supported by this script.\e[m"
	    exit 1
fi	

# ------------------------------------------------------------------------------------------------------ #
# --------------------------------------------- CHOOSE LANGUAGE ---------------------------------------- #
### Choose version to download.
echo -e "Type BR to download Brazilian Portuguese version or type EN for English version:"
read -r download

case $download in
    br|BR)
    	wget -cq --show-progress "$url_firefox_br" -P /home/teste/"$(id -nu 1000)"
		;;
    en|EN)
    	wget -cq --show-progress "$url_firefox_en" -P /home/teste/"$(id -nu 1000)"
    ;;  
    *)
      echo "Incorrect option. Leaving..."
      exit 1
		;;
esac

# ------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------- EXECUTION ------------------------------------------- #
### Pinning Firefox Snap package.
sudo tee -a /etc/apt/preferences.d/firefox-no-snap &>/dev/null << 'EOF' 
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
EOF

### Instalation of Firefox Release.
echo -e "\e[32;1mDownloading...\e[m"
echo ""
tar xjf /home/teste/"$(id -nu 1000)"/firefox*.bz2 -C /opt
sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
sudo chown -R "$(whoami)":"$(whoami)" /opt/firefox*

sudo tee -a /usr/share/applications/firefox-stable.desktop &>/dev/null << 'EOF' 
[Desktop Entry]
Version=1.0
Name=Firefox
GenericName=Web Browser
Comment=Browse the Web
Exec=firefox %u
Icon=firefox
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

# ---------------------------------------------------------------------------------------------------- #
# ----------------------------------------------- CLEANUP -------------------------------------------- #
### Clean downloaded file.
rm /home/teste/"$(id -nu 1000)"/firefox*.bz2