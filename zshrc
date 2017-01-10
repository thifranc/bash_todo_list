
export TODO_PATH=~/todo
export BASH_AUTOCOMPLETE_PATH=/etc/bash_completion.d/todo
export SSH_PATH=~/.ssh/id_rsa

#export SSH_KEY=your_ssh_passphrase (optional)

autoload bashcompinit
bashcompinit
source ${BASH_AUTOCOMPLETE_PATH}

~/todoHandler.sh

addTodo(){
    echo "$2" >> ${TODO_PATH}/$1
}
rmTodo(){
	sed -i -e "${2}d" ${TODO_PATH}/$1
}
seeTodo(){
	cat -n "${TODO_PATH}/$1"
}
alias addtodo=addTodo
alias rmtodo=rmTodo
alias todo=seeTodo
