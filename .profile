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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

alias suspend="systemctl suspend"
alias logout="pkill xinit"
alias reboot="systemctl reboot"
alias poweroff="systemctl poweroff"
alias mitology="mpv  --profile=pseudo-gui http://onair15.xdevel.com:9120/;"
alias steam="flatpak run com.valvesoftware.Steam"
alias blender="flatpak run org.blender.Blender"
alias jitsi="~/.local/bin/jitsi-meet-x86_64.AppImage --no-sandbox"
alias octoprint="~/OctoPrint/venv/bin/octoprint serve"
