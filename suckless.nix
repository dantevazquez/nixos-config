{ lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    dpi = 240;
    displayManager.startx.enable = true;
    xkb = {
      layout = "us";
      options = "caps:escape";
    };
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ./src/lwm;
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
  };

  systemd.user.services.xdg-desktop-portal-gnome.environment = {
    GDK_DPI_SCALE = "1.5";
    GTK_THEME = "catppuccin-frappe-green-standard";
  };

  environment.systemPackages = with pkgs; [
    maim
    slop
    picom
    dunst
    dmenu
    xcolor
    xclip
    xwallpaper
    (catppuccin-gtk.override {
      accents = [ "green" ];
      variant = "frappe";
    })
    catppuccin-papirus-folders
    glib
  ];
}
