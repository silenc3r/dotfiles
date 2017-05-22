# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

eval $(dircolors)

hash nvim 2>/dev/null && _EDITOR=nvim || _EDITOR=vim

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

# better font rendering in java apps
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb -Dswing.aatext=true'
# fix java apps in xmonad
# export _JAVA_AWT_WM_NONREPARENTING=1
# export AWT_TOOLKIT=MToolkit
# export EDITOR="vi"
export EDITOR=$_EDITOR
export VISUAL=$_EDITOR
export WINEARCH=win32

# export MPD_HOST=$XDG_CACHE_HOME/mpd/socket

# bad bad openSUSE
export SMLNJ_HOME=/usr/lib/smlnj/

export PYENV_ROOT="$HOME/.local/usr/pyenv"
export PATH=$HOME/.local/bin:$HOME/bin:$PYENV_ROOT/bin:$PATH

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
alias penv=pyenv
complete -F _pyenv penv

# prevent terminal from overwriting Ctrl-s shortcut
stty -ixon

# prevent file overwrite on stdout redirection
# use `>|` to force redirection to an existing file
set -o noclobber
# turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar
# case-insensitive globbig (used in pathname expansion)
shopt -s nocaseglob
# cd when entering just a path
shopt -s autocd
# correnct minor errors in the spelling of directories
shopt -s cdspell
# correct spelling errors during tab-completion
shopt -s dirspell
# update window size after every command
shopt -s checkwinsize
# verify commands via history expansions
shopt -s histverify

shopt -s cdable_vars
export projects="/mnt/storage/Projects"

# append to the history file, don't overwrite it
shopt -s histappend
# store multiline commands as one command
shopt -s cmdhist
# load 10000 last commands from history, if you need more just grep a file.
HISTSIZE=10000
# Don't truncate ~/.bash_history -- keep all your history, ever.
unset HISTFILESIZE
HISTIGNORE="?:??:???:????:&:[ ]*:history:clear:z *:j *"
# ingore duplicates and commands starting with spacebar
HISTCONTROL="erasedups:ignoreboth"
# Add a timestamp to each history entry.
HISTTIMEFORMAT='%F %T'

PROMPT_COMMAND="history -a"

# # http://pempek.net/articles/2013/10/27/pretty-elided-shell-prompt/
# PS1_PWD_MAX=10
# __pwd_ps1() { echo -n $PWD | sed -e "s|${HOME}|~|" -e "s|\(/[^/]*/\).*\(/.\{${PS1_PWD_MAX}\}\)|\1…\2|"; }
# source /usr/share/git-core/contrib/completion/git-prompt.sh 2>/dev/null
# source /etc/bash_completion.d/git-prompt.sh 2>/dev/null
#
# GIT_PS1_SHOWDIRTYSTATE=1
# if [ "$TERM" != "linux" ]; then
#     # PS1='\[\033[0;97m\]$(__pwd_ps1)\[\033[0;93m\]$(__git_ps1 " (%s)")\[\033[0;34m\]❯\[\033[0m\] '
#     PS1='\[\033[1m\]$(__pwd_ps1)\[\033[1;30m\]$(__git_ps1 " (%s)")\[\033[0;34m\]❯\[\033[0m\] '
#     # PS1='\033[1m$(__pwd_ps1)\033[0m$(__git_ps1 " (%s)")\[\033[0;34m\]❯\[\033[0m\] '
# fi

export _Z_DATA=$XDG_DATA_HOME/z/data
[ -f ~/.z/z.sh ] && source ~/.z/z.sh

export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
    unalias z 2> /dev/null
    j() {
        [ $# -gt 0 ] && _z "$*" && return
        cd "$(_z -l 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
    }
fi

# # colored less output
# export LESS='-R '
# export LESS_TERMCAP_mb=$'\033[1;34m' # begin blinking
# export LESS_TERMCAP_md=$'\033[1;34m' # begin bold
# export LESS_TERMCAP_me=$'\033[0m'    # end mode
# export LESS_TERMCAP_se=$'\033[0m'    # end standout-mode
# export LESS_TERMCAP_so=$'\033[1;7m'  # begin standout-mode - info box
# export LESS_TERMCAP_ue=$'\033[0m'    # end underline
# export LESS_TERMCAP_us=$'\033[1;36m' # begin underline

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

ccd() { mkdir -p "$*" && cd "$*"; }

psgrep() { ps aux | grep -v grep | grep "$@" -i --color=auto; }

# find simplified
fnd() {
    if [ $# -eq 1 ]; then
        find . -iname "*$**" 2> /dev/null
    else
        find "$1" -iname "*${*:2}*" 2>/dev/null
    fi
}

yt() {
    mpv "$@" &>/dev/null &
    disown
}

ytw() { # YOUTUBE WATCH
    if [ $# -eq 2 ]; then
        mpv --ytdl-format=22 ytdl://ytsearch$2:"$1";
    else
        mpv --ytdl-format=22 ytdl://ytsearch10:"$1";
    fi;
}

ytfm() { # YOUTUBE FM (ONLY AUDIO)
    mpv --no-video ytdl://ytsearch10:"$@";
};

nohist() { unset HISTFILE; }
hsync() { history -a && history -n; }

# transmission helpers
trl() { transmission-remote -l; }
trd() { transmission-remote -t $1 --remove-and-delete; }
trr() { transmission-remote -t $1 --remove; }
tri() { transmission-remote -t $1 --info; }

# aliases
alias dmesg='dmesg --color'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls --color=auto --group-directories-first'
alias la='ls --almost-all'
alias ll='ls -l --human-readable'
alias lla='ll --almost-all'
alias l1='ls -1'
# list hidden files only
alias lh='ls -d .!(|.) 2>/dev/null'

alias ..='cd ..'  # redundant with autocd
alias ...='cd ../..'

alias su='su -'
alias sudo='sudo '  # make aliases work with sudo
alias ping='ping -c 3'
alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -c -h'

# safety features
hash trash 2>/dev/null && alias rm='trash' || alias rm='rm -I'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# clear screen for real (does not work in tmux)
alias cls=' echo -ne "\033c"'

# alias tmux='TERM=screen-256color tmux'
alias tm='tmux attach || tmux new'

# to prevent dnf using two caches (one for user and one for root)
alias dnf='sudo dnf'

GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_SHOW_UNTRACKED_FILES=no
source ~/.bash-git-prompt/gitprompt.sh
GIT_PROMPT_THEME=Custom
