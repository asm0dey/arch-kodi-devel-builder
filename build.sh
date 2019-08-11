#!/bin/bash

docker run -v "$(pwd)"/cache:/home/builder/.ccache -v "$(pwd)"/kodi:/home/builder/pkg -i makepkg bash -c 'cd ~/pkg && makepkg -Acs --noconfirm' &
NON_SLEEPING_PID="$!"

(sleep 2700 && kill "$NON_SLEEPING_PID") &
SLEEPING_PID="$!"

wait "$NON_SLEEPING_PID" && kill "$SLEEPING_PID"
