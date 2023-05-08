#!/bin/sh
picom -b
xinput set-prop "MSFT0001:01 2808:0101 Touchpad" "libinput Tapping Enabled" 1
# This command will close all active conky
# killall conky
# sleep 2s
		
# Only the config listed below will be avtivated
# if you want to combine with another theme, write the command here
# conky -c $HOME/.config/conky/Mintaka/Mintaka.conf &> /dev/null &

# exit
