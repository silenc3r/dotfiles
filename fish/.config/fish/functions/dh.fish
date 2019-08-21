# Defined in /tmp/fish.nuAkLp/dh.fish @ line 2
function dh
	if set -q argv[1]
        set fzf_query $argv[1]
    else
        set fzf_query ''
    end

    set -q FD_IGNORE
    or set FD_IGNORE /dev/null

    eval "fd --type directory --hidden --follow --ignore-file=\"$FD_IGNORE\" | fzf +m $FZF_DEFAULT_OPTS $FZF_CD_OPTS --query \"$fzf_query\"" | read -l select

    if not test -z "$select"
        builtin cd "$select"

        # Remove last token from commandline.
        commandline -t ""
    end
end
