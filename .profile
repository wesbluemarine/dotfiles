# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

alias dwm_status="~/.script/dwm_status"
alias suspend="systemctl suspend"
alias logout="killall xinit"
alias reboot="systemctl reboot"
alias poweroff="systemctl poweroff"
alias st="~/.st-0.8.2/st -e tmux"
alias nmanager="~/.script/networkmanager-dmenu/networkmanager_dmenu  -fn "terminus:pixelsize=13""
alias firefox="~/.local/bin/firefox/firefox"
alias mitology="mpv  --profile=pseudo-gui http://onair15.xdevel.com:9120/;"
alias cura="~/.local/bin/Cura-4.0.0-BETA.AppImage"
alias icesl="~/.local/bin/icesl/bin/IceSL-slicer"
alias webcam="mpv av://v4l2:/dev/video0" 
alias screencast="ffmpeg -y -f -i -r 60 -f x11grab -s 1920x1080 -i {$DISPLAY} -c:v libx264rgb -crf 0 -preset:v ultrafast -c:a pcm_s16le -af aresample=async=1:first_pts=0 -y /tmp/out.mkv; mv --backup=t /tmp/out.mkv ~/Videos/out.mkv"
alias screencastmultiaudio="ffmpeg -video_size 1920x1080 -framerate 60 -thread_queue_size 512 -f x11grab -i :0.0+0,0 -thread_queue_size 512 -f pulse -ac 2 -ar 48000 -i alsa_input.usb-046d_081d_43561990-00.analog-mono -thread_queue_size 512 -f pulse -ac 2 -ar 44100 -i alsa_output.pci-0000_00_1f.3.hdmi-stereo.monitor -filter_complex amix=inputs=2 -vcodec libx264rgb -crf 18 -preset:v ultrafast -acodec libmp3lame -ar 44100 -q:a 1 -pix_fmt yuv420p -y /tmp/out.mkv; mv --backup=t /tmp/out.mkv ~/Videos/out.mkv"
alias screencastaudio="ffmpeg -video_size 1920x1080 -framerate 60 -thread_queue_size 512 -f x11grab -i :0.0+0,0 -thread_queue_size 512 -f pulse -ac 2 -ar 44100 -i alsa_output.pci-0000_00_1f.3.hdmi-stereo.monitor -vcodec libx264rgb -crf 18 -preset:v ultrafast -acodec libmp3lame -ar 44100 -q:a 1 -pix_fmt yuv420p -y /tmp/out.mkv; mv --backup=t /tmp/out.mkv ~/Videos/out.mkv"
