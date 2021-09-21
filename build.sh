#!/bin/bash -l
wget https://releases.mattermost.com/5.39.0/mattermost-5.39.0-linux-amd64.tar.gz -O - | tar -xvz
cp config.json mattermost/config
