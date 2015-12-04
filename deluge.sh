#!/bin/bash

APP_DIR=/home/vagrant/torrent
MEDIA_DIR=/home/vagrant/media
mkdir -p $APP_DIR/config

docker run -d -p 8112:8112 -p 1080:1080 \
    --name torrent \
    --dns=8.8.8.8 \
    --cap-add=NET_ADMIN \
    -v $MEDIA_DIR:/torrents \
    -v $APP_DIR/config:/app/deluge \
    -v /etc/localtime:/etc/localtime:ro \
    -e DELUGE_UID=1000 -e DELUGE_GID=1000 \
    -e HOST_SUBNET=192.168.33.0/24 \
    -e PIA_USER="`awk '{print $1}' pia.conf`" \
    -e PIA_PASS="`awk '{print $2}' pia.conf`" \
    -e PIA_GATEWAY="nl.privateinternetaccess.com" \
    jbogatay/piavpn

sleep 10

docker exec -it torrent env TERM=linux deluge-console -c /app/deluge "config -s listen_interface 99.99.99.99"
docker exec -it torrent env TERM=linux deluge-console -c /app/deluge "config -s allow_remote True"
docker exec -it torrent env TERM=linux deluge-console -c /app/deluge "config -s move_completed True"
docker exec -it torrent env TERM=linux deluge-console -c /app/deluge "config -s move_completed_path /torrents"
docker exec -it torrent env TERM=linux deluge-console -c /app/deluge "config -s download_location /torrents/incomplete"

echo "admin:admin:10" >> /home/vagrant/torrent/config/auth
sleep 10

docker restart torrent
