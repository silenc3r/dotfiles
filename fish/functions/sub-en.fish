# Defined in /tmp/fish.PpCaFV/sub-en.fish @ line 1
function sub-en --description 'Download subtitles in english'
    set --local files (ls *.{avi,mkv,mp4,webm})
    subliminal download -l en -e utf8 $files
end
