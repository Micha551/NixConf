{
  inputs,
  niri,
  nixvim,
  ...
}:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.sharedModules = [
    niri.homeModules.niri
    nixvim.homeModules.nixvim
  ];
  home-manager.users.migio = {
    home.username = "migio";
    home.homeDirectory = "/home/migio";
    home.stateVersion = "25.11";
    imports = [
      ./modules/niri.nix
      ./modules/nixvim.nix
    ];
  };
}
