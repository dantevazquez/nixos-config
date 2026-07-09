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

  environment.systemPackages = with pkgs; [
    alttab
    dunst
    sxhkd
    dmenu
    lemonbar-xft
    xclip
  ];
}
