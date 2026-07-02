{ pkgs, ... }:

{
  environment.systemPackages = (
    with pkgs;
    [
      # Editors
      vim
      lua
      obsidian
      vscode

      # LSP
      clang-tools
      lua-language-server
      stylua
      nixd
      ripgrep
      nixfmt

      # Coding
      gcc
      libgcc
      clang
      git
      python3

      # Work
      paraview

      # General Programs
      spotify
      spotifyd
      vesktop
      thunderbird
      moonlight-qt
      octaveFull
      libreoffice
      signal-desktop
      ani-cli
      blender
      zathura

      # System Tools
      fish
      wget
      wezterm
      fastfetch
      btop
      unzip
      pavucontrol
      brightnessctl
      lshw
      nerd-fonts.hack
      vlc
      openvpn

      # TeX
      texliveFull

      # Niri
      fuzzel
      xwayland-satellite
      playerctl
    ]
  );
}
