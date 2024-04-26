#!/bin/bash

set -e

mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml/
cp /vagrant/displays.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/displays.xml

systemctl --user start x-session

# Something is resetting the display resolution after `startx` has started
#   the GUI and `xfce4` has set the display resolution to the values in:
#     `~/.config/xfce4/xfconf/xfce-perchannel-xml/displays.xml`
#
# This can be observed right here (in this script) with the follow code:
#   ```
#   for i in {1..7}; do
#     DISPLAY=:0.0 xrandr | fgrep current || true
#     sleep 1
#   done
#   ```
#
# Here is the output it produced for me:
#   ```
#   Can't open display :0.0
#   Screen 0: minimum 320 x 200, current 800 x 600, maximum 16384 x 16384
#   Screen 0: minimum 320 x 200, current 800 x 600, maximum 16384 x 16384
#   Screen 0: minimum 320 x 200, current 1600 x 900, maximum 16384 x 16384
#   Screen 0: minimum 320 x 200, current 1600 x 900, maximum 16384 x 16384
#   Screen 0: minimum 320 x 200, current 800 x 600, maximum 16384 x 16384
#   Screen 0: minimum 320 x 200, current 800 x 600, maximum 16384 x 16384
#   ```
#
# Changing the active display profile (which does show the proper values)
#   did not correct the issue.
#   ```
#   xfconf-query --channel displays --property /ActiveProfile --set Default
#   ```
#
# Let's aggressively correct the resolution for the time being.

sleep 3 && for i in {1..6}; do
  DISPLAY=:0.0 xrandr --output VGA-1 --mode 1600x900 || true
  sleep 1
done
