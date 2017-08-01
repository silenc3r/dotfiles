if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

eval $(dircolors)

export EDITOR=nvim
export VISUAL=$EDITOR
export WINEARCH=win32

# export MPD_HOST=$XDG_CACHE_HOME/mpd/socket
export PYTHONDONTWRITEBYTECODE=1

export PYENV_ROOT="$HOME/.local/usr/pyenv"
if [ -z $TMUX ]; then
    export PATH=$HOME/.local/bin:$HOME/bin:$PYENV_ROOT/bin:$PATH
fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
alias penv=pyenv
complete -F _pyenv penv
alias pver='pyenv version'

# # OPAM configuration
alias oinit=". $XDG_DATA_HOME/opam/opam-init/init.sh > /dev/null 2> /dev/null || true"

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
# correct directory names and expand vars during tab-completion
shopt -s dirspell
shopt -s direxpand
# update window size after every command
shopt -s checkwinsize
# verify commands via history expansions
shopt -s histverify

shopt -s cdable_vars
export dots="/home/dawid/.dotfiles/"
# export projects="/mnt/storage/Projects"

# append to the history file, don't overwrite it
shopt -s histappend
# store multiline commands as one command
shopt -s cmdhist
if [ -n "$XDG_DATA_HOME" ]; then
    export HISTFILE="$XDG_DATA_HOME/bash/history"
fi
# load 10000 last commands from history, if you need more just grep a file.
HISTSIZE=10000
# Don't truncate HISTFILE - keep all your history, ever.
unset HISTFILESIZE
HISTIGNORE="?:??:???:????:&:[ ]*:history:clear:z *:j *"
# ingore duplicates and commands starting with spacebar
HISTCONTROL=ignoreboth:erasedups
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

ccd() { mkdir -p "$*" && cd "$*"; }

psgrep() { ps aux | grep -v grep | grep -i --color=none -e VSZ -e"$@"; }

# find simplified
fnd() {
    if [ $# -eq 1 ]; then
        find . -iname "*$**" 2>/dev/null
    else
        find "$1" -iname "*${*:2}*" 2>/dev/null
    fi
}

yt() {
    mpv "$@" &>/dev/null &
    disown
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
lh() { ls -d .!(|.) 2>/dev/null || true; }

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

alias rmpyc='find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete'

# clear screen for real (does not work in tmux)
alias cls=' echo -ne "\033c"'

# alias tmux='TERM=screen-256color tmux'
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias tm='tmux attach || tmux new'

# to prevent dnf using separate caches for user and root
alias dnf='sudo dnf'

alias xsel='xsel --logfile "$XDG_CACHE_HOME"/xsel/xsel.log'

GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_SHOW_UNTRACKED_FILES=no
source ~/.bash-git-prompt/gitprompt.sh
GIT_PROMPT_THEME=Custom
