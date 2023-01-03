#!/bin/zsh

# print ascii text if on tty1
if [ "${XDG_VTNR}" -eq 1 ]; then
    clear
    echo
    echo
    echo -e "\e[36m"
    figlet "Arch Linux"
    echo -ne "\e[0m"
fi

# start dwm if on tty1
if [ -z "${display}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx
fi
