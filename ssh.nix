{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true; # Set to false if using SSH keys exclusively
      PermitRootLogin = "no";        # Security best practice
    };
  };
}
