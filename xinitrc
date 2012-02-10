#!/bin/sh

eval `cat $HOME/.fehbg` &                       # set wallpaper
xbindkeys &                                     # launch xbindkeys
(sleep 2 && xset +fp /usr/share/fonts/local/) &               # add local fonts
xset +fp /usr/share/fonts/TTF &               # add local fonts
xset +fp /usr/share/fonts/misc &               # add local fonts
xset +fp /usr/share/fonts/artwiz-fonts &        # add local fonts
xset fp rehash &
xset s 1200 1200 &                              # set monitor to sleep 20 mins
sh /home/silencer/bin/trackpad-toggle &
xrdb ~/.config/Xresources &
/usr/bin/urxvtd -q -o -f &
#unclutter &

mpd &

pidof mpdscribble >& /dev/null                 # enable mpd lastfm scrobbling
if [ $? -ne 0 ]; then
    (sleep 5 && mpdscribble) &
fi

# set the cursor
xsetroot -cursor_name left_ptr &
# set Polish keyboard layout
setxkbmap -layout pl &
#wm_bin="$1"
exec xmonad
#exec ${wm_bin}
