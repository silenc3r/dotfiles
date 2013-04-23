#!/bin/sh

# eval `cat $HOME/.fehbg` &                       # set wallpaper
# xbindkeys &                                     # launch xbindkeys
# xset +fp /usr/share/fonts/local/ &
# xset +fp /usr/share/fonts/TTF &
# xset +fp /usr/share/fonts/misc &
# xset +fp /usr/share/fonts/artwiz-fonts &
# xset +fp /home/silencer/.fonts/tamsynmod &
# xset +fp /home/silencer/.fonts/helvetica &
# xset +fp /home/silencer/.fonts/Garamond\ Premier\ \(pro\) &
# xset +fp /home/silencer/.fonts/Gill\ Sans\ Pro &
# xset +fp /home/silencer/.fonts/Neo\ Sans &
# xset +fp /home/silencer/.fonts/Lucida.Grande &
# (sleep 1 && xset fp rehash) &
# xset s 1200 1200 &                            # set monitor to sleep 20 mins
xset +dpms &
xset dpms 0 0 300 &
xset s 300 300 &
# xrdb ~/.config/Xresources &
# (sleep 2 && /usr/bin/urxvtd -q -o -f) &
#unclutter &

# mpd &
# 
# pidof mpdscribble >& /dev/null                  # enable mpd lastfm scrobbling
# if [ $? -ne 0 ]; then
#     (sleep 5 && mpdscribble) &
# fi

synclient TouchpadOff=1 &

# set the cursor
xsetroot -cursor_name left_ptr &
setxkbmap -layout "pl(intl)" -option "caps:swapescape" &
exec xmonad
# exec openbox
#wm_bin="$1"
#exec ${wm_bin}
