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

alias nmanager="~/.script/networkmanager-dmenu/networkmanager_dmenu  -fn "iosevka:pixelsize=14""
alias suspend="systemctl suspend"
alias logout="killall xinit"
alias reboot="systemctl reboot"
alias poweroff="systemctl poweroff"
alias audacity="~/.local/bin/Audacity_with_FLAC_for_JACK-7dbbeba-x86_64.AppImage"
alias blender="~/.local/bin/Blender-2.78c.glibc2.17-x86_64.AppImage"
alias cura="~/.local/bin/Ultimaker_Cura-3.6.0.AppImage"
alias gimp="~/.local/bin/GIMP_AppImage-release-2.10.8-withplugins-x86_64.AppImage"
alias webcam="mpv av://v4l2:/dev/video0"
alias screencast="ffmpeg -y -f -i -r 60 -f x11grab -s 1920x1080 -i {$DISPLAY} -c:v libx264rgb -crf 0 -preset:v ultrafast -c:a pcm_s16le -af aresample=async=1:first_pts=0 screencast.mkv"
