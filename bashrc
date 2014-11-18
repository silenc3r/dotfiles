#----------------------------------------------------
# file:     ~/.bashrc
# author:   Dawid Zych  dawidzych@fastmail.fm
#----------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -x /usr/bin/pkgfile ] && . /usr/share/doc/pkgfile/command-not-found.bash

# BASE16_SCHEME="railscasts"
# BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
# [[ -s $BASE16_SHELL ]] && . $BASE16_SHELL
GRUVBOX_SHELL="/home/dawid/.vim/plugged/gruvbox/gruvbox_256palette.sh"
[[ -s $GRUVBOX_SHELL ]] && . $GRUVBOX_SHELL

# aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.config/dircolors && eval "$(dircolors -b ~/.config/dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -hF --color=auto'

    alias dmesg='dmesg --color'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# other ls aliases
alias l1='ls -1'
alias ll='ls -l --group-directories-first'
alias la='ll -A'
alias lA='ls -A --group-directories-first'
# list hidden files only
alias lh='ls -d .??*'

# cd
alias ..='cd ..'  # redundant with autocd
alias ...='cd ../..'

alias su='su -'
alias ping='ping -c 3'
alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -c -h'
alias tmux='TERM=screen-it tmux -2'
# alias tmux='tmux -2'

# safety features
alias rm='rm -I'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# clear screen for real (does not work in tmux)
alias cls=' echo -ne "\033c"'

# path
PATH="$HOME/bin:$HOME/introcs/bin:$PATH"

# python virtualenvwrapper
if [ -x $(which virtualenvwrapper.sh) ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
    alias mkvirtualenv2='mkvirtualenv --python=/usr/bin/python2'
    alias mkvirtualenv3='mkvirtualenv --python=/usr/bin/python3'
fi

# -- Export thingy
# better font rendering in java apps
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'
# fix java apps in xmonad
# export _JAVA_AWT_WM_NONREPARENTING=1
# export JAVA_FONTS=/usr/share/fonts/TTF
# export AWT_TOOLKIT=MToolkit
# https://github.com/ThomasAdam/tmux/blob/master/FAQ#L355
# export TERM=screen-it
export EDITOR="vi"
export VISUAL="/usr/bin/vim -X"

if [ -n "$DISPLAY" ]; then
    BROWSER=firefox
fi
export GREP_COLOR="1;31"
# export MPD_HOST=/mnt/md0/Audio/.mpd/socket

# if [[ -f "$HOME/.dotfiles/dircolors" ]] && [[ $(tput colors) == "256" ]]; then
#     # https://github.com/trapd00r/LS_COLORS
#     eval $( dircolors -b $HOME/.dotfiles/dircolors )
# fi

# disable ^S/^Q flow control
# in other words, prevent terminal from overwriting Ctrl-s shortcut
if tty -s ; then
    stty -ixon
    stty -ixoff
fi

# enable recursive globbing
shopt -s extglob
# cd when entering just a path
shopt -s autocd
# correnct minor errors in the spelling of directories
shopt -s cdspell
# check windows size after each command and update LINES & COLUMNS
# if necessary
shopt -s checkwinsize

# Append to ~/.bash_history instead of overwriting it -- this stops terminals
# from overwriting one another's histories.
shopt -s histappend
# store multiline commands as single entries in history file
shopt -s cmdhist
# load 10000 last commands from history, if you need more just grep a file.
HISTSIZE=10000
# Don't truncate ~/.bash_history -- keep all your history, ever.
unset HISTFILESIZE
# Add a timestamp to each history entry.
# HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S  "
# Don't remember trivial {1,2,3,4}-letter commands.
HISTIGNORE=?:??:???:????
HISTIGNORE=${HISTIGNORE}':z *:v *'
# ingore duplicates and commands starting with spacebar
HISTCONTROL="ignoreboth:erasedups"

# Save each history entry immediately
PROMPT_COMMAND="history -a; history -n"
# display up to 2 directories on prompt
PROMPT_DIRTRIM=2
if [ $TERM == "linux" ]; then
    PS1='\[\033[0;97m\]\w\[\033[0;34m\]> \[\033[0m\]'
else
    PS1='\[\033[0;97m\]\w\[\033[0;34m\]❯ \[\033[0m\]'
fi

[ -f /etc/bash_completion ] && source /etc/bash_completion
# bash sudo completion
complete -cf sudo

# Initialize fasd
eval "$(fasd --init auto)"
alias v='f -t -e vim -b viminfo'

# less source highlighting (requires source-highlight)
if [ -x /usr/bin/source-highlight-esc.sh ]; then
    export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
fi
export LESS='-R '
# less man page colors
export LESS_TERMCAP_mb=$'\033[1;34m'   # begin blinking
export LESS_TERMCAP_md=$'\033[1;34m'   # begin bold
export LESS_TERMCAP_me=$'\033[0m'           # end mode
export LESS_TERMCAP_se=$'\033[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\033[1;7m'         # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\033[0m'           # end underline
export LESS_TERMCAP_us=$'\033[1;36m'   # begin underline

# -- linux console colors (jwr dark)
# if [ "$TERM" = "linux" ]; then
#     echo -en "\e]P0000000" #black
#     echo -en "\e]P83d3d3d" #darkgrey
#     echo -en "\e]P18c4665" #darkred
#     echo -en "\e]P9bf4d80" #red
#     echo -en "\e]P2287373" #darkgreen
#     echo -en "\e]PA53a6a6" #green
#     echo -en "\e]P37c7c99" #brown
#     echo -en "\e]PB9e9ecb" #yellow
#     echo -en "\e]P4395573" #darkblue
#     echo -en "\e]PC477ab3" #blue
#     echo -en "\e]P55e468c" #darkmagenta
#     echo -en "\e]PD7e62b3" #magenta
#     echo -en "\e]P631658c" #darkcyan
#     echo -en "\e]PE6096bf" #cyan
#     echo -en "\e]P7899ca1" #lightgrey
#     echo -en "\e]PFc0c0c0" #white
#     clear # bring us back to default input colours
# fi

# -- linux console colors (solarized)
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0073642" #black
    echo -en "\e]P8002b36" #darkgrey
    echo -en "\e]P1dc322f" #darkred
    echo -en "\e]P9cb4b16" #red
    echo -en "\e]P2859900" #darkgreen
    echo -en "\e]PA586e75" #green
    echo -en "\e]P3b58900" #brown
    echo -en "\e]PB657b83" #yellow
    echo -en "\e]P4268bd2" #darkblue
    echo -en "\e]PC839496" #blue
    echo -en "\e]P5d33682" #darkmagenta
    echo -en "\e]PD6c71c4" #magenta
    echo -en "\e]P62aa198" #darkcyan
    echo -en "\e]PE93a1a1" #cyan
    echo -en "\e]P7eee8d5" #lightgrey
    echo -en "\e]PFfdf6e3" #white
    clear # bring us back to default input colours
fi

# pacman with sudo
pacman() {
    case $1 in
        -S | -D | -S[^ghilps]* | -R* | -U*)
            LC_ALL=C /usr/bin/sudo /usr/bin/pacman "$@" ;;
    *)      LC_ALL=C /usr/bin/pacman "$@" ;;
    esac
}

# mkcd
md () { mkdir -p "$@" && cd "$@"; }
