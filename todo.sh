#! /bin/bash

showToDo(){
	#checks if there is anything in the todo.txt
	if [ $(cat ~/Todo/todo.txt | wc -l) -gt 0 ]
	then
		#the -e enables backslash escapes.
		echo -e "Prio\t\tEntry"
		cat ~/Todo/todo.txt
	else
		echo "Your to-do list is empty."
	fi
}

newToDo(){
	#checks if arithmetic value (left side) of priority is equal to its value.
	if [ $(($1)) != $1 ]
	then
		echo "Priority has to be a number."
	else
		#the ${@:2} takes every parameter and writes it in entry, starting with the second parameter.
		echo -e "$1\t${@:2}" >> ~/Todo/todo.txt
		#sorting the textfile numerically and in reverse and writes it in todo.txt
		sort -n -r -o ~/Todo/todo.txt ~/Todo/todo.txt
	fi
}

removeToDo(){
	toDelete=$1
	#checks if arithmetic value (left side) of toDelete is equal to its value.
	if [ $((toDelete)) != $toDelete ]
	then
		echo "Invalid input. NaN"
	else
		#creates backup of todo.txt and deletes the entry at the line number that has been put in.
		sed -i.bak "${toDelete}d" ~/Todo/todo.txt
	fi
}

wipeToDo(){
	#the -n writes a null into todo.txt, deleting every entry.
	echo -n "" > ~/Todo/todo.txt
}

printHelp(){
	#the -e enables backslash escapes.
	echo -e "NAME\n\ttodo - Organize your stuff in the shell.

PARAMETERS
\t-n : Enter new entry via stdin.
\t-r : Remove an entry at a certain line number via stdin 
\t	    (note that lines start at 1).
\t-w : Wiping the complete to-do list.
\t--help: Show help function."
}



if [ $# -eq 0 ]
then
	showToDo
else
	case "$1" in
		-n) newToDo $2 ${@:3};;
		-r) removeToDo $2;;
		-w) wipeToDo;;
		--help) printHelp ;;
		*) echo "Invalid parameter. Use --help."
	esac
fi
