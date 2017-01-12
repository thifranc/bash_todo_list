#!/bin/bash
os=$("uname")

cat zshrc >> ~/.zshrc
cp githubPulling.sh ~
cp todo.sh ~
mkdir -p ~/todo
while true; do
    read -p "Do you wish to install Github auto-pulling [y/n]?" yn
    case $yn in
        [yn]* ) break;;
        * ) echo "Please answer y or n :)";;
    esac
done
if [ "$yn" == "y" ]
then
	echo "~/githubPulling.sh" >> ~/.zshrc
else
	rm ~/githubPulling.sh
fi
if [ "$os" == "Darwin" ]
then
	compinstall
	echo "Installation is almost complete !
as you are on MAC OSX, run the following to finish installing :
cp todo /usr/local/etc/bash_completion.d/"
else
	echo "Installation is almost complete !
as you are on LINUX, run the following to finish installing :
sudo cp todo /etc/bash_completion.d/"
fi
