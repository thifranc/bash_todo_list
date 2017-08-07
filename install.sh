#!/bin/bash

#
#load different variables
#
os=$("uname")
if [[ $os == "Darwin" ]]
then
    BASH_AUTOCOMPLETE_ADVICE=/usr/local/etc/bash_completion.d/todo
    else
    BASH_AUTOCOMPLETE_ADVICE=/etc/bash_completion.d/todo
fi

echo "to set value as default, just press enter, pass only absolute path otherwise"
read -p $'Choose the path for your todo directory : \x0a default is ~/todo ' TODO_PATH
TODO_PATH=${TODO_PATH:=~/todo}
read -p $'Choose the path for your ssh public key : \x0a default is ~/.ssh/id_rsa ' SSH_PATH
SSH_PATH=${SSH_PATH:=~/.ssh/id_rsa}
read -p $'Choose the path for your bash_todo_list folder : \x0a default is ~/.bash_todo_list ' BASH_TODO_LIST_PATH
BASH_TODO_LIST_PATH=${BASH_TODO_LIST_PATH:=~/.bash_todo_list}
read -p $'Choose the path for your bash autoComplete file : \x0a default is \x0a
you seem to be on '"$os"$', \x0a so adviced one is '"$BASH_AUTOCOMPLETE_ADVICE"' ' BASH_AUTOCOMPLETE_PATH
BASH_AUTOCOMPLETE_PATH=${BASH_AUTOCOMPLETE_PATH:=$BASH_AUTOCOMPLETE_ADVICE}

#
#start to write
#
echo "#here begin the lines added by todo_list_github" >> ~/.zshrc
echo "export TODO_PATH=${TODO_PATH}" >> ~/.zshrc
echo "export SSH_PATH=${SSH_PATH}" >> ~/.zshrc
echo "export BASH_AUTOCOMPLETE_PATH=${BASH_AUTOCOMPLETE_PATH}" >> ~/.zshrc
echo "export BASH_TODO_LIST_PATH=${BASH_TODO_LIST_PATH}" >> ~/.zshrc

cat zshrc >> ~/.zshrc
mkdir -p "$BASH_TODO_LIST_PATH"
cp githubPulling.sh $BASH_TODO_LIST_PATH
cp todo.sh $BASH_TODO_LIST_PATH
mkdir -p "$TODO_PATH"

while true; do
    read -p "Do you wish to install Github auto-pulling [y/n]?" yn
    case $yn in
        [yn]* ) break;;
        * ) echo "Please answer y or n :)";;
    esac
done
if [ $yn = "y" ]
then
	echo "
	source \"\${BASH_TODO_LIST_PATH}/githubPulling.sh\"
	if ! pgrep -x "ssh-agent" > /dev/null
	then
		sshConnect \${SSH_PATH} \${SSH_KEY}
		gitWatcher \$TODO_PATH
	else
		echo "git has already been updated"
	fi
	" >> ~/.zshrc
else
	rm "$BASH_TODO_LIST_PATH/githubPulling.sh"
fi
if [ $os = "Darwin" ]
then
	compinstall
fi
echo "Installation is almost complete ! Please run the following to finish
sudo cp todo ${BASH_AUTOCOMPLETE_PATH}"
echo "#here end the lines added by todo_list_github" >> ~/.zshrc
