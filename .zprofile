#!/bin/zsh

# start dwm if on tty1
if [ -z "${display}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi
