# Plugins

ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  local owner="$1"
  local repo="$2"
  local plugin_path="${ZPLUGINDIR}/${repo}"
  local plugin_file="${plugin_path}/${repo}.plugin.zsh"

  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${repo}..."
    git clone --depth=1 "https://github.com/${owner}/${repo}" "$plugin_path" \
      || { echo "ERROR: failed to install ${repo}" >&2; return 1; }
  fi

  if [[ ! -r "$plugin_file" ]]; then
    echo "ERROR: plugin file not found: $plugin_file" >&2
    return 1
  fi

  source "$plugin_file"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/(N); do
    [[ -d "$dir/.git" ]] || continue
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load jeffreytse zsh-vi-mode
_zplugin_load zdharma-continuum fast-syntax-highlighting
