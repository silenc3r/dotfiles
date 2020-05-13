if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if set -q $OPAM_SWITCH_PREFIX
    or test -z $OPAM_SWITCH_PREFIX
    and test -r $OPAMROOT/opam-init/init.fish
    source $OPAMROOT/opam-init/init.fish
end
