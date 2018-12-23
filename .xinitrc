xsetroot -solid "#696969" &
~/.script/dwm_status &
~/.script/clipmenu/clipmenud &

while true; do
    # Log stderror to a file 
    ~/.dwm/dwm 2> ~/.dwm.log
    # No error logging
    #~/.dwm/dwm >/dev/null 2>&1
done
