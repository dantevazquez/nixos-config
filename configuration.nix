{
  config,
  pkgs,
  unstablePkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./bash.nix
    ./kanata.nix
    ./firewall.nix
    ./ssh.nix
    ./niri.nix
    # ./monowm.nix
    # ./hyprland.nix
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

  #security stuff
  security.polkit.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  services.fprintd.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  #services
  services.gnome.gnome-keyring.enable = true;
  services.printing.enable = true;
  services.envfs.enable = true; # make bash scripts work
  virtualisation.podman.enable = true;

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

  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "chromium";
    TERMINAL = "kitty";
  };
  programs.dconf.enable = true;

  users.users = {
    dante = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "input"
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExt+GoQ1drn+8MhoD2o6ogAXnNN1SPaHfFTdVCIcyR3 macbook"
      ];
    };

    lexi = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" ];
    };
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
    github-desktop
    nix-search-tv
    gnome-keyring
    ripgrep
    brightnessctl
    imagemagick
    impala
    bluetui
    bluez
    btop
    eza
    adwaita-icon-theme
    jq
    unzip
    python3
    yazi
    chromium
    tmux
    libnotify
    nautilus
    lazygit
    wiremix
    rsync
    localsend
    rsync
    imagemagick
    vlc
    ffmpeg-full
    unstablePkgs.antigravity-cli
    xdg-utils
    #pkgs_end
  ];

  system.stateVersion = "26.05";
}
