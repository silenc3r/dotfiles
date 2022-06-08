function reddit-dl --description 'Download video from reddit and recode it to mp4'
    set -l fname (command yt-dlp --get-filename $argv[1])
    command yt-dlp $argv
    set -l fname2 (echo $fname | sed -e 's/\.[^.]*$//' -e 's/$/_2/')
    ffmpeg -i $fname -movflags faststart -pix_fmt yuv420p -crf 18 -preset slow -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" $fname2.mp4
    echo $fname2
    rm $fname
end
