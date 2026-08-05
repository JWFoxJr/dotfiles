{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nyx"; # Define your hostname.
    networkmanager.enable = true;
    firewall.enable = false;
    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
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
    qemuGuest.enable = true;
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joe = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  programs = {
    firefox.enable = true;
    zsh.enable = true;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
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

  };
  system.stateVersion = "26.05";

}
