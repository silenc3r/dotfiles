# Defined in /tmp/fish.NTgFdh/sub-pl.fish @ line 1
function sub-pl --description 'Download subtitles in polish'
    set --local files (ls *.{avi,mkv,mp4,webm})
    subliminal download -l pl -e utf8 $files
end
