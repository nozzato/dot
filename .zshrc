#!/bin/zsh

### Plugins

source '/usr/share/zsh-antidote/antidote.zsh'
antidote load && clear

### General options

setopt interactivecomments
setopt prompt_subst
unsetopt flow_control

# Enable custom hooks
autoload -Uz add-zsh-hook

### Completion

# Enable completion
zstyle :compinstall filename '/home/noah/.zshrc'

autoload -Uz compinit
compinit

# Highlight selected file
zstyle ':completion:*' menu select

zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Colorize menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Options
setopt no_list_ambiguous

### Hooks

# Dynamic title
function xterm_title_precmd () {
    print -Pn -- '\e]2;st - %n@%m %~\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
    print -Pn -- '\e]2;st - %n@%m %~ %# ' && print -n -- "${(q)1}\a"
    [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" != linux ]]; then
    add-zsh-hook -Uz precmd xterm_title_precmd
    add-zsh-hook -Uz preexec xterm_title_preexec
fi

# Pacman rehash
zshcache_time="$(date +%s%N)"

function rehash_precmd() {
    if [[ -a /var/cache/zsh/pacman ]]; then
        local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
        if (( zshcache_time < paccache_time )); then
            rehash
            zshcache_time="$paccache_time"
        fi
    fi
}

add-zsh-hook -Uz precmd rehash_precmd

### Tweaks

# Clear the screen correctly
function clear_screen() {
    echoti clear
    precmd
    zle redisplay
}
zle -N clear_screen

### Prompt

ZLE_RPROMPT_INDENT=0

# Left prompt
PROMPT='%B%F{cyan}%n%f%b@%B%F{cyan}%m%f%b:%B%F{white}%~%f%b %# '

# Right prompt
#RPROMPT=''

### History

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

# Options
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

### Directory

# Options
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushdminus

### vi mode

# Enable vi mode 
bindkey -v

# Remove delay when entering normal mode
KEYTIMEOUT=5

# Change cursor shape for different modes
function zle-keymap-select() {
    case $KEYMAP in
        vicmd)
            echo -ne '\e[1 q' # block
            ;;
        viins|main)
            echo -ne '\e[5 q' # bar
            ;;
    esac
}
zle -N zle-keymap-select

function zle-line-init() {
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Change cursor shape to bar on startup
echo -ne '\e[5 q'
# Change cursor shape to bar for each new prompt
function preexec() {
    echo -ne '\e[5 q' ;
}

### Keybinds

source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-beginning-search
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-beginning-search
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-history
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-history
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
bindkey "^X" push-line-or-edit

### Aliases

if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

### Fetch

#neofetch

### Syntax highlighting

typeset -A ZSH_HIGHLIGHT_STYLES

# Override highlighting styles
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[comment]='fg=246'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

# Disable highlighting pasted text
zle_highlight+=(paste:none)
