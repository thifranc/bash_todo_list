os=$("uname")

#export SSH_KEY=your_ssh_passphrase (optional)

#maybe you would have to change those var also
if [[ $os == "Darwin" ]]
then
    zstyle :compinstall filename '~/.zshrc'

    autoload compinit
    compinit
#have to remove those file to keep [vim TAB] working nicely
    rm ~/.zcompdum*
fi

autoload bashcompinit
bashcompinit
source ${BASH_AUTOCOMPLETE_PATH}
source ~/todo.sh
