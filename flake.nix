{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-old, nixpkgs-unstable, ... }:
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-old = nixpkgs-old.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      username = "migio";
      name = "Michael Grinschewski";
    in {
      nixosConfigurations = {
        P50 = lib.nixosSystem {
          inherit system;
          modules = [
          ./hosts/P50/configuration.nix
          ./modules/quickshell.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit name;
            inherit pkgs-old;
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
            inherit pkgs-old;
          };
        };
      };
    };
}
