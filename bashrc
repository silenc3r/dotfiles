#----------------------------------------------------
# file:     ~/.bashrc
# author:   Dawid Zych  dawidzych@fastmail.fm
# vim:fenc=utf-8:nu:ai:et:ts=4:sw=4:fdm=indent:fdn=1:
#----------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. /usr/share/doc/pkgfile/command-not-found.bash
# . $HOME/Pobrane/base16-tomorrow.dark.sh

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
alias ll='ls -l'
alias la='ll -A --group-directories-first'
alias lA='ls -A --group-directories-first'

# cd
alias cd..='cd ..'
alias ..='cd ..'

alias su='su -'
alias ping='ping -c 3'
alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -c -h'

# safety features
alias rm='rm -I'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# clear screen for real (it does not work in Terminology)
alias cls=' echo -ne "\033c"'

# set -o vi

# path
PATH="$HOME/bin:$PATH"
# CDPATH=".:$HOME:/mnt/Storage:$CDPATH"

# -- Export thingy
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
# export _JAVA_AWT_WM_NONREPARENTING=1
# export JAVA_FONTS=/usr/share/fonts/TTF
# export R600_ENABLE_S3TC=1
# export AWT_TOOLKIT=MToolkit
export EDITOR="vi"
export VISUAL="/usr/bin/vim -X"

if [ -n "$DISPLAY" ]; then
    BROWSER=firefox
fi
export GREP_COLOR="1;31"
# export MPD_HOST=/mnt/md0/Audio/.mpd/socket
# export TERM_PROGRAM="rxvt-unicode-256color"

# if [[ -f "$HOME/.dotfiles/dircolors" ]] && [[ $(tput colors) == "256" ]]; then
#     # https://github.com/trapd00r/LS_COLORS
#     eval $( dircolors -b $HOME/.dotfiles/dircolors )
# fi
# -- disable ^S/^Q flow control -------------------------------------------
if tty -s ; then
    stty -ixon
    stty -ixoff
fi

# stty werase undef
# bind '"\C-w": backward-kill-word'

# enable recursive globbing
shopt -s extglob
# cd when entering just a path
shopt -s autocd
shopt -s checkwinsize

# prevent printing ^C at cancelled command
# stty -ctlecho
# When cancelling command with Ctrl-C replace text from the cursor position to
# the end of the line with red ✗.
# trap 'echo -ne "\033[1;31m"✗"\033[0K\033[0m"' INT


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
# Don't remember trivial 1-, 2- and 3-letter commands.
HISTIGNORE=?:??:???
HISTIGNORE=${HISTIGNORE}':exit:reset:clear:startx:shutdown'
# ingore duplicates and commands starting with spacebar
HISTCONTROL="ignoreboth:erasedups"

# Show abbreviated path in prompt
PROMPT_COMMAND='PS1X=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}")'
# Save each history entry immediately (protects against terminal crashes/
# disconnections, and interleaves commands from multiple terminals in correct
# chronological order).
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
# bash prompt style
PS1='\[\033[0m\]\[\033[1m\]\A\[\033[0m\] \u@\h \[\033[0;32m\]${PS1X}\[\033[0m\] $ '

# bash sudo completion
# complete -cf sudo
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Initialize fasd
eval "$(fasd --init auto)"

# cycle through possible completions
# [[ $- = *i* ]] && bind TAB:menu-complete

# less source highlighting (requires source-highlight)
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '
# less man page colors
export LESS_TERMCAP_mb=$'\033[0m'
export LESS_TERMCAP_md=$'\033[1;34m'
export LESS_TERMCAP_me=$'\033[0m'
export LESS_TERMCAP_se=$'\033[0m'
export LESS_TERMCAP_so=$'\033[1;7m'
export LESS_TERMCAP_ue=$'\033[0m'
export LESS_TERMCAP_us=$'\033[0;35m'

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
        -S | -D | -S[^ghilps]* | -R* | -U*)
            LC_ALL=C /usr/bin/sudo /usr/bin/pacman "$@" ;;
    *)      LC_ALL=C /usr/bin/pacman "$@" ;;
    esac
}

# mkcd
mkcd () { mkdir -p "$@" && cd "$@"; }

# # marks
# export MARKPATH=$HOME/.marks
# function jump {
#     cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
# }
# function mark {
#     mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
# }
# function unmark {
#     rm -i $MARKPATH/$1
# }
# function marks {
#     ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
# }
# _jump() {
#     local cur=${COMP_WORDS[COMP_CWORD]}
#     COMPREPLY=( $(compgen -W "$( ls $MARKPATH )" -- $cur) )
# }
# complete -F _jump jump
