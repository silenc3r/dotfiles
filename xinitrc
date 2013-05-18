#!/bin/sh

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"

# xbindkeys &                                     # launch xbindkeys
# xset +fp /home/silencer/.fonts/tamsynmod &
# xset +fp /home/silencer/.fonts/helvetica &
# xset +fp /home/silencer/.fonts/Garamond\ Premier\ \(pro\) &
# xset +fp /home/silencer/.fonts/Gill\ Sans\ Pro &
# xset +fp /home/silencer/.fonts/Neo\ Sans &
# xset +fp /home/silencer/.fonts/Lucida.Grande &
# (sleep 1 && xset fp rehash) &
xset +dpms &
xset dpms 0 0 300 &
xset s 300 300 &
# xrdb ~/.config/Xresources &
# (sleep 2 && /usr/bin/urxvtd -q -o -f) &   # termite is better
#unclutter &                                # termite takes care of it

# mpd &
# 
# pidof mpdscribble >& /dev/null                  # enable mpd lastfm scrobbling
# if [ $? -ne 0 ]; then
#     (sleep 5 && mpdscribble) &
# fi

synclient TouchpadOff=1 &

(sleep 5 && SpiderOak &)

# set the cursor
xsetroot -cursor_name left_ptr &
nitrogen --restore &
setxkbmap -layout "pl(intl)" -option "caps:swapescape" &
exec xmonad
# exec openbox
#wm_bin="$1"
#exec ${wm_bin}
