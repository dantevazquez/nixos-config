{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;

    xkb = {
      layout = "us"; # Change to your layout if different
      options = "caps:escape";
    };
  };
  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    XCURSOR_SIZE = "48";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SUPPRESS_RANDR_SIZE = "1";
  };

  networking.wireless.iwd.enable = true;

  environment.systemPackages = with pkgs; [
    alttab
    dunst
    sxhkd
    dmenu
    lemonbar-xft
    xclip
    feh
    maim
    slop
    xcolor
  ];
}
