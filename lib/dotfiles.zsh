# install/update/reload
function realpath() {
  OURPWD=$PWD
  cd "$(dirname "$1")"
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")"
    LINK=$(readlink "$(basename "$1")")
  done
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD"
  echo "$REALPATH"
}

defaults=$(realpath "${0:a:h}/../defaults")

case "$OSTYPE" in
   linux-gnu )
     os_excluded_path="*darwin*" ;;
   darwin* )
     os_excluded_path="*linux*" ;;
esac

function dotfiles_install() {
  $ZSHRC/lib/installers.zsh
}

function dotfiles_update() {
  $ZSHRC/lib/installers.zsh update
}

function dotfiles_reload() {
  source $HOME/.zshrc
}

function dotfiles_type_handlers() {
  find $(dotfiles) -name 'dotfiles-type-handlers.d'
}

function dotfiles_type_handlers_find() {
  find $(dotfiles_type_handlers) -name "$1" -not -path "$os_excluded_path"
}

function dotfiles_find() {
  find $(dotfiles) -name "$1" -not -path "$os_excluded_path" -not -path '*dotfiles-type-handlers.d*'
}

function dotfiles() {
  files=("$defaults")
  files+=($(find "$HOME" -maxdepth 1 -type d -name '.*dotfiles*'  -not -name '.oh-your-dotfiles' -not -name 'dotfiles-type-handlers.d'))
  echo "${files[@]}"
}

