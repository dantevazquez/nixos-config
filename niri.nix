{ pkgs, unstablePkgs, ... }:

{
  programs.niri.enable = true;

  networking.wireless.iwd.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];

    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
    };
  };

  services.upower.enable = true;

  # Packages that only Niri/Wayland will use
  environment.systemPackages = with pkgs; [
    xwayland-satellite # Required for running legacy X11 apps under Niri
    unstablePkgs.noctalia
    foot
  ];

}
