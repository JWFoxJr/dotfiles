# ~/.config/fish/config.fish

# -----------------------------
# PATH
# -----------------------------
# zsh:
#   export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
#
# fish_add_path avoids duplicates and keeps this idempotent.
fish_add_path ~/bin
fish_add_path ~/.local/bin
fish_add_path /usr/local/bin

# -----------------------------
# Environment variables
# -----------------------------
# zsh:
#   export HOMEBREW_NO_ENV_HINTS=1
#   export EDITOR=nvim
#   export VISUAL=nvim
#   export SUDO_EDITOR=nvim
#   export EZA_CONFIG_DIR="$HOME/.config/eza"

set -gx HOMEBREW_NO_ENV_HINTS 1
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SUDO_EDITOR nvim
set -gx EZA_CONFIG_DIR "$HOME/.config/eza"

# -----------------------------
# Prompt
# -----------------------------
# Powerlevel10k and Oh My Zsh do not apply to fish.
# fish has its own prompt system, and Starship works well if you want it.
#
# If using Starship:
# if command -q starship
#     starship init fish | source
# end

# -----------------------------
# eza
# -----------------------------
# Your zsh config used the Oh My Zsh eza plugin:
#
#   zstyle ':omz:plugins:eza' 'git-status' yes
#   zstyle ':omz:plugins:eza' 'dirs-first' yes
#   zstyle ':omz:plugins:eza' 'header' yes
#   zstyle ':omz:plugins:eza' 'icons' yes
#
# In fish, define the aliases directly.
# Adjust these if your preferred flags differ.

if command -q eza
    alias ls='eza --icons --group-directories-first --header --git'
    alias ll='eza -lah --icons --group-directories-first --header --git'
    alias la='eza -la --icons --group-directories-first --header --git'
    alias l='eza -lah --icons --group-directories-first --header --git'
end

# -----------------------------
# yazi: move to CWD when exiting yazi
# -----------------------------
# zsh function converted to fish syntax.
#
# zsh:
#   function y() {
#       local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
#       yazi "$@" --cwd-file="$tmp"
#       if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
#           builtin cd -- "$cwd"
#       fi
#       rm -f -- "$tmp"
#   }

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"

    set cwd (command cat -- "$tmp" 2>/dev/null)

    if test -n "$cwd"; and test "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end

    rm -f -- "$tmp"
end

# -----------------------------
# bat / less
# -----------------------------
# zsh:
#   alias less=bat

if command -q bat
    alias less='bat'
end

# -----------------------------
# thefuck
# -----------------------------
# zsh:
#   eval $(thefuck --alias)
#
# fish uses source instead of eval.
# Guard it so shell startup does not fail if thefuck is unavailable.

if command -q thefuck
    thefuck --alias | source
end

# -----------------------------
# man pages through bat
# -----------------------------
# zsh:
#   export MANPAGER="sh -c 'awk ... | bat -p -lman'"
#
# This can remain mostly identical as an exported variable.

if command -q bat
    set -gx MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"
end

# -----------------------------
# fzf
# -----------------------------
# zsh:
#   eval "$(fzf --zsh)"
#
# fish:
#   fzf --fish | source
#
# This depends on your fzf version. Recent fzf supports --fish.

if command -q fzf
    fzf --fish | source
end

# Catppuccin-ish fzf colors from your zsh config.
set -gx FZF_DEFAULT_OPTS "\
--color=spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

# Use fd instead of fzf defaults.
if command -q fd
    set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"
end

# -----------------------------
# fzf-git
# -----------------------------
# Your zsh config had:
#
#   source ~/.fzf-git/fzf-git.sh
#
# That file is probably bash/zsh-oriented and may not be fish-compatible.
# Do not source it blindly in fish.
#
# If ~/.fzf-git has a fish-native file, source that instead, for example:
#
#   source ~/.fzf-git/fzf-git.fish
#
# Guarded version:

if test -f ~/.fzf-git/fzf-git.fish
    source ~/.fzf-git/fzf-git.fish
end

# -----------------------------
# zoxide
# -----------------------------
# zsh:
#   eval "$(zoxide init zsh)"
#   alias cd="z"
#
# In fish, source the fish init output.
# If you want zoxide to replace cd directly, use:
#   zoxide init fish --cmd cd | source
#
# That is cleaner than alias cd="z".

if command -q zoxide
    zoxide init fish --cmd cd | source
end

# -----------------------------
# sudoedit
# -----------------------------
# zsh:
#   alias se='sudo -e'

alias se='sudo -e'
