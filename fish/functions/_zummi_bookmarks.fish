function _zummi_bookmarks --description "Jump to shell bookmark with zummi and fzf"
    function _bookmark_cd_or_remove
        set -l bmark (string trim --left $argv | string split --max 1 ' ')
        set -l name $bmark[1]
        set -l path (string trim --left $bmark[2])
        if not builtin cd $path
            read --local --nchars=1 --prompt="echo Remove bookmark \'$name\'\? [Y/n]\ " answer
            if test $answer = ''; or test $answer = 'y'; or test $answer = 'Y'
                zummi bookmark delete $name
            end
            # if directory doesn't exist return with error
            return 1
        end
    end

    # when run with arguments try to cd to best match immediately
    if test (count $argv) -gt 0
        set -l bmark (zummi bookmark list 2>&1 \
            | fzf --exact --no-sort --nth 1,.. --filter=$argv \
            | head -1)
        # if no result was found return with error
        test -z $bmark; and return 1
        _bookmark_cd_or_remove $bmark
        return
    end

    set -l fzf_query ''
    while true
        eval "zummi bookmark list 2>&1 | fzf $FZF_DEFAULT_OPTS --exact --nth 1,.. --info=hidden --border --reverse --no-sort --no-multi --query \"$fzf_query\" --print-query --expect del" \
            | read -l --line query key val
        # if assignment failed (CTRL-C or otherwise) return with error
        if test $status != 0
            return 1
        end

        set fzf_query $query
        set -l bmark (string trim --left $val | string split --max 1 ' ')
        set -l name $bmark[1]

        if test $key = 'del'
            read --local --nchars=1 --prompt="echo Remove bookmark \'$name\'\? [Y/n]\ " answer
            if test $answer = ''; or test $answer = 'y'; or test $answer = 'Y'
                zummi bookmark delete $name
            end
        else
            _bookmark_cd_or_remove $bmark
            return
        end
    end
end
