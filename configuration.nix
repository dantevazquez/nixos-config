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
    # ./niri.nix
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
  networking.wireless.iwd.enable = true;
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

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
    alacritty
    fzf
    polkit_gnome
    nix-search-tv
    gnome-keyring
    ripgrep
    brightnessctl
    imagemagick
    impala
    bluetui
    bluez
    btop
    google-chrome
    eza
    ueberzugpp
    adwaita-icon-theme
    jq
    unzip
    python3
    yazi
    tmux
    libnotify
    lazygit
    wiremix
    chromium
    tree-sitter
    gcc
    rsync
    imagemagick
    vlc
    clang-tools
    ffmpeg-full
    xdg-utils
    #pkgs_end
  ];

  system.stateVersion = "26.05";
}
