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
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      username = "migio";
      name = "Michael Grinschewski";
    in {
      nixosConfigurations = {
        P50 = lib.nixosSystem {
          inherit system;
          modules = [
          ./hosts/P50/configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-p50
          ./modules/quickshell.nix
          ./modules/greetd.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit name;
            inherit pkgs-unstable;
          };
        };
        PC = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/PC/configuration.nix
          ];
          specialArgs = {
            inherit username;
            inherit name;
          };
        };
      };
    };
}
