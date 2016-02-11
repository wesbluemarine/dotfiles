ffmpeg -f x11grab -r 30 -s 1920x1080 -i $DISPLAY -vcodec libx264 -preset ultrafast -threads 0 output.mkv


