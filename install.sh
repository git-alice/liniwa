#!bin/bash

shellrc = "~/.zshrc"


echo "Updating Ubuntu"
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

echo "Installing Essentials Apps"
sudo apt-get -y install curl wget zip unzip rar unrar zsh

# Compiling a package from source code requires additional software
# required packages for Python:
echo "Installling additional software"
sudo apt-get -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev
sudo apt-get -y install i3 py3status
sudo apt-get -y install ranger urxvt tmux tmuxp tmate 


echo "Installing pyenv"
curl https://pyenv.run | bash
# autorun pyenv
echo '#source pyenv'
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> shellrc
echo 'eval "$(pyenv init -)"' >> shellrc
echo 'eval "$(pyenv virtualenv-init -)"' >> shellrc
source shellrc

echo "Installing Chrome"
if [[ $(getconf LONG_BIT) = "64" ]]
then
	echo "64bit Detected" 
	echo "Installing Google Chrome" 
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
	sudo dpkg -i google-chrome-stable_current_amd64.deb 
	rm -f google-chrome-stable_current_amd64.deb
else
	echo "32bit Detected" 
	echo "Installing Google Chrome" 
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb 
	sudo dpkg -i google-chrome-stable_current_i386.deb 
	rm -f google-chrome-stable_current_i386.deb
fi

echo "Cleaning Up Ubuntu" 
sudo apt-get -f install 
sudo apt-get autoremove 
sudo apt-get -y autoclean 
sudo apt-get -y clean

# Delete installation file 
read -p "Delete instal.sh [y/n]: " del
if [ "$del" = "y" ] || [ -z "$del" ] ; then
	echo "*deleted*";
else
	echo "*pass*";
fi
