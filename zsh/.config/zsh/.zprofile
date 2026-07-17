# Homebrew on Apple Silicon macOS
if [[ "$OSTYPE" == darwin* && -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi
