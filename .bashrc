## shell

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# shell prompt
PS1="[\u@\h \W]\$ "

# history size
HISTSIZE=10000

# sudo askpass
export SUDO_ASKPASS=/usr/bin/dpass

# default editor
export EDITOR="nvim"

# line editor
source /usr/share/blesh/ble.sh --attach=none

# ranger
RANGER_LOAD_DEFAULT_RC=FALSE

## programs

# clear login shell
clear

# if in the X server, run neofetch, with a 1/100 chance to print an image
if [ -n "$DISPLAY" ]; then  
    randNum=$(( $RANDOM % 100 + 1 ))
    if [ $randNum -ne 100 ]; then
        neofetch
    else
        tiv -aw 100 ~/pictures/general/cursed_pootis.png
        sleep 1
        clear
        tiv --reset
        neofetch
    fi
else
    if (( $(tty | cut -c9) == 1)); then
        # If in tty1, print some ASCII art
        echo
        echo
        toilet -f standard "Arch Linux"
    else
        # If in tty except tty1, run neofetch
        neofetch
    fi
fi

## aliases
#
# note: Commands in aliases will use aliases above them

alias archive="lrztar -zv"                                              # lrzip + tar + compress + maximum compression + verbose
alias autochmod="find . -type f -exec chmod -v 0755 {} + && find . -type d -exec chmod -v 0755 {} +"
                                                                        # chmod + recursive + files + directories + standard permissions
alias chmod="chmod -v"                                                  # chmod + verbose
alias chown="chown -v"                                                  # chown + verbose
alias cp="cp -iv"                                                       # cp + interactive + verbose
alias dd="dd -v"                                                        # dd + verbose
alias diff="diff --color=auto"                                          # diff + color
alias edit="dwmswallow $WINDOWID; emacs -bg '#1c1e16'"                  # emacs + dark background color
alias emacs="dwmswallow $WINDOWID; emacs -bg '#1c1e16'"                 # emacs + dark background color
alias gfpull="git reset --hard HEAD && git pull"                        # git + pull + force
alias gfpush="git push --force"                                         # git + push + force
alias grep="grep --ignore-case --color=auto"                            # grep + ignore case + color
alias highlight='less -ip'                                              # less + smart ignore case + start at pattern
alias inhibit="systemd-inhibit --what=shutdown:sleep:idle:handle-power-key:handle-suspend-key:handle-hibernate-key:handle-lid-switch"
                                                                        # disable suspend whilst process is executing
alias ip="ip -color=auto"                                               # ip + color
alias keymon="key-mon -m -l --key-timeout=0.2 --mouse-timeout=0"        # key-mon + show super key + large + short timeout
alias netbth="iwctl station wlan0 connect BTHub6-3Z67"                  # connect to home network with iwd
alias netjwa="iwctl station wlan0 connect TJWA"                         # connect to work network with iwd
alias netmdw="iwctl station wlan0 connect MDW"                          # connect to USB network with iwd
alias netscan="iwctl station wlan0 scan"                                # scan for networks with iwd
alias netup="rfkill unblock all"                                        # unblock network interface cards
alias less="less -i"                                                    # less + smart ignore case
alias ls="ls -Ahlv --group-directories-first --color=auto"              # ls + almost all + human readable + long format + sort numbers + color
alias lswd="ls -Ahlv --group-directories-first --color=never"           # ls + almost all + human readable + long format + sort numbers + no color
alias mpv="mpv --no-keepaspect-window"                                  # mpv + unlock window aspect ratio
alias mv="mv -iv"                                                       # mv + interactive + verbose
alias pubip="curl -4 ifconfig.co"                                       # fetch public ip address
alias rm="echo 'This is not the command you are looking for.'; false"   # print a reminder to use trash instead
alias s="dwmswallow $WINDOWID;"                                         # swallow
alias spad="proxychains ssh 86.139.141.227"                             # ssh + proxy + ArchDesk
alias sudo="sudo "                                                      # sudo + aliases
#alias st="tabbed -c -r 2 st -w ''"                                      # st + tabs
alias tiv="tiv -w $COLUMNS -h $LINES"                                   # tiv + fit width + fit height
alias tree="tree -aC"                                                   # tree + all + color
alias grub-update="grub-mkconfig -o /boot/grub/grub.cfg"                # regenerate grub.cfg
alias unarchive="lrzuntar -v"                                           # lrzip + tar + decompress + verbose
alias usage="pdu --progress --silent-errors --top-down"                 # pdu + progress bar + silent errors + highest directory first
alias usageall="pdu --min-ratio=0 --progress --silent-errors --top-down --total-width=$COLUMNS > /tmp/pdu && less -S /tmp/pdu && \rm /tmp/pdu"
                                                                        # pdu + all + progress bar + silent errors + highest directory first + 237 character width | less + no line wrap
alias usagedir="find . -maxdepth 1 -mindepth 1 -type d -exec du -sh {} \; | sort -rh | head"
                                                                        # find + current directory + sort by size
alias usagedisk="df -h"                                                 # df + human readable
alias vim="nvim"                                                        # neovim
alias ytdl="youtube-dl --ignore-errors --format 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --add-metadata --xattrs --all-subs --write-sub --convert-subs srt --embed-subs"
                                                                        # youtube-dl + best video + best audio + mp4 + metadata + subtitles
alias ytdla="youtube-dl -f 'bestaudio/best' -ciw -o '%(title)s.%(ext)s' -v --extract-audio --audio-quality 0 --audio-format mp3 --add-metadata --xattrs"
                                                                        # youtube-dl + best audio + mp3 + metadata

## completions
complete -cf sudo


## line editing

if [ -n "$DISPLAY" ]; then  
    # If in the X server, load the line editor
    [[ ${BLE_VERSION-} ]] && ble-attach
else
    # If in a tty except tty1, load the line editor
    if (( $(tty | cut -c9) != 1)); then
        [[ ${BLE_VERSION-} ]] && ble-attach
    fi
fi
