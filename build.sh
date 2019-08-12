#!/bin/bash -x

DOCKER="$(docker run -e "MAKEFLAGS=-j2" -v "$(pwd)"/cache:/home/builder/.ccache -v "$(pwd)"/kodi:/home/builder/pkg -d makepkg bash -c 'cd ~/pkg && makepkg -Acs --noconfirm')"

TIME_TO_RUN=43
while test "$TIME_TO_RUN" -gt 0; do
    sleep 60
    echo Not sleeping!
    TIME_TO_RUN=$((TIME_TO_RUN-1))
    if (! (docker ps -q -a --no-trunc| grep "$DOCKER" > /dev/null)); then
        break
    fi
    docker logs --tail=50 "$DOCKER"
    (docker logs --tail=1 "$DOCKER" | grep 'Cleaning up.') &&  docker stop --time 1 "$DOCKER" && break
done

if (docker ps -q -a --no-trunc| grep "$DOCKER" > /dev/null); then
    docker stop --time 3 "$DOCKER"
fi
(test "$(find "$(pwd)"/kodi -name '*.tar.xz' | wc -l)" -eq 0  && exit 1 )|| exit 0
