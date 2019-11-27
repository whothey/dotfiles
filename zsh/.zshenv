# Environment Setup

LOCAL_ENV="$HOME/.zshenv.local"

export GOPATH=`go env GOPATH`

# .oh-my-zsh default
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

# My PATH Updates
export PATH="$PATH:$HOME/.composer/vendor/bin:$HOME/.cargo/bin:$HOME/.bin:$HOME/anaconda3/bin:$HOME/.yarn/bin:$GOPATH/bin"

export CARGO_HOME="$HOME/.cargo"

if [[ $XDG_SESSION_TYPE = wayland ]]; then
  export ECORE_EVAS_ENGINE=wayland_egl
  export ELM_ENGINE=wayland_egl

  export SDL_VIDEODRIVER=wayland
  export QT_WAYLAND_FORCE_DPI=physical
  export QT_QPA_PLATFORM=wayland
  export GDK_BACKEND=wayland
  export CLUTTER_BACKEND=wayland
  export _JAVA_AWT_WM_NONREPARENTING=1
fi;

if [[ -f $LOCAL_ENV ]]; then
  source $LOCAL_ENV
fi

export TERMINAL=/usr/bin/urxvtc
export SOURCE_LANG=en
export TARGET_LANG=pt

export XKB_DEFAULT_LAYOUT=br
export XKB_DEFAULT_VARIANT=,nodeadkeys
export XKB_DEFAULT_OPTIONS=caps:internal,
