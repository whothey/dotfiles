#!/bin/zsh -e

# Take a screenshot and blurrify image
grim - | convert - \
  -blur 0x8 \
  -colorspace Gray \
  /tmp/screen_locked.png

# Lock screen displaying this image.
swaylock -kli /tmp/screen_locked.png && rm /tmp/screen_locked.png
