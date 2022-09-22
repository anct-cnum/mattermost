#!/bin/bash -l
wget https://releases.mattermost.com/7.3.0/mattermost-7.3.0-linux-amd64.tar.gz -O - | tar -xvz
mkdir ./mattermost/plugins/
wget https://github.com/streamer45/mattermost-plugin-voice/releases/download/v0.2.2/com.mattermost.voice-0.2.2.tar.gz -O - | tar -xzvf - -C ./mattermost/plugins/
cp config.json mattermost/config
