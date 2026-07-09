{ config, pkgs, ... }:

{
  # Open the firewall ports LocalSend needs to discover devices
  networking.firewall = {
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };
}
