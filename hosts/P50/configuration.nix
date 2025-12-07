# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Nix settings
  nixpkgs.config.allowUnfree = true;

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

  
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking = {
    hostName = "P50"; # Define your hostname.
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

  # Hardware settings
  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
    nvidia = {
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Services
  services = {
    xserver = {
      xkb = {
        layout = "de";
      };
      enable = true;
      videoDrivers = ["nvidia"];
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    desktopManager.plasma6.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
    tailscale.enable = true;
  };

  console.keyMap = "de";

  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.migio = {
    isNormalUser = true;
    description = "Michael Grinschewski";
    extraGroups = [ "networkmanager" "wheel" "dialout"];
    shell = pkgs.fish;
    packages = (with pkgs; [
    ]);
  };
  # Allow unfree packages


  environment = {
    systemPackages = (with pkgs; [
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
      spotify
      obsidian
      nerd-fonts.hack
      lshw
      python3
      unzip
      pavucontrol
      brightnessctl
      ghostty
      blueman
      libgcc
      paraview

      # LSP
      clang-tools
      lua-language-server
      stylua
      nixd

      # niri
      niri
      gnome-keyring
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      fuzzel
      xwayland-satellite
      foot
      libsForQt5.qt5ct
      wezterm
      discord
      thunderbird
      moonlight-qt
      fish
    ])
    ++
    (with pkgs-unstable; [
    ]);
    plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      elisa
    ];
    variables = {
      QT_QPA_PLATFORMTHEME="qt5ct"; 
    };
  };

  qt.enable = true;
  qt.platformTheme = "qt5ct";

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    niri = {
      enable = true;
      package = pkgs.niri;
    };
    firefox.enable = true;
    fish.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
      ];
    };
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}

