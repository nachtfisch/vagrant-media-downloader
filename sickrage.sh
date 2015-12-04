#!/bin/bash

APP_DIR=/home/vagrant/sickrage
MEDIA_DIR=/home/vagrant/media

docker run -d --name="sickrage" \
  -v $APP_DIR/config:/config \
  -v $MEDIA_DIR:/downloads  -v /etc/localtime:/etc/localtime:ro -p 8081:8081 needo/sickrage


# git clone https://github.com/timhaak/docker-sickrage.git 
# cd docker-sickrage
# docker build -t sickrage .

# docker run -d \
#  -v $APP_DIR/config:/config -v $APP_DIR/downloads:/data -p 8081:8081 sickrage
