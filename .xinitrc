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
hsetroot -solid "#15161e"
picom &

# Audio
pulseaudio-equalizer enable

# Keymap
setxkbmap gb
setxkbmap -option caps:backspace
xmodmap -e "clear Lock"
setxkbmap -option shift:both_capslock
setxkbmap -option compose:ralt
xmodmap -e "keycode 135 = backslash bar"
numlockx

# Daemons
slstatus &
clipmenud &
dunst &
nm-applet &
xbanish -s -i shift -i lock -i control -i mod1 -i mod4 -t 60 &
thunar --daemon &
otd &

# Programs
pavucontrol &
keepassxc &
ncmpcpp-st &
thunderbird &

# Start dwm
exec dwm
