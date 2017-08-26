#!/bin/bash

echo "to set value as default, just press enter, pass only absolute path otherwise"
read -p $'Choose the path for your todo directory : \x0a default is ~/todo ' TODO_PATH
TODO_PATH=${TODO_PATH:=~/todo}
read -p $'Choose the path for your ssh public key : \x0a default is ~/.ssh/id_rsa ' SSH_PATH
SSH_PATH=${SSH_PATH:=~/.ssh/id_rsa}

#
#start to write
#
echo "#here begin the lines added by todo_list_github" >> ~/.zshrc
echo "export TODO_PATH=${TODO_PATH}" >> ~/.zshrc
echo "export SSH_PATH=${SSH_PATH}" >> ~/.zshrc

mkdir -p "$TODO_PATH"

echo "
	#export SSH_KEY=your_ssh_passphrase (optional)
	autoload bashcompinit
	bashcompinit
	source \"\${TODO_PATH}\"/.todoCompletion
	source \"\${TODO_PATH}\"/.todo.sh
	#here end the lines added by todo_list_github
" >> ~/.zshrc

cp todo.sh .todo.sh && mv .todo.sh $TODO_PATH
cp todoCompletion .todoCompletion && mv .todoCompletion $TODO_PATH

while true; do
    read -p "Do you wish to install Github auto-pulling [y/n]?" yn
    case $yn in
        [yn]* ) break;;
        * ) echo "Please answer y or n :)";;
    esac
done
if [ $yn = "y" ]
then
	cp githubPulling.sh .githubPulling.sh && mv .githubPulling.sh $TODO_PATH
	echo "
	source \"\${TODO_PATH}/.githubPulling.sh\"
	if ! pgrep -x "ssh-agent" > /dev/null
	then
		sshConnect \${SSH_PATH} \${SSH_KEY}
		gitWatcher \$TODO_PATH
	else
		echo "git has already been updated"
	fi
	" >> ~/.zshrc
fi
