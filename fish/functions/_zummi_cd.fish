function _zummi_cd --description "Jump to directory with zummi and fzf"
    function _dir_cd_or_remove
        if not cd $argv
            read --local --nchars=1 --prompt-str='Remove path from database? [Y/n] ' answer
            if test $answer = ''; or test $answer = 'y'; or test $answer = 'Y'
                zummi dir delete $argv
            end
            # if directory doesn't exist return with error
            return 1
        end
    end

    # when run with arguments try to cd to best match immediately
    if test (count $argv) -gt 0
        set -l path (zummi dir list 2>&1 \
            | fzf --no-sort --nth 2.. --filter=$argv \
            | head -1 \
            | string replace -r '^[[:space:]]*[[:digit:]]+[,.]{1}[[:digit:]]+[[:space:]]+' '')
        # if no matching path was found return with error
        test -z $path; and return 1
        _dir_cd_or_remove $path
        return
    end

    set -l fzf_query ''
    while true
        eval "zummi dir list 2>&1 | fzf --height 40% --nth 2.. --info=hidden --border --reverse --no-sort --no-multi --query \"$fzf_query\" --print-query --expect del" \
            | read -l --line query key val
        # if assignment failed (CTRL-C or otherwise) return with error
        if test $status != 0
            return 1
        end

        set fzf_query $query
        set -l path (string replace -r '^[[:space:]]*[[:digit:]]+[,.]{1}[[:digit:]]+[[:space:]]+' '' $val)

        if test $key = 'del'
            read --local --nchars=1 --prompt="echo Delete entry \'$path\'\? [Y/n]\ " answer
            if test $answer = ''; or test $answer = 'y'; or test $answer = 'Y'
                zummi dir delete $path
            end
        else
            _dir_cd_or_remove $path
            return
        end
    end
end
