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

    xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
  };

  users.users.joe = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  programs = {
    firefox.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    arandr
    curl
    feh
    git
    i3status
    networkmanagerapplet
    pavucontrol
    rofi
    wget
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

  system.stateVersion = "26.05";
}
