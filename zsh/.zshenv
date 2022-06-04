# Environment Setup
LOCAL_ENV="$HOME/.zshenv.local"

export GOPATH="$HOME/go"
export CARGO_HOME="$HOME/.cargo"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export PATH="$PATH:$HOME/.bin:$HOME/.yarn/bin:$GOPATH/bin"

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

export TERMINAL=/usr/bin/foot
export LANG=en_GB.UTF-8
export EDITOR='nvim'

export SOURCE_LANG=en
export TARGET_LANG=pt

. "$HOME/.cargo/env"
