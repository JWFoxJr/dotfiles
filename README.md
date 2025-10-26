# 🧠 JWFoxJr Dotfiles

Personal dotfiles managed with **GNU Stow** and organized in an **XDG-compliant** directory structure.  
Each application (e.g. `nvim`, `zsh`, `wezterm`, `tmux`, etc.) is a self-contained “stow package.”

---

## 🗂️ Repository Layout

```
dotfiles/
├── git/                    →   ~/.gitconfig
├── nvim/.config/nvim/      →   ~/.config/nvim/
├── thefuck/.config/thefuck →   ~/.config/thefuck/
├── tmux/.config/tmux/      →   ~/.config/tmux/
│   ├── plugins/            (managed as Git submodules)
│   └── .tmux.conf          →   ~/.tmux.conf
├── wezterm/.wezterm.lua    →   ~/.wezterm.lua
├── yazi/.config/yazi/      →   ~/.config/yazi/
├── zsh/.zshrc, .zprofile, .p10k.zsh
├── .gitmodules
└── .stow-local-ignore
```

Each top-level directory corresponds to one *stowable module*.

---

## 🧰 Prerequisites

1. Install **GNU Stow**:

   **macOS**
   ```bash
   brew install stow
   ```

   **Debian / Ubuntu / Mint**
   ```bash
   sudo apt install stow
   ```

   **Fedora / RHEL / Rocky / Alma**
   ```bash
   sudo dnf install stow
   ```

2. Clone this repository (with submodules):

   ```bash
   git clone --recurse-submodules https://github.com/JWFoxJr/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

---

## 🚀 Usage

### Stow *everything*
Symlink **all** managed configs into your home directory:
```bash
stow --target=$HOME */
```

### Un-stow *everything*
Remove all symlinks created by Stow:
```bash
stow --target=$HOME -D */
```

> 💡 Tip: The trailing `*/` expands to all top-level package directories (`git/`, `nvim/`, `zsh/`, etc.).

---

### Stow an individual package
Example: only link your Neovim setup
```bash
stow --target=$HOME nvim
```

### Un-stow an individual package
Example: remove only the Neovim symlinks
```bash
stow --target=$HOME -D nvim
```

You can repeat this for any package (`wezterm`, `zsh`, `tmux`, etc.).

---

## 🔄 Updating Submodules

If you update or add tmux plugins (tracked as Git submodules):

```bash
git submodule update --init --recursive
git submodule foreach git pull origin main
```

---

## 🧩 Stow Ignore Rules

`.stow-local-ignore` prevents Stow from linking unwanted files such as `.git`, `.gitmodules`, and plugin directories.  
Typical contents:
```
.git/
.gitmodules
README.md
LICENSE
```

---

## 💡 Tips

- Run `stow -n` (“dry run”) to preview symlink actions:
  ```bash
  stow -n --target=$HOME zsh
  ```

- To restow (force re-link after updates):
  ```bash
  stow --restow --target=$HOME nvim
  ```

- To deploy on a new machine, just clone and:
  ```bash
  stow --target=$HOME */
  ```

---

## 🧠 License

MIT License © JWFoxJr

---

> _“All systems calibrated, Operator.”_ — Ordis
