# Defined in - @ line 1
function tmux --wraps='tmux -f /home/dawid/.config/tmux/tmux.conf' --wraps='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf' --description 'alias tmux tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
 command tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf $argv;
end
