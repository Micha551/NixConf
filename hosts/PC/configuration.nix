# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, pkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Nix settings

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Bootloader
  boot.loader = {
    efi = {
        canTouchEfiVariables = true;
    };
    grub = {
        enable = true;
        efiSupport = true;
        #efiInstallAsRemovable = true;
        device = "nodev";
    };
  };
  boot.kernelParams = [ "video=HDMI-A-1:1920x1080@144.001" ];

  # Networking
  networking = {
    hostName = "MiGiPC"; # Define your hostname.
    networkmanager.enable = true;
  };

  # Timezone & Locale
  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Services
  services = {
    xserver = {
      xkb = {
        layout = "de";
      };
      enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    udev.extraRules = ''

    # 2.4GHz/Dongle
    KERNEL=="hidraw*", ATTRS{idVendor}=="2dc8", MODE="0666"

    # Bluetooth
    KERNEL=="hidraw*", KERNELS=="*2DC8:*", MODE="0666"
    '';

    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    tailscale.enable = true;
  };

  console.keyMap = "de";

  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.migio = {
    isNormalUser = true;
    description = "Michael Grinschewski";
    extraGroups = [ "networkmanager" "wheel" "dialout" "lp"];
    shell = pkgs-unstable.fish;
    packages = (with pkgs-unstable; [
    ]);
  };
  # Allow unfree packages


  environment = {
    systemPackages = (with pkgs-unstable; [
      # general stuff
      vim
      wget
      neovim
      git
      fastfetch
      btop
      lua
      gcc
      clang
      obsidian
      nerd-fonts.hack
      lshw
      python3
      unzip
      pavucontrol
      brightnessctl
      ghostty
      libgcc
      paraview
      wezterm
      vesktop
      thunderbird
      moonlight-qt
      fish
      vlc
      octaveFull
      libreoffice
      signal-desktop
      anki
      blender
      vscode
      rocmPackages.rocm-smi

      # TeX
      texliveFull
      latexrun

      # LSP
      clang-tools
      lua-language-server
      stylua
      nixd
      ripgrep

      # niri
      niri
      fuzzel
      xwayland-satellite
      playerctl
    ]);

    # Set environment variables
    variables = {
    };

    # Exclude unneeded plasma pkgs
    plasma6.excludePackages = with pkgs-unstable; [
      kdePackages.elisa # Simple music player aiming to provide a nice experience for its users
      kdePackages.kdepim-runtime # Akonadi agents and resources
      kdePackages.kmahjongg # KMahjongg is a tile matching game for one or two players
      kdePackages.kmines # KMines is the classic Minesweeper game
      kdePackages.konversation # User-friendly and fully-featured IRC client
      kdePackages.kpat # KPatience offers a selection of solitaire card games
      kdePackages.ksudoku # KSudoku is a logic-based symbol placement puzzle
      kdePackages.konsole
    ];
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      package = pkgs-unstable.steam;
    };
    niri = {
      enable = true;
      package = pkgs-unstable.niri;
    };
    firefox.enable = true;
    fish.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs-unstable; [
      ];
    };
  };
  system.stateVersion = "25.11"; # Did you read the comment?
}
