
#here begin the lines added by todo_list_github
os=$("uname")

#it's up to you to set those variables
export TODO_PATH=~/todo
export SSH_PATH=~/.ssh/id_rsa

#export SSH_KEY=your_ssh_passphrase (optional)

#maybe you would have to change those var also
if [[ $os == "Darwin" ]]
then
    export BASH_AUTOCOMPLETE_PATH=/usr/local/etc/bash_completion.d/todo
    zstyle :compinstall filename '~/.zshrc'

    autoload compinit
    compinit
#have to remove those file to keep [vim TAB] working nicely
    rm ~/.zcompdum*
else
    export BASH_AUTOCOMPLETE_PATH=/etc/bash_completion.d/todo
fi

autoload bashcompinit
bashcompinit
source ${BASH_AUTOCOMPLETE_PATH}
source ~/Persos/todoHandler/todo.sh
#here end the lines added by todo_list_github
