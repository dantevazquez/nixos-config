{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment and GDM Display Manager.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # GNOME specific system packages and utilities
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
  ];

  networking.networkmanager.enable = true;
  # Optional: Exclude default GNOME packages to keep it minimal
  # environment.gnome.excludePackages = with pkgs; [
  #   gnome-tour
  #   gnome-connections
  #   geary # email client
  #   epiphany # web browser
  # ];
}
