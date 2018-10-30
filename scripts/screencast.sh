ffmpeg -y -f -i -r 60 -f x11grab -s 1920x1080 -i {$DISPLAY} -c:v libx264rgb -crf 0 -preset:v ultrafast -c:a pcm_s16le -af aresample=async=1:first_pts=0 screencast.mk

