#!/bin/sh

# original script found on http://community.wd.com/t5/WD-My-Cloud/Guide-Auto-removal-of-downloads-from-transmission-2-82/td-p/759286

# port, username, password
# SERVER="127.0.0.1:9091 --auth transmission:transmission"
SERVER=""

# get torrent ids
TORRENTLIST=`transmission-remote $SERVER --list | awk 'NR>2 { print x } { x=$1 }'`

for TORRENTID in $TORRENTLIST; do
    # check if torrent download is completed
    DL_COMPLETED=`transmission-remote $SERVER --torrent $TORRENTID --info | grep "Percent Done: 100%"`
    if [ "$DL_COMPLETED" ]; then
        # check torrent current state
        STATE_STOPPED=`transmission-remote $SERVER --torrent $TORRENTID --info | grep "State: Seeding\|Stopped\|Finished\|Idle"`
        if [ "$STATE_STOPPED" ]; then
            # echo "deleting number #$TORRENTID"
            transmission-remote $SERVER --torrent $TORRENTID --remove
        fi
    fi
done
