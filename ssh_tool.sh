#!/bin/bash

clear
echo "Welcome to this ssh login and sending tool."
echo "You will be able to connect to ssh servers and send local packets to it."
printf "\n" 

PS3='Choose your program: '
options=("Login to ssh server" "Push a locale file" "Recover config" "Save config" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"Login to ssh server")
			./src/login.sh
			;;
		"Push a locale file")
			./src/push.sh
			;;
		"Recover config")
			./src/recovery.sh
			;;
		"Save config")
			./src/saver.sh
			;;
		"Quit")
    			break
        		;;
		*) echo "invalid option $REPLY";;
	esac
done
