#!/bin/bash

. conf_files/infos.conf

#	Error return	#
return_error="echo status=aborted: "
save_state="echo save_state"
send_data="echo send_data"
send_html="echo send_html"
#	Drive copy	#
USB="/media/user35p74a/saves"

_save_state() {
	tree ~/.config
	echo "saver: overwrite conf files ? (y/a)"
	read input
	if [[$input == "y"]];then
		cp ~/.zshrc ~/.saved_conf/zshrc
		cp ~/.config ~/.saved_conf/
	else
		$return_error
		$save_state
	fi
}

_send_data_to_server() {
	tree ~/.saved_conf
	echo "saver: upload conf files ? (y/a)"
	read input
	if [[$input == "y"]];then
		scp -r -P $port ~/.saved_conf/* $user@$server:/$serverpath/saved_conf/
	## make folder conf depending on push date + deletion of older versions
	else
		$return_error
		$send_data
	fi
}

_send_html_to_server() {
	tree ~/.server_conf
	echo "saver: upload web page ? (y/a)"
	read input
	if [[$input == "y"]];then
		scp -r -P $port ~/.server_conf/html/* $user@$server:/var/www/html/
	else
		$return_error
		$send_html
	fi
}

_check_server() {
	ssh $user@$server $port
}

_reload_server() {
	echo "not yet implemented"
}

echo "Action selector to be done"
exit 0
