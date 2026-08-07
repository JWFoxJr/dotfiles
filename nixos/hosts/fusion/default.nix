{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/default.nix
  ];

  networking.hostName = "fusion";

  virtualisation.vmware = {
    guest.enable = true;
    guest.headless = false;
  };
}
