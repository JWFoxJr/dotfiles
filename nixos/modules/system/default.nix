{ pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time.timeZone = "America/New_York";

  hardware.graphics.enable = true;

  services = {
    displayManager.ly.enable = true;

    openssh.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    xrdp = {
      enable = true;
      defaultWindowManager = "i3";
    };
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
  };

  programs = {
    firefox.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    zsh.enable = true;
  };

  users.users.joe = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    arandr
    curl
    feh
    flameshot
    git
    grim
    hyprlock
    i3blocks
    i3status
    networkmanagerapplet
    nwg-displays
    pavucontrol
    rofi-wayland
    slurp
    waybar
    wget
    wl-clipboard
    xclip
    xsel
    zsh
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  security.rtkit.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
