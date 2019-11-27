#!/bin/zsh -e

# Take a screenshot
grim /tmp/screen_locked.png

convert /tmp/screen_locked.png -colorspace Gray /tmp/screen_locked

# Pixellate it 10x
mogrify -scale 10% -scale 1000% /tmp/screen_locked.png
# Blurry image
#mogrify -gaussian-blur 10x10 /tmp/screen_locked.png

# Lock screen displaying this image.
swaylock -i /tmp/screen_locked.png -k -l

# Turn the screen off after a delay.
#sleep 60; pgrep i3lock && xset dpms force off
