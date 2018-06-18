#!/bin/bash

echo "to set value as default, just press enter, pass only absolute path otherwise"
read -p $'What is your starting shell file path ? : \x0a default is ~/.zshrc ' START_SHELL_PATH
START_SHELL_PATH=${START_SHELL_PATH:=~/.zshrc}
read -p $'Choose the path for your todo directory : \x0a default is ~/todo ' TODO_PATH
TODO_PATH=${TODO_PATH:=~/todo}
read -p $'Choose the path for your ssh public key : \x0a default is ~/.ssh/id_rsa ' SSH_PATH
SSH_PATH=${SSH_PATH:=~/.ssh/id_rsa}

#
#start to write
#
echo "#here begin the lines added by todo_list_github" >> ${START_SHELL_PATH}
echo "export TODO_PATH=${TODO_PATH}" >> ${START_SHELL_PATH}
echo "export SSH_PATH=${SSH_PATH}" >> ${START_SHELL_PATH}

mkdir -p "$TODO_PATH"

echo "
	#export SSH_KEY=your_ssh_passphrase (optional)
	\. \"\${TODO_PATH}\"/.todoCompletion
	source \"\${TODO_PATH}\"/.todo.sh
	#here end the lines added by todo_list_github
" >> ${START_SHELL_PATH}

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
	#new lines to enable Github auto-pulling
	source \"\${TODO_PATH}/.githubPulling.sh\"
	if ! pgrep -x "ssh-agent" > /dev/null
	then
		sshConnect \${SSH_PATH} \${SSH_KEY}
		gitWatcher \$TODO_PATH
	else
		echo "git has already been updated"
	fi
	#end of lines to enable Github auto-pulling
	" >> ${START_SHELL_PATH}
else
	echo "
	#end of lines added by todo_list_githuub
	" >> ${START_SHELL_PATH}
fi
