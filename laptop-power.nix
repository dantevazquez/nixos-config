{ config, pkgs, ... }:
{
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${pkgs.systemd}/bin/systemd-run --no-block --collect ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
    SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${pkgs.systemd}/bin/systemd-run --no-block --collect ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
  '';

}
