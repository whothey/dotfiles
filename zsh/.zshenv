# Environment Setup
LOCAL_ENV="$HOME/.zshenv.local"

export GOPATH="$HOME/go"
export CARGO_HOME="$HOME/.cargo"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:./node_modules/.bin"
export PATH="$PATH:$HOME/.bin:$HOME/.yarn/bin"

optional_paths=("$GOPATH" "$CARGO_HOME")

for pathvar in $optional_paths; do
  echo "trying $pathvar..."
  if [[ -d "$pathvar" ]]; then
    export PATH="$PATH:$pathvar/bin"
  fi
done;

optional_envs=("$LOCAL_ENV")

for envvar in $optional_envs; do
  echo "trying $envvar..."
  if [[ -f "$envvar" ]]; then
    source "$envvar"
  fi
done;

export TERMINAL=/usr/bin/foot
export LANG=en_GB.UTF-8
export EDITOR='nvim'

export SOURCE_LANG=en
export TARGET_LANG=pt
