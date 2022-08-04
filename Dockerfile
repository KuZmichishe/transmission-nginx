FROM alpine:latest

### Install Applications
RUN apk --no-cache update && \
	apk add --no-cache \
	transmission-daemon \
	bash

### Remove cache and tmp data
RUN rm -rf \
	/var/cache/apk/* \
	/tmp/* \
	/var/tmp/*

RUN mkdir -p /transmission/downloads \
  	&& mkdir -p /transmission/incomplete \
  	&& mkdir -p /etc/transmission-daemon

RUN mkdir -p /transmission/config \
    && chmod -R 1777 /transmission

EXPOSE 9091 51413/tcp 51413/udp

STOPSIGNAL SIGTERM

RUN chmod +x /start-transmission.sh
CMD ["/start-transmission.sh"]

#ENTRYPOINT ["/usr/bin/transmission-daemon", "--foreground", "--config-dir", "/transmission/config"]