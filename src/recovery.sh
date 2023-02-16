#!/bin/bash

. infos.conf

#	Error return	#
return_error="echo status=aborted: "
download_packages="echo download packages"
get_data="echo get data"
git_setup="echo git setup"

#	Drive copy	#
USB="/media/user35p74a/saves"

_create_folders() {
	echo "recovery: initializing folders ? (y/a)"
	read input
	if [[$input == "y"]];then
		mkdir -p ~/.saved_conf/zshrc ~/.server_conf/html
		echo "recovery: done"
	else
		$return_error
		$create_folder
	fi
}

_download_packages() {
	echo "recovery: downloading/updating packages ? (y/a)"
	read input
	if [[$input == "y"]];then
		sudo pacman -Suy zsh vlc git neovim docker.io firefox discord spotify bitwarden typora
		echo "recovery: done"
	else
		$return_error
		$download_packages
	fi
}

_get_data_from_server() {
	echo "recovery: downloading backups ? (y/a)"
	read input
	if [[$input == "y"]];then
		scp -r -P $port $user@$server:$serverpath/* ~/.saved_conf/temp
		echo "recovery: done"
	else
		$return_error
		$get_data
	fi
}

_setting_up_git() {
	echo "recovery: generating ssh key ? (y/a)"
	read input
	if [[$input == "y"]];then
		ssh-keygen -t rsa -N '' -f ~/.ssh/git_ssh
		clear
		cat "~/.ssh/git_ssh"
		echo "WARNING: register the generated key in git\nPress ENTER when it's done"
		read timeout
		git config --global user.email $email
	else
		$return_error
		$git_setup
	fi
}

_setting_up_folders() {
	echo "not yet implemented"
}
