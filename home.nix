{config, pkgs, ...}:

{
  home.username = "migio";
  home.homeDirectory = "/home/migio";

  programs.emacs = {
    enable = true;
  };

  home.stateVersion = "25.11";
}
