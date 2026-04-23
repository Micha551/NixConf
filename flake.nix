{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nixos-hardware, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      pkgs = nixpkgs.legacyPackages.${system};
      username = "migio";
      name = "Michael Grinschewski";
    in {
      nixosConfigurations = {
        P50 = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit name;
          };
          modules = [
          ./hosts/P50/configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-p50
          ./modules/quickshell.nix
          ];
        };
        PC = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/PC/configuration.nix
            ./modules/quickshell.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit name;
          };
        };
      };
    };
}
