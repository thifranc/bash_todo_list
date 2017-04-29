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

gitCompare () {
if [ $# -ne 1 ] ; then
  echo "Usage: gitCompare [path_to_compare]"
  return 1
fi
git='/.git'
abs_git=$1$git
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
