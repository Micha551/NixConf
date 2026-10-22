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
      quarto

      # Work
      paraview

      # General Programs
      spotify
      vesktop
      thunderbird
      moonlight-qt
      octaveFull
      libreoffice
      signal-desktop
      ani-cli
      blender
      zathura
      tt
      ttyper
      gtypist

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
      tmux
      toybox
      kdePackages.kdeconnect-kde

      # TeX
      texliveFull

      # Niri
      fuzzel
      xwayland-satellite
      playerctl
    ]
  );
}
