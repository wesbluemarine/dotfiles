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

alias suspend="systemctl suspend"
alias logout="killall xinit"
alias reboot="systemctl reboot"
alias poweroff="systemctl poweroff"
alias st="~/.stterm-0.6/st -e tmux"
alias nmanager="~/.script/networkmanager-dmenu/networkmanager_dmenu  -fn "iosevka:pixelsize=12""
alias audacity="~/.local/bin/Audacity_with_FLAC_for_JACK-7dbbeba-x86_64.AppImage"
alias blender="~/.local/bin/Blender-2.78c.glibc2.17-x86_64.AppImage"
alias cura="~/.local/bin/Ultimaker_Cura-3.6.0.AppImage"
alias gimp="~/.local/bin/GIMP_AppImage-release-2.10.8-withplugins-x86_64.AppImage"
alias webcam="mpv av://v4l2:/dev/video0" 
alias vscode="~/.local/bin/Visual_Studio_Code-1.30.1-1545156774.glibc2.17-x86_64.AppImage"
alias screencast="ffmpeg -y -f -i -r 60 -f x11grab -s 1920x1080 -i {$DISPLAY} -c:v libx264rgb -crf 0 -preset:v ultrafast -c:a pcm_s16le -af aresample=async=1:first_pts=0 -y ~/Videos/screencast.mkv"
alias screencastaudio="ffmpeg -video_size 1920x1080 -framerate 60 -thread_queue_size 512 -f x11grab -i :0.0+0,0 -thread_queue_size 512 -f pulse -ac 2 -ar 48000 -i alsa_input.usb-046d_081d_43561990-00.analog-mono -thread_queue_size 512 -f pulse -ac 2 -ar 48000 -i alsa_output.pci-0000_00_1f.3.hdmi-stereo.monitor -filter_complex amix=inputs=2 -vcodec libx264rgb -crf 18 -preset:v ultrafast -acodec libmp3lame -ar 48000 -q:a 1 -pix_fmt yuv420p -y ~/Videos/screencastaudio.mkv"
