#!/usr/bin/env bash

NOTE_DIR="${NOTE_DIR:-$(dirname "${BASH_SOURCE[0]}")}"
TRASH_DIR="$NOTE_DIR/trash"
FZF_DEFAULT_COMMAND='fd --type f --follow --exclude trash'
export NORENAME=1
cd "$NOTE_DIR"

delete() {
    echo -n "Delete $1? (y/n) "
    read yn
    if [[ "$yn" =~ ^y ]]; then
        mkdir -p "$TRASH_DIR"
        mv "$NOTE_DIR/${1}" "$TRASH_DIR"
    fi
}

query="$*"
opts='--reverse --no-hscroll --no-multi --ansi --print-query --tiebreak=index --preview-window=bottom:70%:wrap'
while [ 1 ]; do
    out=$(
        fzf --preview='cat {}' $opts --expect=alt-d,alt-n --query="$query" \
            --header=$'ALT-N: new | ALT-D: delete\n')

    # 2: Error / 130: Interrupt
    (( $? % 128 == 2 )) && exit 1

    query=$(head -1 <<< "$out")
    [ $(wc -l <<< "$out") -lt 2 ] && continue

    newkey=$(head -2 <<< "$out" | tail -1)
    file=$(tail -1 <<< "$out")
    case "$newkey" in
        alt-d) delete "$file" ;;
        alt-n) [ -n "$query" ] && "$EDITOR" "$NOTE_DIR/${query}.md" ;;
        *)     [ -n "$file" ] && "$EDITOR" "$NOTE_DIR/${file}" ;;
    esac
done
