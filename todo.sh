sedPolyfill(){
os=$("uname")
if [[ "$os" == "Darwin" ]]
then
    sed -i '' "${1}d" $2
else
    sed -i -e "${1}d" $2
fi
    
}

todoAdd(){
		if [ ! -f ${TODO_PATH}/$1 ]
		then
			printf '%s ' "File $1 is to be created? [y/n]"
			read ans
			if [[ "$ans" == "y" ]]
			then
				echo "$2" >> ${TODO_PATH}/$1
			else
				echo "Todo cancelled"
			fi
		else
			echo "$2" >> ${TODO_PATH}/$1
		fi
}

todoSave(){
		cd ${TODO_PATH}
        git add .
		git commit -m "todo updated"
		git push origin master
		cd -
}

todoRm(){
		if [[ $2 == "all" ]]
		then
			rm ${TODO_PATH}/$1
		else
			if [[ $2 =~ '^[0-9]+$' ]]
			then
                sedPolyfill $2 ${TODO_PATH}/$1
			else
				match=$(grep "$2" ${TODO_PATH}/$1)
                num_matches=$(echo ${match} | wc -l)
				if [ -z "$match" ]
				then
					echo "!! no matches !!"
					return 1
				elif [[ $num_matches -gt 1 ]]
				then
					echo "!! multiple matches !!"
					return 1
				else
					line_number=$(grep -n "$2" ${TODO_PATH}/$1 | cut -d: -f1)
                    sedPolyfill $line_number ${TODO_PATH}/$1
				fi
			fi
			if [ ! -s ${TODO_PATH}/$1 ]
			then
				rm ${TODO_PATH}/$1
			fi
		fi
}

todoFunc(){
	if [[ $1 == "see" ]]
	then
		cat -n "${TODO_PATH}/$2"
	elif [[ $1 == "add" ]]
	then
		todoAdd $2 $3
	elif [[ $1 == "rm" ]]
	then
		todoRm $2 $3
	elif [[ $1 == "save" ]]
	then
		todoSave
	else
		echo "usage: [see|add|rm|save]"
	fi
}
alias todo=todoFunc
