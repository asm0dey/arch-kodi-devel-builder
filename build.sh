#!/bin/bash -x

timeout -k 5s 43m docker run -e "MAKEFLAGS=-j2" -v "$(pwd)"/cache:/home/builder/.ccache -v "$(pwd)"/kodi:/home/builder/pkg -i makepkg bash -c 'cd ~/pkg && makepkg -As --noconfirm'

test "$(find "$(pwd)"/kodi -name '*.tar.xz' | wc -l)" -gt 0  || exit 1
