#!/bin/sh

# Remove torrents after completion

transmission-remote --torrent $TR_TORRENT_ID --remove
