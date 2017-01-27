todoFunc(){
	if [[ $1 == "see" ]]
	then
		cat -n "${TODO_PATH}/$2"
	elif [[ $1 == "add" ]]
	then
		if [ ! -f ${TODO_PATH}/$2 ]
		then
			printf '%s ' "File $2 is to be created? [y/n]"
			read ans
			if [[ "$ans" == "y" ]]
			then
				echo "$3" >> ${TODO_PATH}/$2
			else
				echo "Todo cancelled"
			fi
		else
			echo "$3" >> ${TODO_PATH}/$2
		fi
	elif [[ $1 == "rm" ]]
	then
		if [[ $3 == "all" ]]
		then
			rm ${TODO_PATH}/$2
		else
			if [[ $3 =~ '^[0-9]+$' ]]
			then
				sed -i -e "${3}d" ${TODO_PATH}/$2
			else
				match=$(grep "$3" ${TODO_PATH}/$2)
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
					line_number=$(grep -n "$3" ${TODO_PATH}/$2 | cut -d: -f1)
					sed -i -e "${line_number}d" ${TODO_PATH}/$2
				fi
			fi
			if [ ! -s ${TODO_PATH}/$2 ]
			then
				rm ${TODO_PATH}/$2
			fi
		fi
	elif [[ $1 == "save" ]]
	then
		cd ${TODO_PATH}
		git commit -am "todo updated"
		git push origin master
		cd -
	fi
}
alias todo=todoFunc
