{ pkgs, ... }:

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
      nil
      nixfmt
      nodejs
      pay-respects
      pkg-config
      python3
      ripgrep
      starship
      statix
      stow
      tlrc
      tmux
      tree
      unzip
      vivaldi
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
    neovim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
    };
  };
}
