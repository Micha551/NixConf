{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      niri,
      nixvim,
      nix-cachyos-kernel,
      ...
    }:
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
    in
    {
      nixosConfigurations = {
        Kenway = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit name;
            inherit niri;
            inherit nixvim;
          };
          modules = [
            ./hosts/Kenway/configuration.nix
            ./home.nix
            ./modules/defaultPackages.nix
            ./modules/quickshell.nix
            ./modules/syncthing.nix
            ./modules/python.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-p50
            home-manager.nixosModules.home-manager
          ];
        };
        Ezio = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit name;
            inherit nix-cachyos-kernel;
            inherit niri;
            inherit nixvim;
          };
          modules = [
            ./hosts/Ezio/configuration.nix
            ./home.nix
            ./modules/defaultPackages.nix
            ./modules/cachyos-kernel.nix
            ./modules/syncthing.nix
            ./modules/python.nix
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
