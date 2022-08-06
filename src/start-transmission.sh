#!/bin/sh

set -e
SETTINGS=/etc/transmission-daemon/settings.json

if [[ ! -f ${SETTINGS}.bak ]]; then
	# Checks for USERNAME variable
	if [ -z "$USERNAME" ]; then
	  echo >&2 'Please set an USERNAME variable (ie.: -e USERNAME=john).'
	  exit 1
	fi
	# Checks for PASSWORD variable
	if [ -z "$PASSWORD" ]; then
	  echo >&2 'Please set a PASSWORD variable (ie.: -e PASSWORD=hackme).'
	  exit 1
	fi
	# Checks for DOWNLOAD Folder mount variable
	if [ -z "$DOWNLOAD_DIR" ]; then
	  echo >&2 'Please set a DOWNLOAD_FOLDER variable (ie.: -e DOWNLOAD_DIR=/transmission/download).'
	  exit 1
	fi
	# Checks for INCOMPLETE_DIR Folder mount variable
	if [ -z "$INCOMPLETE_DIR" ]; then
	  echo >&2 'Please set a INCOMPLETE_DIR variable (ie.: -e INCOMPLETE_DIR=/transmission/incomplete).'
	  exit 1
	fi
	# Checks for INCOMPLETE_DIR_ENABLED mount variable
	if [ -z "$INCOMPLETE_DIR_ENABLED" ]; then
	  echo >&2 'Please set a INCOMPLETE_DIR_ENABLED variable (ie.: -e INCOMPLETE_DIR_ENABLED=true).'
	  exit 1
	fi
	# Checks for WATCH_DIR mount variable
	if [ -z "$WATCH_DIR" ]; then
	  echo >&2 'Please set a WATCH_DIR variable (ie.: -e WATCH_DIR=/transmission/watch).'
	  exit 1
	fi
	# Checks for WATCH_DIR_ENABLED mount variable
	if [ -z "$WATCH_DIR_ENABLED" ]; then
	  echo >&2 'Please set a WATCH_DIR_ENABLED variable (ie.: -e WATCH_DIR_ENABLED=false).'
	  exit 1
	fi
	# Checks for PEERPORT mount variable
	if [ -z "$PEERPORT" ]; then
	  echo >&2 'Please set a PEERPORT variable (ie.: -e PEERPORT=51413).'
	  exit 1
	fi

	# Modify settings.json
	sed -i.bak -e "s/#rpc-password#/$PASSWORD/" $SETTINGS
	sed -i.bak -e "s/#rpc-username#/$USERNAME/" $SETTINGS
	sed -i.bak -e "s/#download-dir#/$DOWNLOAD_DIR/" $SETTINGS
	sed -i.bak -e "s/#incomplete-dir#/$INCOMPLETE_DIR/" $SETTINGS
	sed -i.bak -e "s/#incomplete-dir-enabled#/$INCOMPLETE_DIR_ENABLED/" $SETTINGS
	sed -i.bak -e "s/#peerport#/$PEERPORT/" $SETTINGS
	sed -i.bak -e "s/#watch-dir#/$WATCH_DIR/" $SETTINGS
	sed -i.bak -e "s/#watch-dir-enabled#/$WATCH_DIR_ENABLED/" $SETTINGS
fi

unset PASSWORD USERNAME

exec /usr/bin/transmission-daemon --foreground --config-dir /etc/transmission-daemon