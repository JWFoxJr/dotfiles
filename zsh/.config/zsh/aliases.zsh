# Aliases

# Better ls
if (( $+commands[eza] )); then
  alias ls='eza --icons'
  alias ll='eza -lh --icons --git'
  alias la='eza -lah --icons --git'
  alias tree='eza --tree --icons'

  # Reuse ls completions for eza, if completion system is loaded
  (( $+functions[compdef] )) && compdef eza=ls
fi

# Core utilities
alias diff='diff --color=auto'
alias df='df -h'

# Navigation
alias -- -='cd -'  # -- prevents - being parsed as a flag; cd - jumps to previous directory

if (( $+commands[yazi] )); then
  # Yazi: exit into the directory you ended in
  y() {
    local tmp cwd

    tmp="$(mktemp "${TMPDIR:-/tmp}/yazi-cwd.XXXXXX")" || return

    command yazi "$@" --cwd-file="$tmp"

    if [[ -f "$tmp" ]]; then
      cwd="$(command cat "$tmp")"
      command rm -f "$tmp"

      [[ -n "$cwd" && -d "$cwd" && "$cwd" != "$PWD" ]] && cd "$cwd"
    fi
  }
fi

# Editor
(( $+commands[nvim] )) && alias vim='nvim'

# Git
alias gs='git status'
alias gss='git status --short'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gsw='git switch'
alias gsc='git switch -c'
alias gb='git branch'
alias gd='git diff'
alias gds='git diff --staged'
alias gp='git push'
alias gpl='git pull --ff-only'
alias gl='git log --oneline --decorate'
alias glo='git log --all --decorate --oneline --graph'

# Gitlab CLI
alias mr='glab mr'
alias mrc='glab mr create'
alias mrm='glab mr merge'
