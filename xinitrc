#!/bin/sh

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"

# xbindkeys &
# xset +fp /home/silencer/.fonts/tamsynmod &
# (sleep 1 && xset fp rehash) &
xset +dpms &
xset dpms 0 0 300 &
xset s 300 300 &
# xrdb ~/.config/Xresources &
# (sleep 2 && /usr/bin/urxvtd -q -o -f) &   # termite is better

# mpd &
# 
# pidof mpdscribble >& /dev/null      # enable mpd lastfm scrobbling
# if [ $? -ne 0 ]; then
#     (sleep 5 && mpdscribble) &
# fi


(sleep 5 && SpiderOak &)

synclient TouchpadOff=1 &
nitrogen --restore &
xsetroot -cursor_name left_ptr &
setxkbmap -layout "pl(intl)" \
    -option "caps:swapescape" \
    -option "terminate:ctrl_alt_bksp" &
exec xmonad
# exec openbox
