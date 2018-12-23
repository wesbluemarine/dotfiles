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
alias reboot="systemctl reboot"
alias poweroff="systemctl poweroff"
alias gimp="flatpak run org.gimp.GIMP"
alias blender="flatpak run org.blender.Blender"
alias transmission="flatpak run com.transmissionbt.Transmission"
alias spotify="flatpak run com.spotify.Client"
#alias skype="flatpak run com.skype.Client"
alias libreoffice="flatpak run org.libreoffice.LibreOffice"
#alias vscode="flatpak run com.visualstudio.code.oss"
alias audacity="flatpak run org.audacityteam.Audacity"
alias telegram="flatpak run org.telegram.desktop"
