function __zummi_history_search --description "Search shell history"
    set -l query (commandline)
    zummi history list --null \
    | eval "fzf $FZF_DEFAULT_OPTS --read0 --tac --sync -n2..,.. --tiebreak=index \
        --bind=ctrl-r:toggle-sort --no-multi --query=\"$query\" --expect=del --print0" \
    | sed '1 s/\x0/\n/;s/\x0//g' \
    | read --local --null val
    # if assignment failed (CTRL-C or otherwise) return with error
    if test $status != 0
        commandline -f repaint
        # TODO: this doesn't propagate status to shell
        return 1
    end

    set -l key (echo $val | head -1)
    set -l cmd (echo $val | tail -n +2 | sed '1 s/^\ *[0-9][0-9]*\ *//')

    if test $key = 'del'
        echo
        echo -n "Delete history entry '$cmd'?"
        read --local --nchars=1 --prompt-str="[Y/n]: " answer
        if test $answer = '' ;or test $answer = 'y' ;or test $answer = 'Y'
            set -l id (echo $val | sed -n '2 s/^\ *\([0-9][0-9]*\)\ .*/\1/p')
            zummi history delete $id
        end
    else
        commandline -- $cmd
    end
    # this is needed when function is bound to key
    commandline -f repaint
end
