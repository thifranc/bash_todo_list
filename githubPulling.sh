#!/bin/bash

sshConnect () {
eval "$(ssh-agent)"
if [ $# = 2 ] ; then
pass=$(echo $2)

#beware expect needs to be installed
expect << EOF
  spawn ssh-add $1
  expect "Enter passphrase"
  send "$pass\r"
  expect eof
EOF
elif [ $# = 1 ] ; then
    ssh-add $1
else
    echo "Wrong numbers of arguments"
fi
}

gitCompare () {
if [ $# -ne 1 ] ; then
  echo "Usage: gitCompare [path_to_compare]"
  return 1
fi


REPO_NAME=$(echo $1 | awk -F\! '{print $1}')
BRANCH_NAME=$(echo $1 | awk -F\! '{print $2}')
if [ -z $BRANCH_NAME ]
then
    BRANCH_NAME='master'
fi

git='/.git'
abs_git=$REPO_NAME$git
#get url of git repo
url=$(git --git-dir $abs_git config --get remote.origin.url)


sha_remote=$(git ls-remote $url HEAD | awk '{print $1;}')
sha_local=$(git --git-dir $abs_git rev-parse origin/$BRANCH_NAME)

if [ $sha_remote = "$sha_local" ]
then
	echo "up to date with $REPO_NAME"
else
	echo "should update $REPO_NAME"
	cd $REPO_NAME
	git pull origin $BRANCH_NAME
	cd -
fi
}

gitWatcher () {

#iterate through all received arg and check git Sync
for abs_path in "$@"; do
    gitCompare $abs_path
done
}

#pass env var to benefit from bash autocompletion
gitSave () {
	cd $1
	git add .
	git commit -m "$1 updated"
	git push origin master
	cd -
}

