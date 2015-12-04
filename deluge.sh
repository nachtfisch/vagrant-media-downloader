#!/bin/bash

docker run -d -p 8112:8112 -p 1080:1080 \
    --name torrent \
    --dns=8.8.8.8 \
    --cap-add=NET_ADMIN \
    -v /home/vagrant/config:/torrents \
    -v /home/vagrant/downloads:/app/deluge \
    -v /etc/localtime:/etc/localtime:ro \
    -e DELUGE_UID=500 -e DELUGE_GID=500 \
    -e HOST_SUBNET=192.168.33.0/24 \
    -e PIA_USER="`awk '{print $1}' pia.conf`" \
    -e PIA_PASS="`awk '{print $2}' pia.conf`" \
    -e PIA_GATEWAY="nl.privateinternetaccess.com" \
    jbogatay/piavpn
