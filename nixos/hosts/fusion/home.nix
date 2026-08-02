{ config, pkgs, ... }:

{
  home = {
    username = "joe";
    homeDirectory = "/home/joe";
    stateVersion = "26.05";
    packages = with pkgs; [
      tree
      bat
      yazi
      tmux
      tlrc
      btop
      neovim
      pay-respects
      ghostty
      fastfetch
      stow
      starship
      fzf
      ripgrep
      eza
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
