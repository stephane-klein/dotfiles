#!/bin/sh

mkdir -p ~/.local/opt/activitywatch/
curl -sL https://github.com/2e3s/awatcher/releases/download/v0.2.3/awatcher-bundle.zip | bsdtar -xvf- --cd ~/.local/opt/activitywatch/

chmod u+x ~/.local/opt/activitywatch/awatcher

mkdir -p ~/.config/systemd/user
cat << EOF > ~/.config/systemd/user/awatcher.service
[Service]
Type=simple
ExecStart=${HOME}/.local/opt/activitywatch/awatcher

[Unit]
Description=ActivityWatch Server (Rust implementation)
Wants=network.target

[Install]
WantedBy=default.target
EOF
chmod 644 ~/.config/systemd/user/awatcher.service
systemctl --user daemon-reload
systemctl --user start awatcher.service
systemctl --user enable awatcher.service

echo "Don't forget to install https://extensions.gnome.org/extension/5592/focused-window-d-bus/"
echo "Install this Firefox extension https://addons.mozilla.org/en-US/firefox/addon/aw-watcher-web/"
