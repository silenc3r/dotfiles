# function __reset_cursor --on-event fish_prompt
#     # 2 is block, 4 is underline, 6 is bar
#     printf "\x1b[3 q"
# end

string match -q -r '/home/[a-zA-Z]+/.local/share/npm/bin' $PATH || set -gx PATH "$HOME/.local/share/npm/bin" $PATH;
string match -q -r '/home/[a-zA-Z]+/.local/bin' $PATH || set -gx PATH "$HOME/.local/bin" $PATH;
string match -q -r '/home/[a-zA-Z]+/bin' $PATH || set -gx PATH "$HOME/bin" $PATH;

set -x FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS --color fg:#151515,bg:#f0f0f0,hl:#d82032,fg+:#000000,bg+:#c6c6c6,hl+:#d82032 --color info:#028b82,prompt:#336bd0,spinner:#028b82,pointer:#9e0f20,marker:#028b82,gutter:#c6c6c6
# set -x FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS --color=light,hl:#d82032,hl+:#d82032

set -x ZUMMI_DIR_IGNORE $HOME/.config/zummi/dir_ignore

# don't source it, let direnv do it's job
# source ~/.asdf/asdf.fish
set -gx PATH $PATH "$HOME/.asdf/bin"

direnv hook fish | source
