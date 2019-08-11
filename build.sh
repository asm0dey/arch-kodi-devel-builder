#!/bin/bash -x

docker run -v "$(pwd)"/cache:/home/builder/.ccache -v "$(pwd)"/kodi:/home/builder/pkg -i makepkg bash -c 'cd ~/pkg && makepkg -Acs --noconfirm' &
NON_SLEEPING_PID="$!"

TIME_TO_RUN=38
while true; do
    sleep 60
    echo Not sleeping!
    TIME_TO_RUN=$((TIME_TO_RUN-1))
    test $TIME_TO_RUN -eq 0 && kill -9 $NON_SLEEPING_PID
done &
SLEEPING_PID="$!"

wait "$NON_SLEEPING_PID" && kill "$SLEEPING_PID"
