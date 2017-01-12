os=$("uname")

#it's up to you to set those variables
export TODO_PATH=~/todo
export SSH_PATH=~/.ssh/id_rsa

#export SSH_KEY=your_ssh_passphrase (optional)

if [[ $os == "Darwin" ]]
then
    export BASH_AUTOCOMPLETE_PATH=/usr/local/etc/bash_completion.d/todo
    zstyle :compinstall filename '/Users/thibault/.zshrc'

    autoload compinit
    compinit
    rm ~/.zcompdum*
else
    export BASH_AUTOCOMPLETE_PATH=/etc/bash_completion.d/todo
fi

autoload bashcompinit
bashcompinit
source ${BASH_AUTOCOMPLETE_PATH}

~/todoHandler.sh

todoFunc(){
    if [[ $1 == "see" ]]
    then
	    cat -n "${TODO_PATH}/$2"
    elif [[ $1 == "add" ]]
    then
        echo "$3" >> ${TODO_PATH}/$2
    elif [[ $1 == "rm" ]]
    then
	    sed -i -e "${3}d" ${TODO_PATH}/$2
    fi
}

alias todo=todoFunc
