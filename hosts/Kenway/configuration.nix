# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
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
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking = {
    hostName = "Kenway"; # Define your hostname.
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 25565 ];
    };
  };

  # Timezone & Locale
  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
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
    bluetooth = {
      enable = true;
    };
    nvidia = {
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime.offload.enable = false;
      prime.sync.enable = true;
    };
  };

  # Services
  services = {
    xserver = {
      xkb = {
        layout = "de";
      };
      enable = true;
      videoDrivers = [ "nvidia" ];
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

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };

    spotifyd = {
      enable = true;
    };

    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sessionPackages = [ pkgs.niri ];
    pulseaudio.enable = false;
    logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
    tailscale.enable = true;
    blueman.enable = true;
  };
  /*
    # Virtualization
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.qemu.swtpm.enable = true;
  */

  console.keyMap = "de";
  security = {
    rtkit.enable = true;
    sudo.package = pkgs.sudo.override { withInsults = true; };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.migio = {
    isNormalUser = true;
    description = "Michael Grinschewski";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "lp"
    ];
    shell = pkgs.fish;
    packages = (
      with pkgs;
      [
      ]
    );
  };

  environment = {
    systemPackages = (
      with pkgs;
      [
      ]
    );

    # Set environment variables
    variables = {
    };

    # Exclude unneeded plasma pkgs
    plasma6.excludePackages = with pkgs; [
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
    };
    firefox.enable = true;
    fish.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
      ];
    };
    niri.settings = {
      outputs = {
        "eDP-1" = {
          scale = 2.0;
          mode = {
            height = 2160;
            width = 3840;
            refresh = 59.997;
          };
          position.x = 0;
          position.y = 0;
        };
        "DP-6" = {
          scale = 1.0;
          mode = {
            height = 1080;
            width = 1920;
            refresh = 144;
          };
          position.x = 1920;
          position.y = 0;
        };
      };
    };
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
