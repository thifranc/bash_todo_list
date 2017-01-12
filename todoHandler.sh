#!/bin/bash

sshConnect () {
eval $(ssh-agent)
if [ $# == 2 ] ; then
pass=$(echo $2)

#beware expect needs to be installed
expect << EOF
  spawn ssh-add $1
  expect "Enter passphrase"
  send "$pass\r"
  expect eof
EOF
elif [ $# == 1 ] ; then
    ssh-add $1
else
    echo "Wrong numbers of arguments"
fi
}

gitWatcher () {
if [ $# -ne 1 ] ; then
  echo "Usage: gitWatcher [path_to_watch]"
  return 1
fi
#take $1 as argument of folder to watch
abs_path=$1
git='/.git'

abs_git=$abs_path$git

#get url of git repo
url=$(git --git-dir $abs_git config --get remote.origin.url)

sha_remote=$(git ls-remote $url HEAD | awk '{print $1;}')
sha_local=$(git --git-dir $abs_git rev-parse origin/master)

if [ "$sha_remote" == "$sha_local" ]
then
	echo "up to date with $1"
else
	echo "should update $1"
	cd $abs_path
	git pull origin master
	cd -
fi
}

sshConnect ${SSH_PATH} ${SSH_KEY}
gitWatcher ${TODO_PATH}
