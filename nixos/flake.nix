{
  description = "NixOS from Scratch";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      mkHost =
        {
          hostname,
          system ? "x86_64-linux",
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            (./hosts + "/${hostname}")

            home-manager.nixosModules.home-manager

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.joe = import (./hosts + "/${hostname}/home.nix");
                backupFileExtension = "backup";
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        fusion = mkHost {
          hostname = "fusion";
          system = "aarch64-linux";
        };

        nyx = mkHost {
          hostname = "nyx";
        };

        # nightwave = mkHost {
        #   hostname = "nightwave";
        # };
        #
        # umbra = mkHost {
        #   hostname = "umbra";
        # };

      };
    };
};

