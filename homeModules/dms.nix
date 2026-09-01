{ pkgs, ... }:

{
  programs.dank-material-shell = {
    enable = true;
    niri = {
      enableSpawn = true; # Auto-start DMS with niri, if enabled
    };
  };
}
