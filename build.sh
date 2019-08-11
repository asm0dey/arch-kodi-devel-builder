#!/bin/bash -x

DOCKER="$(docker run -v "$(pwd)"/cache:/home/builder/.ccache -v "$(pwd)"/kodi:/home/builder/pkg -d makepkg bash -c 'cd ~/pkg && makepkg -Acs --noconfirm')"

TIME_TO_RUN=41
while true; do
    sleep 60
    echo Not sleeping!
    TIME_TO_RUN=$((TIME_TO_RUN-1))
    (docker ps -q | grep -v "$DOCKER" > /dev/null) &&  break
    test "$TIME_TO_RUN" -eq 0 && docker stop --time 3 "$DOCKER" && break
    docker logs --tail=50 "$DOCKER"
done
