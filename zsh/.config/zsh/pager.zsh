# ~/.config/zsh/.zshrc or ~/.config/zsh/pager.zsh

if command -v bat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif command -v batcat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
else
  export MANPAGER="less -R"
fi
