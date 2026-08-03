{ config, pkgs, ... }:

{
  home = {
    username = "joe";
    homeDirectory = "/home/joe";
    stateVersion = "26.05";
    packages = with pkgs; [
      bat
      btop
      deno
      eza
      fastfetch
      fzf
      gcc
      ghostty
      gnumake
      neovim
      nodejs
      pay-respects
      pkg-config
      python3
      ripgrep
      starship
      stow
      tlrc
      tmux
      tree
      unzip
      yazi
      zoxide
    ];
  };
  programs = {
    git.enable = true;
    zsh = {
      enable = true;
      shellAliases = {
        btw = "echo I use NixOS, btw";
      };
    };
  };
}
