#! /bin/bash

source ~/.bashrc
## D-Bus ##
if which dbus-launch >/dev/null && test -z \"$DBUS_SESSION_BUS_ADDRESS\"; then
        eval \"$(dbus-launch --sh-syntax --exit-with-session)\"
fi

## clean-up conky deamon ##
#killall conky &
#killall conkyd &

## trackpad ## tapbutton off by default ##
if egrep -iq 'touchpad' /proc/bus/input/devices; then
    synclient VertTwoFingerScroll=1
    synclient HorizTwoFingerScroll=1
    synclient TapButton1=0
fi

## read ~.Xresources file ##
xrdb -merge ~/.Xresources

## enable snap font ##
# xset fp+ /usr/share/fonts/artwiz_fonts/artwiz-latin1/
# xset fp rehash
#############Add more lines for fonts like termsyn here ########


## launch screensaver ##
xscreensaver-command -exit
xscreensaver -no-splash &

## set cursor ##
xsetroot -cursor_name left_ptr

## set ctrl_alt_bksp as session-killer ##
setxkbmap -option terminate:ctrl_alt_bksp

## startup-wall - customize your start-screen ##
# feh --no-xinerama --bg-fill </path/to/wallpaper/foo.png>

#-----------------------------------------------------------------------

## launch spectrwm ##
exec ck-launch-session spectrwm
