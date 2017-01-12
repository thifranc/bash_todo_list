#!/bin/bash
os=$("uname")

if [ "$os" == "Darwin" ]
then
compinstall
fi
cat zshrc >> ~/.zshrc
cp githubPulling.sh ~
cp todo.sh ~
if [ -z "$BASH_AUTOCOMPLETE_PATH" ]
then
	echo "You should cp the todo file in \$BASH_AUTOCOMPLETE_PATH
see the zshrc file for more information"
else
	cp todo $BASH_AUTOCOMPLETE_PATH
fi
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
