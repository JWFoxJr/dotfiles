# Detect OS and Architecture
_z_os="$(uname -s)"
_z_arch="$(uname -m)"

# Install Oh My Zsh if not already present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

if [ ! -x "/usr/local/bin/brew" ] && \
   [ ! -x "/opt/homebrew/bin/brew" ] && \
   [ ! -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  echo "Homebrew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# macOS (Apple Silicon)
if [ "$_z_os" = "Darwin" ] && [ "$_z_arch" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

# Linux (Linuxbrew)
elif [ "$_z_os" = "Linux" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# macOS (Intel)
elif [ "$_z_os" = "Darwin" ] && [ "$_z_arch" = "x86_64" ]; then
  # Homebrew defaults to /usr/local on Intel Macs; shellenv unnecessary
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi
