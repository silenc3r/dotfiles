# Defined in /tmp/fish.XTJDlw/m.fish @ line 2
function m
    set -l res (fd . /mnt/storage/{Music,music_unsorted}/ --type f --print0 \
                --extension mp3 \
                --extension flac \
                --extension opus \
                --extension aac \
                --extension ogg \
                --extension m4a \
                --extension ape \
                | fzf --read0)
                # | fzf --read0 --print0)
    if test -z "$res"
        return 1
    end

    set -l cmd "mpv \"$res\""
    commandline -- $cmd
end
