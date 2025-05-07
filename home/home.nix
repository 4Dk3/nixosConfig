{ config, pkgs, flake-inputs, ... }:

{

  imports = [
    ./gnome.nix
    ];

  home.username = "powr4e";
  home.homeDirectory = "/home/powr4e";
  ## DO NOT TOUCH ##
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    pavucontrol
    vscode
    android-studio
    jetbrains.idea-community-bin
    heroic
    rofi
    kdenlive
    adw-gtk3
    blueman
    colloid-gtk-theme
    colloid-icon-theme
    gnome-tweaks

    # fonts
    inter
    nerd-fonts.fira-mono
    nerd-fonts.go-mono
    nerd-fonts.iosevka
    nerd-fonts.meslo-lg
    nerd-fonts.jetbrains-mono


  ];
 
  # Flatpak Packages to be installed 
  services.flatpak.packages = [
    "com.spotify.Client"
    "md.obsidian.Obsidian"
    "dev.vencord.Vesktop"
    "org.gnome.Boxes"
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    VISUAL = "code";
    BROWSER = "firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
