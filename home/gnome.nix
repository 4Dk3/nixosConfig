{ pkgs, ... }:

{
  
  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
  ];
  
  gtk = {
   iconTheme = {
      name = "Colloid-dark";
      package = pkgs.colloid-icon-theme;
    };
  
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "adw-gtk3";

  dconf = {
    settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "foot.desktop"
        "org.gnome.Nautilus.desktop"
      ];
      enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 6;
    };

    "org/gnome/mutter" = {
      workspaces-only-on-primary = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
     
      move-to-workspace-1 = ["<Super><Alt>1"];
      move-to-workspace-2 = ["<Super><Alt>2"];
      move-to-workspace-3 = ["<Super><Alt>3"];
      move-to-workspace-4 = ["<Super><Alt>4"];
      move-to-workspace-5 = ["<Super><Alt>5"];
      move-to-workspace-6 = ["<Super><Alt>6"];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      volume-up = ["<Super>F3"];
      volume-down = ["<Super>F2"];
      volume-mute = ["<Super>F1"];
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      };
    };
  };
}
