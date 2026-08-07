{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/default.nix
  ];

  networking.hostName = "nyx";

  services.qemuGuest.enable = true;
}
