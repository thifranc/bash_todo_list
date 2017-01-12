#!/bin/bash
#fail : this is not bash
os=$("uname")

if [[ $os == "Darwin" ]]
then
compinstall
fi
echo zshrc >> ~/.zshrc
mv todoHandler.sh ~
mv todo $BASH_AUTOCOMPLETE_PATH
