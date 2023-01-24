#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Display
autorandr -c
xsetroot -solid "#15161e"
#nitrogen --restore

# Keymap
setxkbmap gb
setxkbmap -option caps:backspace
setxkbmap -option shift:both_capslock
xmodmap -e "clear Lock"
setxkbmap -option compose:ralt
numlockx

# Daemons
slstatus &
clipmenud &
dunst &
xbanish -s -i shift -i lock -i control -i mod1 -i mod4 -t 60 &
otd &
pulseaudio-equalizer enable

# Programs
thunderbird &
keepassxc &
pavucontrol &

# Start dwm
exec dwm
