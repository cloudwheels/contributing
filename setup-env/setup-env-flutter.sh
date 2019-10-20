#!/bin/bash
#
# To run from the command line (from home directory)…
# source <(curl -s https://raw.githubusercontent.com/cloudwheels/contributing/master/setup-env/setup-env-flutter.sh)
#
#
# Should run in home diretory
# See about gettng current directory here
#
# https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself
# (e.g. answer): https://stackoverflow.com/a/246128/10797095
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo This script is being run from $DIR
#
# CHROMEBOOK CROSTINI DEV ENV SETUP SCRIPT (FLUTTER DEV)
#
#
# 
#
#
# ADD SOME COMMON TOOLS
echo “installing nano...”
sudo apt-get install nano -y
# TODO: set as default editor
#
# SET UP VISUAL STUDIO
#
#
echo “installing visual studio” 
#
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code -y
#
# TODO: set up extensions & import projects from git etc
echo “installing vscode extension for dart + flutter”
code --install-extension Dart-Code.flutter
#
# SET UP FLUTTER DEV ENV
#
# CHECK FOR EXISTING INSTALL
# ?TODO check for other flutter prerequisites
# (only xz-utils not installed in penguin by default)
# whereis bash curl git mkdir rm unzip which xz-utils
#
# 
#
echo “installing xz-utils...”
sudo apt-get install xz-utils
#
#
#
echo “cloning MASTER branch / channel of flutter...”
git clone -b master https://github.com/flutter/flutter.git
#
echo “triggering download of sdk dependencies and building flutter tool...”
./flutter/bin/flutter --version
# 
echo “adding flutter tool to ~/.bashrc” 
printf '\nexport PATH=\"$PATH:~/flutter/bin\"\n' >> ~/.bashrc
# source ~/.bashrc
#
# [optional] pre-download dev binaries
# flutter precache
#
echo “checking flutter is installed and PATH is set…”
./flutter/bin/flutter --version
#
# INSTALL JAVA
#
echo “installing java...”
sudo apt update
sudo apt install default-jre -y
sudo apt install default-jdk -y
#
# INSTALL ANDROID SDK / command line only tools
# following instructions at https://flutter.dev/docs/get-started/install/chromeos 
# PATH and ANDROID_HOME settings are a bit messy??? 
#
echo “installing Android”
#
# prerequisites
sudo apt install lib32ncurses5 lib32stdc++6 -y
#
# TODO: How to get the latest version number?
curl https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -L -o sdk-tools-linux
unzip ~/sdk-tools-linux
# export tools path - add to .bashrc
printf '\nexport PATH=\"$PATH:~/tools/bin\"\n' >> ~/.bashrc
# source ~/.bashrc
## TODO: CHECK / GET LATESET VERSIONS!!!!
echo “installing Android platform tools - REQUIRES ACCEPTING LICENSES!!!”
## UNTESTED - SILENTLY ACCEPT ANDROID LICENCES
yes | ./tools/bin/sdkmanager --licenses
./tools/bin/sdkmanager "build-tools;28.0.3" "emulator" "tools" "platform-tools" "platforms;android-28" "extras;google;google_play_services" "extras;google;webdriver" "system-images;android-28;google_apis_playstore;x86_64"
printf '\nexport PATH=\"$PATH:~/platform-tools\"\n' >> ~/.bashrc
printf '\nexport ANDROID_HOME=\"~"\n' >> ~/.bashrc
# source ~/.bashrc
# set android home in flutter config 
./flutter/bin/flutter config --android-sdk ~
echo “running flutter doctor - YOU MUST ACCEPT ANDROID LICENCES”
yes | ./flutter/bin/flutter doctor --android-licenses
#
#
echo “running flutter doctor to make sure all is cool….”
./flutter/bin/flutter doctor -v
#
echo “DONE - RELOADING SHELL TO MAKE ENV VARIABLES AVAILABLE”
exec bash
