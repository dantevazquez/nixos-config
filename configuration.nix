{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./bash.nix
    ./kanata.nix
    ./xserver.nix
    ./firewall.nix
    # ./ssh.nix
    # ./hyprland.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.iwd.enable = true;
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_US.UTF-8";
  hardware.bluetooth.enable = true;

  #security stuff
  security.polkit.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  #services
  services.gnome.gnome-keyring.enable = true;
  services.printing.enable = true;
  services.envfs.enable = true; # make bash scripts work

  #power profile daemon
  services.power-profiles-daemon.enable = true;
  
  #when plugged use balanced, when unplugged use power saver
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${pkgs.systemd}/bin/systemd-run --no-block --collect ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
    SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${pkgs.systemd}/bin/systemd-run --no-block --collect ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
  '';

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chromium";
    TERMINAL = "alacritty";
  };


  users.users."dante" = {
    isNormalUser = true;
    description = "dante";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  #fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    #pkgs_start
    github-cli
    neovim
    nixd
    nixfmt
    wget
    git
    fd
    fzf
    polkit_gnome
    gnome-keyring
    ripgrep
    brightnessctl
    imagemagick
    impala
    xdg-desktop-portal-gtk
    bluetui
    bluez
    btop
    chromium
    kitty
    jq
    unzip
    yazi
    tmux
    libnotify
    alacritty
    wiremix
    rsync
    localsend
    unstable.antigravity-cli
    #pkgs_end
  ];

  system.stateVersion = "26.05";
}
