#!/bin/bash
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
