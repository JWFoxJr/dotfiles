# fzf

# Load fzf's zsh integration so widgets like fzf-history-widget exist.
if (( $+commands[fzf] )); then
  if fzf --zsh >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
  elif [[ -r /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  elif [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
  fi
fi

if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# UI
export FZF_DEFAULT_OPTS='
  --height=60%
  --layout=reverse
  --border=rounded
  --prompt="  "
  --pointer="  "
  --preview-window=right:65%:wrap:border-left
'

if (( $+commands[bat] )); then
  export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 -- {}'
else
  export _FZF_PREVIEW_CMD='head -n 500 -- {}'
fi

export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"

# Ctrl+F widget: file picker excluding hidden files
_fzf_file_no_hidden() {
  local result

  if (( $+commands[fd] )); then
    result=$(
      fd --type f --strip-cwd-prefix --exclude .git |
        fzf --preview "$_FZF_PREVIEW_CMD"
    )
  else
    result=$(
      find . -type f -not -path '*/.*' |
        fzf --preview "$_FZF_PREVIEW_CMD"
    )
  fi

  if [[ -n "$result" ]]; then
    LBUFFER+="${(q)result}"
  fi

  zle reset-prompt
}

zle -N _fzf_file_no_hidden
