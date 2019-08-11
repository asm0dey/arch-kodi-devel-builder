#!/bin/bash -x

DOCKER="$(docker run -e "MAKEFLAGS='-j 2'" -v "$(pwd)"/cache:/home/builder/.ccache -v "$(pwd)"/kodi:/home/builder/pkg -d makepkg bash -c 'cd ~/pkg && makepkg -Acs --noconfirm')"

TIME_TO_RUN=41
while true; do
    sleep 60
    echo Not sleeping!
    TIME_TO_RUN=$((TIME_TO_RUN-1))
    if (! (docker ps -q -a --no-trunc| grep "$DOCKER" > /dev/null)); then
        break
    fi
    test "$TIME_TO_RUN" -eq 0 && docker stop --time 3 "$DOCKER" && break
    test "$(find "$(pwd)"/kodi -name '*.tar.xz' | wc -l)" -eq 0 && exit 1
    docker logs --tail=50 "$DOCKER"
done
