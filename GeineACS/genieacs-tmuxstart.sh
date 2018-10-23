#!/bin/sh

if sudo tmux has-session -t 'genieacs'; then
  echo "GenieACS is already running."
  echo "To stop it use: ./genieacs-stop.sh"
  echo "To attach to it use: tmux attach -t genieacs"
else
  sudo mkdir -p /tmp/tmux-1000/default
  sudo chmod 777 -R /tmp/tmux-1000/
  
  sudo chmod 777 ./server.conf
  sudo cp -p ./server.conf ./genieacs/config/config.json
  
  sudo chmod 777 ./auth.js
  sudo cp -p ./auth.js ./genieacs/config/auth.js

  sudo tmux new-session -s 'genieacs' -d -x 2000 -y 2000
  sudo tmux send-keys 'sudo redis-server' 'C-m'
  sudo tmux split-window
  sudo tmux send-keys 'sudo mongod' 'C-m'
  sudo tmux split-window
  sudo tmux send-keys './genieacs/bin/genieacs-cwmp' 'C-m'
  sudo tmux split-window
  sudo tmux send-keys './genieacs/bin/genieacs-nbi' 'C-m'
  sudo tmux split-window
  sudo tmux send-keys './genieacs/bin/genieacs-fs' 'C-m'
  sudo tmux split-window
  sudo tmux send-keys 'cd genieacs-gui' 'C-m'
  sudo tmux send-keys 'rails server' 'C-m'
  sudo tmux select-layout tiled 2>/dev/null
  sudo tmux rename-window 'GenieACS'

  echo "GenieACS has been started in tmux session 'geneiacs'"
  echo "To attach to session, use: tmux attach -t genieacs"
  echo "To switch between panes use Ctrl+B-ArrowKey"
  echo "To deattach, press Ctrl+B-D"
  echo "To stop GenieACS, use: ./genieacs-stop.sh"
  
  sudo tmux attach -t genieacs
fi

