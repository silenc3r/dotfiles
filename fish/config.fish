if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end


# plugin directory
set -g fisher_path $XDG_CONFIG_HOME/fish/plugins

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end



# Ocaml stuff
if set -q $OPAM_SWITCH_PREFIX
    or test -z $OPAM_SWITCH_PREFIX
    and test -r $OPAMROOT/opam-init/init.fish
    source $OPAMROOT/opam-init/init.fish
end
