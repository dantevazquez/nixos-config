{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./zsh.nix
    ./kanata.nix
    ./firewall.nix
    ./suckless.nix
    ./ssh.nix
    ./packages.nix
    # ./niri.nix
    # ./monowm.nix
    # ./xserver.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking
  networking.hostName = "nixos"; # Define your hostname.
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_US.UTF-8";
  hardware.bluetooth.enable = true;
  networking.wireless.iwd.enable = true;

  #security stuff
  security.polkit.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  services.fprintd.enable = true;

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
  services.dbus.enable = true;
  programs.dconf.enable = true;
  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chromium";
    TERMINAL = "alacritty";
  };

  users.users = {
    dante = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "input"
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHg+K1yITPJ1SFA+/4IcfGcmDXkT14KMegNsksk6TaV macbook"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
