{config, pkgs, ...}:

{
  environment.systemPackages = (with pkgs; [
      # Editors
      vim
      neovim
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

      # TeX
      texliveFull
      latexrun

      # Niri
      fuzzel
      xwayland-satellite
      playerctl
  ]);
}
