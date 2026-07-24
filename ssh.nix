{ config, pkgs, ... }:

{
  services.logind.settings = {
    Login = {
      HandleLidSwitch = "ignore";
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false; # Set to false if using SSH keys exclusively
      PermitRootLogin = "no"; # Security best practice
    };
  };
}
