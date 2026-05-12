{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, nix-cachyos-kernel, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      username = "migio";
      name = "Michael Grinschewski";
    in {
      nixosConfigurations = {
        Kenway = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit name;
          };
          modules = [
          ./hosts/Kenway/configuration.nix
          ./modules/quickshell.nix
          ./modules/syncthing.nix
          ./modules/niri.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-p50
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.migio = import ./home.nix;
          }
          ];
        };
        Ezio = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit name;
            inherit nix-cachyos-kernel;
          };
          modules = [
            ./hosts/Ezio/configuration.nix
            ./modules/quickshell.nix
            ./modules/cachyos-kernel.nix
            ./modules/syncthing.nix
            ./modules/niri.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.migio = import ./home.nix;
          }
          ];
        };
      };
    };
}
