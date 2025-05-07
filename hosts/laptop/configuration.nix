{ config, pkgs, ... }:

{
  imports =
    [ 
     ./hardware-configuration.nix
    ];

  # Enabling flakes
  #nix.settings.experimental-features = [ "nix-command" "flakes"];


  # Auto-update and Auto-Cleaning
  system.autoUpgrade = {
      enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes"];
    };
  };

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 



  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel = {
      sysctl = { "vm.swappiness" = 20; };
    };

    #LQX
    #kernelPackages = pkgs.linuxPackages_lqx;
    #Default Kernel
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "powr4e";
    networkmanager = {
      enable = true;
    };
  };

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT = "es_CO.UTF-8";
    LC_MONETARY = "es_CO.UTF-8";
    LC_NAME = "es_CO.UTF-8";
    LC_NUMERIC = "es_CO.UTF-8";
    LC_PAPER = "es_CO.UTF-8";
    LC_TELEPHONE = "es_CO.UTF-8";
    LC_TIME = "es_CO.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.powr4e = {
    isNormalUser = true;
    description = "powr4e";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" "vboxusers"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

############################
######## DESKTOP ###########
############################

# Packages for plasma to work/have my config

  programs = {
    java.enable = true;
    steam = {
  	  enable = true;
  	  remotePlay.openFirewall = true;
  	  dedicatedServer.openFirewall = true;
    };
    
    gamemode.enable = true;
    fish.enable = true;
    light.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };



    # Enable window managers (Wayland)
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };

  #security.pam.services.gdm.enableGnomeKeyring = true;
  
  # Enable necessary services such as pipewire

  hardware.bluetooth.enable = true;

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    printing.enable = true;
    power-profiles-daemon.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    dbus.enable = true;

    udev.extraHwdb = ''
evdev:input:b0003v0C45pA512*
 KEYBOARD_KEY_70039=leftmeta

evdev:atkbd:dmi:*            
 KEYBOARD_KEY_3a=leftmeta
  '';




    # Libinput
   
    # Disable mouse acceleration
      libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        };
      };



    # Sound

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # X11 Activation, Display and Plasma

    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      
      # gnome
      displayManager = {
        gdm = {
          enable = true;
          };
        };
      desktopManager.gnome.enable = true;

    };
  };

  # Disable pulse hardware
  services.pulseaudio.enable = false;

  # Virtualbox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  #virtualisation.virtualbox.guest.enable = true;
  users.extraGroups.vboxusers.members = [ "powr4e" ];
  virtualisation.virtualbox.host.enableKvm = false;


############################
####### PACKAGES ###########
############################

environment.systemPackages = with pkgs; [
    home-manager
    firefox
    chromium
    neovim
    wget
    git
    tmux
    neofetch
    fastfetch
    alacritty
    pavucontrol
    docker
    python3Full
    vulkan-loader
    vulkan-headers
    vulkan-validation-layers
    wineWowPackages.staging
    pamixer
    inter
    htop
    jdk
    netbeans
    obs-studio
    spicetify-cli
    xdg-utils
    spicetify-cli
    distrobox
    glib
    eww
    gcc
    playerctl

    #Fish
    fishPlugins.pure

    #Sway
    swaybg
    waybar
    wofi
    mako
  ];


#################################
  ######## Services ###############
  #################################


  # XDG Variables
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
  };

  # Udev Config
  #services.udev.extraHwdb = ''
#evdev:input:b0003v0C45pA512*
# KEYBOARD_KEY_70039=leftmeta

#evdev:atkbd:dmi:*            
# KEYBOARD_KEY_3a=leftmeta
#  '';

  # Docker
  virtualisation.docker.enable = true;
  
  # Enable dbus
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  # Dri
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
      ];

    };
  cpu.intel.updateMicrocode = true;
  };
  
  # Media codecs for fastest video playback
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

 






################################################################################
################################ DON'T TOUCH ###################################
################################################################################





  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
