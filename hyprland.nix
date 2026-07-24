{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  services.displayManager.ly.enable = true;

  networking.wireless.iwd.enable = true;
  # Packages that only Hyprland/Wayland will use
  environment.systemPackages = with pkgs; [

    wayfreeze
    fuzzel
    wl-clipboard
    foot
    mako
    swayosd
    grim
    hypridle
    hyprland
    hyprlock
    hyprpaper
    hyprpicker
    slurp
  ];
}
