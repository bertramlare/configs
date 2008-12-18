#!/bin/bash

vim="/cygdrive/c/Progra~1/Vim/vim71/gvim.exe --servername gvim"

if [ -z $1 ]
then
	ps -W | grep -qi gvim
	vim_is_running=$?

	if [ $vim_is_running -eq 0 ]
	then
		beep
	else
		$vim &
	fi
else
	$vim --remote-tab-silent "$@" &
fi
