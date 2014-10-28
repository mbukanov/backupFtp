#!/bin/bash
# backup ftp with wget
# wget keys:
# -r - recoursive
# -l 0 - inf(0) recoursive level(depth)
# -P - download to <param> directory
# -nH - don't create "ftp-server-name" - directory  ( because -P <dir> )

HOST="" 	#FTP
LOGIN=""
PASSWORD=""
TO=""
SUCCESS=true

while getopts h::l::p::t:: opts; do
	case ${opts} in
		h) HOST=${OPTARG} ;;
		l) LOGIN=${OPTARG} ;;
		p) PASSWORD=${OPTARG} ;;
		t) TO=${OPTARG} ;;
	esac
done

#debug
#echo "login = "$LOGIN
#echo "password = "$PASSWORD
#echo "HOST = "$HOST
#echo "TO = "$TO

# login is empty?
if [ -z "$LOGIN" ];
then
	echo "Error: Enter ftp with path: -h <ftp>"
	SUCCESS=false
fi

# password is empty ?
if [ -z "$PASSWORD" ];
then
	echo "Error: Enter password: -p <password>"
	SUCCESS=false
fi

# host is empty ?
if [ -z "$HOST" ];
then
	echo "Error: Enter host: -h <host>"
	SUCCESS=false
fi

# to is empty?
if [ ! -z "$TO" ];
then
	#if no empty: directory exists ?
	if [ ! -d "$TO" ];
	then
		echo "Error: directory "$TO" doesn't exists"
		SUCCESS=false
	fi
fi

if [ $SUCCESS = false ] ;
then
	echo "Usage: $0 -h <host> -l <login> -p <password> [-t /home/qeed/download/]"
	echo "Ex.: $0 -h myhost.com -l qeed -p 12345"
	exit 0
fi

if [ -z "$TO"]
then
	wget -r -l 0 -nH ftp://$LOGIN:$PASSWORD@$HOST
else
	wget -r -l 0 -nH ftp://$LOGIN:$PASSWORD@$HOST -P $TO
fi
