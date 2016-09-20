#!/usr/bin/env sh

if [ -f /data/config.json ]; then
	echo "-=> riot.im config file found, ... rebuild sources"
	cd /riot-web
	cp /data/config.json /riot-web/config.json

	npm run build
fi

CONFFILENAME="/data/riot.im.conf"

if [ -f /data/vector.im.conf ] && [ ! -f ${CONFFILENAME} ]; then
	echo "please rename your conffile \"/data/vector.im.conf\" to \"${CONFFILENAME}\""
	CONFFILENAME=/data/vector.im.conf
fi


if [ -f ${CONFFILENAME} ]; then
	options=""

	while read -r line; do
		[ "${line:0:1}" == "#" ] && continue
		[ "${line:0:1}" == " " ] && continue
		options="${options} ${line}"
	done < ${CONFFILENAME}

	cd /riot-web/vector
	echo "-=> riot.im options: http-server ${options}"
	http-server ${options}
else
	echo "You need a conffile /data/riot.im.conf in you conf folder"
	exit 1
fi
