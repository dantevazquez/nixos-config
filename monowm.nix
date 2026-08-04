{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    xkb = {
      layout = "us"; # Change to your layout if different
      options = "caps:escape";
    };
    windowManager.monowm = {
      enable = true;
      recommendedPackages = true;
    };
  };

  networking.wireless.iwd.enable = true;
  services.displayManager.defaultSession = "none+monowm";
  environment.systemPackages = with pkgs; [
    maim
    impala
    slop
    dmenu
    rofi
    xcolor
    xclip
  ];
}
