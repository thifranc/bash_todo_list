# bash_todo_list
###A simple CLI todo_list synced with Github###

Bash todo list is a simple tool
to handle todo listing easily directly in your terminal

It provides mainly three settings :
* A basic file edition CLI
* A useful auto-completion to see your todo list names (try it by typing "todo [TAB]")
* A git-watcher to automatically pull when needed

Warning : You need to have a SSH-key to use the git-watcher  
If you want one : follow this [link](https://help.github.com/articles/connecting-to-github-with-ssh/)  
And look up your zshrc file to add SSH_KEY as environnement variable not to be bothered by a prompt  

###Quick Start###

```
git clone https://github.com/thifranc/bash_todo_list.git
cd ./bash_todo_list
bash ./install.sh
```
Then the ~/todo directory should become the folder for all of your todo lists !

Commands provided :
* todo see [todo_list name] -> display your todo list
* todo add [todo_list name] "[new_todo]" -> append a new todo in the list provided as argument
* todo rm [todo_list name] 
  - [todo line number] -> remove the todo whose number was provided
  - [matching word] -> will search for matching word and remove the corresponding todo task, if none or many matches, you'll be warned
  - all -> will remove the file
* todo save -> will commit "todo updated" and push on your repo-master

I'll keep working on it to smoothen user experience in installation and at use  
But feel free to PR me or send me any idea you'd have !
