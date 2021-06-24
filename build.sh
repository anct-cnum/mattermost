#!/bin/bash -l
wget https://releases.mattermost.com/5.36.1/mattermost-5.36.1-linux-amd64.tar.gz -O - | tar -xvz
cp config.json mattermost/config
