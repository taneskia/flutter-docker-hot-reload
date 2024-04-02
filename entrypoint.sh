#!/bin/bash

flutter pub get

# start a session that runs the flutter development web server
tmux new-session -d -s flutterSession -n flutterWindow
tmux send-keys -t flutterSession:flutterWindow "flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080" Enter

# start a session that runs a filewatcher and sends the "R" key to the flutter session when files are changet - triggering a hot restart
tmux new-session -d -s watcherSession -n watcherWindow
tmux send-keys -t watcherSession:watcherWindow "while inotifywait -e close_write -r lib/; do tmux send-keys -t flutterSession:flutterWindow "R" Enter; done" Enter

export TERM=xterm

rm -f /tmp/tmuxpipe && mkfifo /tmp/tmuxpipe && tmux pipe-pane -t flutterSession:flutterWindow -o 'cat >> /tmp/tmuxpipe' && cat /tmp/tmuxpipe