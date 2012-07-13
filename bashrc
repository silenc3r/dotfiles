#-----------------------------------------------------------------------------
# file:     ~/.bashrc
# author:   Dawid Zych
# vim:fenc=utf-8:nu:ai:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf:
#-----------------------------------------------------------------------------

# Check for an interactive session
[ -z "$PS1" ] && return

# aliases
alias dir='dir --color'
alias ls='ls -h --group-directories-first --color=auto'
alias la='ls -A'
alias ll='ls -lF'
alias lla='ls -alF'

# cd
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias cd...='cd ../..'

alias grep='grep --color=auto'
alias su='su -'
alias ping='ping -c 3'
alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -h'

# audio splitting
alias splitflac='shntool split -f *.cue -o flac *.flac'
alias splitape='shntool split -f *.cue -o flac *.ape'
alias splitwv='shntool split -f *.cue -o flac *.wv'
alias splitwav='shntool split -f *.cue -o flac *.wav'
alias cptag='cuetag.sh *.cue split-track*.flac'

# safety features
#alias cp='cp -i'
#alias mv='mv -i'
alias rm='rm -I'

alias yv='youtube-viewer'

# set -o vi

# bash prompt style
PS1='\[\e[0;32m\]\u@\h \[\e[1;33m\]\W\[\e[0;32m\] $\[\e[0m\] '

# path
PATH=$PATH:/home/silencer/bin/

# export thingy
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
# export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_FONTS=/usr/share/fonts/TTF
export R600_ENABLE_S3TC=1
# export AWT_TOOLKIT=MToolkit
export EDITOR="vim"
if [ -n "$DISPLAY" ]; then
     BROWSER=firefox
fi
export GREP_COLOR="1;33"
# export MPD_HOST=/mnt/md0/Audio/.mpd/socket
export TERM_PROGRAM="rxvt-unicode-256color"

if [[ -f "$HOME/.config/dircolors" ]] && [[ $(tput colors) == "256" ]]; then
    # https://github.com/trapd00r/LS_COLORS
    eval $( dircolors -b $HOME/.config/dircolors )
fi
# -- disable ^S/^Q flow control -------------------------------------------
if tty -s ; then
    stty -ixon
    stty -ixoff
fi

shopt -s histappend
export HISTFILE="$HOME/.bash_history_`hostname`"   # hostname appended to bash history filename
# file must be created manually, otherwise you won't have permission to edit it
export HISTSIZE=1000000                            # bash history will save N commands
export HISTFILESIZE=${HISTSIZE}                    # bash will remember N commands
export HISTCONTROL="ignoreboth:erasedups"          # ingore duplicates and spaces (ignoreboth, ignoredups, ignorespace)

# don't append the following to history: consecutive duplicate
# commands, ls, bg and fg, and exit
HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*:startx:..:..."
HISTIGNORE=${HISTIGNORE}':%1:%2:shutdown*'
export HISTIGNORE
PROMPT_COMMAND='history -a; history -n'

# bash sudo completion
complete -cf sudo
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

## TTY Colors
# -- LESS man page colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# -- linux console colors (jwr dark)
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P83d3d3d" #darkgrey
    echo -en "\e]P18c4665" #darkred
    echo -en "\e]P9bf4d80" #red
    echo -en "\e]P2287373" #darkgreen
    echo -en "\e]PA53a6a6" #green
    echo -en "\e]P37c7c99" #brown
    echo -en "\e]PB9e9ecb" #yellow
    echo -en "\e]P4395573" #darkblue
    echo -en "\e]PC477ab3" #blue
    echo -en "\e]P55e468c" #darkmagenta
    echo -en "\e]PD7e62b3" #magenta
    echo -en "\e]P631658c" #darkcyan
    echo -en "\e]PE6096bf" #cyan
    echo -en "\e]P7899ca1" #lightgrey
    echo -en "\e]PFc0c0c0" #white
    clear # bring us back to default input colours
fi

# pacman with sudo
pacman() {
    case $1 in
        -S | -D | -S[^sih]* | -R* | -U*)
            /usr/bin/sudo /usr/bin/pacman "$@" ;;
    *)      /usr/bin/pacman "$@" ;;
    esac
}

# Calculator
? () { echo "$*" | bc -l; } # $ ? 1337 - 1295 => 42
# mkcd
mkcd () { mkdir -p "$@" && cd "$@"; }
