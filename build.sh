#!/bin/bash

while true; do
    echo Not sleeping!
    sleep 60
done &

NON_SLEEPING_PID="$!"

docker run -v "$(pwd)"/cache:/home/builder/.ccache -v "$(pwd)"/kodi:/home/builder/pkg -it makepkg bash -c 'cd ~/pkg && makepkg -Acs --noconfirm'

kill $NON_SLEEPING_PID
