# ~/.config/zsh/.zshrc

# Required runtime directories
mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

# Helper for optional config files
zsource() {
  [[ -r "$1" ]] && source "$1"
}

# History
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Shell behavior
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

if [[ -o interactive ]] && [[ -z "$TMUX" ]] && (( $+commands[fastfetch] )); then
  fastfetch
fi

# Completion
autoload -Uz compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Modular config
zsource "$ZDOTDIR/fzf.zsh"
zsource "$ZDOTDIR/plugins.zsh"
zsource "$ZDOTDIR/aliases.zsh"
zsource "$ZDOTDIR/bindings.zsh"
zsource "$ZDOTDIR/prompt.zsh"

