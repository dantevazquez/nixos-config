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
    ./ssh.nix
    # ./gnome.nix
    # ./hyprland.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking
  networking.hostName = "nixos"; # Define your hostname.
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_US.UTF-8";
  hardware.bluetooth.enable = true;

  virtualisation.podman.enable = true;
  #security stuff
  security.polkit.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  #services
  services.gnome.gnome-keyring.enable = true;
  services.printing.enable = true;
  services.envfs.enable = true; # make bash scripts work

  #power profile daemon
  services.power-profiles-daemon.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.enableRedistributableFirmware = true;
  systemd.tmpfiles.rules = [
    "L+ /etc/chromium/policies/managed/color.json - - - - /home/dante/.config/theme-monos/current/chromium_policy.json"
  ];
  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chromium";
    TERMINAL = "kitty";
  };
  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  users.users."dante" = {
    isNormalUser = true;
    description = "dante";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExt+GoQ1drn+8MhoD2o6ogAXnNN1SPaHfFTdVCIcyR3 macbook"
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
    bash-language-server
    shfmt
    fd
    fzf
    polkit_gnome
    j4-dmenu-desktop
    nix-search-tv
    gnome-keyring
    ripgrep
    brightnessctl
    imagemagick
    impala
    bluetui
    bluez
    btop
    adwaita-icon-theme
    kitty
    fastfetch
    jq
    unzip
    python3
    yazi
    spotify
    chromium
    tmux
    libnotify
    alacritty
    lazygit
    wiremix
    rsync
    localsend
    rsync
    imagemagick
    vlc
    ffmpeg-full
    unstable.antigravity-cli
    xdg-utils
    #pkgs_end
  ];

  system.stateVersion = "26.05";
}
