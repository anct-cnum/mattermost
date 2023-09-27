#!/bin/bash -l
wget https://releases.mattermost.com/9.0.0/mattermost-9.0.0-linux-amd64.tar.gz -O - | tar -xvz
mkdir ./mattermost/plugins/
wget https://github.com/streamer45/mattermost-plugin-voice/releases/download/v0.3.0/com.mattermost.voice-0.3.0.tar.gz -O - | tar -xzvf - -C ./mattermost/plugins/
cp config.json mattermost/config
